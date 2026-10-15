-- ============================================================
-- Classless WotLK - All Achievements Patch
-- File: 0008_classless_achievements.sql
-- Description: Grant all achievements to all classless characters
-- ============================================================

-- Drop existing procedure if it exists
DROP PROCEDURE IF EXISTS `classless_grant_all_achievements`;

-- Create a procedure to grant all achievements to a character
DELIMITER //
CREATE PROCEDURE `classless_grant_all_achievements`(IN `char_guid` INT UNSIGNED)
BEGIN
    -- Grant all achievements to this character
    -- This includes all achievement categories and individual achievements
    
    -- Clear existing achievements for this character
    DELETE FROM `character_achievement` WHERE `guid` = `char_guid`;
    
    -- Grant all achievements
    INSERT IGNORE INTO `character_achievement` (`guid`, `achievement`, `date`)
    SELECT `char_guid`, `id`, UNIX_TIMESTAMP()
    FROM `achievement_template`
    WHERE `id` > 0;
    
    -- Grant all achievement points
    INSERT IGNORE INTO `character_achievement_points` (`guid`, `points`)
    VALUES (`char_guid`, 1000);  -- Max achievement points
END //
DELIMITER ;

-- Apply to all existing classless characters
DELIMITER //
CREATE PROCEDURE `classless_grant_all_achievements_to_all`()
BEGIN
    DECLARE `done` INT DEFAULT FALSE;
    DECLARE `char_id` INT UNSIGNED;
    DECLARE `char_cursor` CURSOR FOR SELECT `guid` FROM `characters` WHERE `class` = 0;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET `done` = TRUE;

    OPEN `char_cursor`;

    read_loop: LOOP
        FETCH `char_cursor` INTO `char_id`;
        IF `done` THEN
            LEAVE `read_loop`;
        END IF;
        CALL `classless_grant_all_achievements`(`char_id`);
    END LOOP;

    CLOSE `char_cursor`;
END //
DELIMITER ;

-- Execute the procedure
CALL `classless_grant_all_achievements_to_all`();

-- Drop procedures after execution
-- DROP PROCEDURE IF EXISTS `classless_grant_all_achievements`;
-- DROP PROCEDURE IF EXISTS `classless_grant_all_achievements_to_all`;

-- ============================================================
-- End of 0008_classless_achievements.sql
-- ============================================================
