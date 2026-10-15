-- ============================================================
-- Classless WotLK - All Mounts Patch
-- File: 0005_classless_mounts.sql
-- Description: Grant all mounts to all classless characters
-- ============================================================

-- Drop existing procedure if it exists
DROP PROCEDURE IF EXISTS `classless_grant_all_mounts`;

-- Create a procedure to grant all mounts to a character
DELIMITER //
CREATE PROCEDURE `classless_grant_all_mounts`(IN `char_guid` INT UNSIGNED)
BEGIN
    -- Grant all mount spells (mounts are learned via spells in WotLK)
    -- This includes all ground mounts, flying mounts, and special mounts
    
    -- Clear existing mounts for this character
    DELETE FROM `character_spell` WHERE `guid` = `char_guid` AND `spell` IN (
        SELECT `id` FROM `spell` WHERE `spell_family_name` = 'Mount'
    );
    
    -- Grant all ground mounts
    INSERT IGNORE INTO `character_spell` (`guid`, `spell`, `active`, `disabled`, `SpecGroup`, `SpecId`)
    SELECT `char_guid`, `id`, 1, 0, 0, 0
    FROM `spell`
    WHERE `spell_family_name` = 'Mount'
    AND `spell_family_group` = 1  -- Ground mounts
    AND `id` NOT IN (
        SELECT `spell` FROM `character_spell` WHERE `guid` = `char_guid`
    );
    
    -- Grant all flying mounts
    INSERT IGNORE INTO `character_spell` (`guid`, `spell`, `active`, `disabled`, `SpecGroup`, `SpecId`)
    SELECT `char_guid`, `id`, 1, 0, 0, 0
    FROM `spell`
    WHERE `spell_family_name` = 'Mount'
    AND `spell_family_group` = 2  -- Flying mounts
    AND `id` NOT IN (
        SELECT `spell` FROM `character_spell` WHERE `guid` = `char_guid`
    );
    
    -- Grant all special mounts (mounts from events, achievements, etc.)
    INSERT IGNORE INTO `character_spell` (`guid`, `spell`, `active`, `disabled`, `SpecGroup`, `SpecId`)
    SELECT `char_guid`, `id`, 1, 0, 0, 0
    FROM `spell`
    WHERE `spell_family_name` = 'Mount'
    AND `spell_family_group` = 3  -- Special mounts
    AND `id` NOT IN (
        SELECT `spell` FROM `character_spell` WHERE `guid` = `char_guid`
    );
    
    -- Grant all riding skills (required for mounts)
    INSERT IGNORE INTO `character_skills` (`guid`, `skill`, `value`, `max`)
    VALUES
    (`char_guid`, 762, 525, 525),  -- Riding (ground mount skill)
    (`char_guid`, 763, 525, 525),  -- Expert Riding
    (`char_guid`, 764, 525, 525),  -- Artisan Riding
    (`char_guid`, 765, 525, 525),  -- Master Riding (flying)
    (`char_guid`, 1850, 525, 525), -- Epic Mount Skill
    (`char_guid`, 39360, 525, 525), -- Epic Flying
    (`char_guid`, 34090, 525, 525), -- Swift Flying
    (`char_guid`, 34091, 525, 525), -- Swift Ground Mount
    (`char_guid`, 34092, 525, 525), -- Epic Ground Mount
    (`char_guid`, 34093, 525, 525); -- Epic Flying Mount
    
    -- Grant all mount-related items to character inventory (if needed)
    -- This is optional as mounts are typically learned via spells
END //
DELIMITER ;

-- Apply to all existing classless characters
DELIMITER //
CREATE PROCEDURE `classless_grant_all_mounts_to_all`()
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
        CALL `classless_grant_all_mounts`(`char_id`);
    END LOOP;

    CLOSE `char_cursor`;
END //
DELIMITER ;

-- Execute the procedure
CALL `classless_grant_all_mounts_to_all`();

-- Drop procedures after execution
-- DROP PROCEDURE IF EXISTS `classless_grant_all_mounts`;
-- DROP PROCEDURE IF EXISTS `classless_grant_all_mounts_to_all`;

-- ============================================================
-- End of 0005_classless_mounts.sql
-- ============================================================
