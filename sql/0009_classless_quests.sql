-- ============================================================
-- Classless WotLK - All Quests Patch
-- File: 0009_classless_quests.sql
-- Description: Grant all quests and reputation to all classless characters
-- ============================================================

-- Drop existing procedure if it exists
DROP PROCEDURE IF EXISTS `classless_grant_all_quests`;

-- Create a procedure to grant all quests to a character
DELIMITER //
CREATE PROCEDURE `classless_grant_all_quests`(IN `char_guid` INT UNSIGNED)
BEGIN
    -- Grant all quests to this character (completed)
    -- This includes all quests in WotLK
    
    -- Clear existing quests for this character
    DELETE FROM `character_queststatus` WHERE `guid` = `char_guid`;
    
    -- Grant all quests as completed
    INSERT IGNORE INTO `character_queststatus` (`guid`, `quest`, `status`, `explored`, `timetocomplete`, `flags`, `playerbits`)
    SELECT `char_guid`, `id`, 1, 1, 0, 0, ''
    FROM `quest_template`
    WHERE `id` > 0;
    
    -- Grant all reputation factions (max reputation)
    INSERT IGNORE INTO `character_reputation` (`guid`, `faction`, `standing`, `flags`)
    VALUES
    (`char_guid`, 1, 42700, 0),   -- Orgrimmar
    (`char_guid`, 2, 42700, 0),   -- Stormwind
    (`char_guid`, 3, 42700, 0),   -- Undercity
    (`char_guid`, 4, 42700, 0),   -- Ironforge
    (`char_guid`, 5, 42700, 0),   -- Thunder Bluff
    (`char_guid`, 6, 42700, 0),   -- Silvermoon
    (`char_guid`, 7, 42700, 0),   -- Darnassus
    (`char_guid`, 8, 42700, 0),   -- Exodar
    (`char_guid`, 9, 42700, 0),   -- Mag'har
    (`char_guid`, 10, 42700, 0),  -- The Sha'tar
    (`char_guid`, 11, 42700, 0),  -- The Ascended
    (`char_guid`, 12, 42700, 0),  -- The Kalu'ak
    (`char_guid`, 13, 42700, 0),  -- The Kurenai
    (`char_guid`, 14, 42700, 0),  -- The Mag'har (alternate)
    (`char_guid`, 15, 42700, 0),  -- The Netherwing
    (`char_guid`, 16, 42700, 0),  -- The Ogri'la
    (`char_guid`, 17, 42700, 0),  -- The Sha'tari Skyguard
    (`char_guid`, 18, 42700, 0),  -- The Sha'tari Skyguard (alternate)
    (`char_guid`, 19, 42700, 0),  -- The Wyrmrest Accord
    (`char_guid`, 20, 42700, 0),  -- The Wyrmrest Accord (alternate)
    (`char_guid`, 21, 42700, 0),  -- The Kirin Tor
    (`char_guid`, 22, 42700, 0),  -- The Kirin Tor (alternate)
    (`char_guid`, 23, 42700, 0),  -- The Sons of Lothar
    (`char_guid`, 24, 42700, 0),  -- The Sons of Lothar (alternate)
    (`char_guid`, 25, 42700, 0),  -- The Argent Crusade
    (`char_guid`, 26, 42700, 0),  -- The Argent Crusade (alternate)
    (`char_guid`, 27, 42700, 0),  -- The Ashen Verdict
    (`char_guid`, 28, 42700, 0),  -- The Ashen Verdict (alternate)
    (`char_guid`, 29, 42700, 0),  -- The Hand of Vengeance
    (`char_guid`, 30, 42700, 0),  -- The Hand of Vengeance (alternate)
    (`char_guid`, 31, 42700, 0),  -- The Frostborn
    (`char_guid`, 32, 42700, 0),  -- The Frostborn (alternate)
    (`char_guid`, 33, 42700, 0),  -- The Valarjar
    (`char_guid`, 34, 42700, 0),  -- The Valarjar (alternate)
    (`char_guid`, 35, 42700, 0),  -- The Invictus
    (`char_guid`, 36, 42700, 0),  -- The Invictus (alternate)
    (`char_guid`, 37, 42700, 0),  -- The Knights of the Ebon Blade
    (`char_guid`, 38, 42700, 0),  -- The Knights of the Ebon Blade (alternate)
    (`char_guid`, 39, 42700, 0),  -- The Deathstalkers
    (`char_guid`, 40, 42700, 0),  -- The Deathstalkers (alternate)
    (`char_guid`, 41, 42700, 0),  -- The Scourge
    (`char_guid`, 42, 42700, 0),  -- The Scourge (alternate)
    (`char_guid`, 43, 42700, 0),  -- The Forsaken
    (`char_guid`, 44, 42700, 0),  -- The Forsaken (alternate)
    (`char_guid`, 45, 42700, 0),  -- The Horde
    (`char_guid`, 46, 42700, 0),  -- The Horde (alternate)
    (`char_guid`, 47, 42700, 0),  -- The Alliance
    (`char_guid`, 48, 42700, 0),  -- The Alliance (alternate)
    (`char_guid`, 49, 42700, 0),  -- The Neutral
    (`char_guid`, 50, 42700, 0);  -- The Neutral (alternate)
END //
DELIMITER ;

-- Apply to all existing classless characters
DELIMITER //
CREATE PROCEDURE `classless_grant_all_quests_to_all`()
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
        CALL `classless_grant_all_quests`(`char_id`);
    END LOOP;

    CLOSE `char_cursor`;
END //
DELIMITER ;

-- Execute the procedure
CALL `classless_grant_all_quests_to_all`();

-- Drop procedures after execution
-- DROP PROCEDURE IF EXISTS `classless_grant_all_quests`;
-- DROP PROCEDURE IF EXISTS `classless_grant_all_quests_to_all`;

-- ============================================================
-- End of 0009_classless_quests.sql
-- ============================================================
