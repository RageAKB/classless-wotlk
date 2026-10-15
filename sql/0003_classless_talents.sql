-- ============================================================
-- Classless WotLK - All Talents Patch
-- File: 0003_classless_talents.sql
-- Description: Grant all talent trees and talents to classless characters
-- ============================================================

-- Drop existing procedure if it exists
DROP PROCEDURE IF EXISTS `classless_grant_all_talents`;

-- Create a procedure to grant all talents to a character
DELIMITER //
CREATE PROCEDURE `classless_grant_all_talents`(IN `char_guid` INT UNSIGNED)
BEGIN
    -- Grant all talent points (max talent points in WotLK)
    -- Each talent tree can have up to 75 points, total 75 points
    -- We'll grant all possible talent combinations
    
    -- First, clear existing talents for this character
    DELETE FROM `character_talent` WHERE `guid` = `char_guid`;
    
    -- Insert all possible talents for all classes
    -- This includes all talent IDs from the dbc_talent table
    INSERT IGNORE INTO `character_talent` (`guid`, `talentId`, `SpecGroup`, `SpecId`)
    SELECT `char_guid`, `id`, 0, 0
    FROM `talent`
    WHERE `id` > 0;
    
    -- Grant all talent tree points (max 75 per tree for each class)
    -- This is handled by the character_talent table entries above
    
    -- Grant all glyph slots (WotLK introduced glyphs)
    INSERT IGNORE INTO `character_glyphs` (`guid`, `talentGroup`, `SpecGroup`, `SpecId`, `GlyphSlot0`, `GlyphSlot1`, `GlyphSlot2`, `GlyphSlot3`, `GlyphSlot4`, `GlyphSlot5`, `GlyphSlot6`)
    VALUES (`char_guid`, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
END //
DELIMITER ;

-- Apply to all existing classless characters
DELIMITER //
CREATE PROCEDURE `classless_grant_all_talents_to_all`()
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
        CALL `classless_grant_all_talents`(`char_id`);
    END LOOP;

    CLOSE `char_cursor`;
END //
DELIMITER ;

-- Execute the procedure
CALL `classless_grant_all_talents_to_all`();

-- Drop procedures after execution
-- DROP PROCEDURE IF EXISTS `classless_grant_all_talents`;
-- DROP PROCEDURE IF EXISTS `classless_grant_all_talents_to_all`;

-- ============================================================
-- End of 0003_classless_talents.sql
-- ============================================================
