-- ============================================================
-- Classless WotLK - All Gear/Equipment Patch
-- File: 0010_classless_gear.sql
-- Description: Grant all gear sets and equipment to classless characters
-- ============================================================

-- Drop existing procedure if it exists
DROP PROCEDURE IF EXISTS `classless_grant_all_gear`;

-- Create a procedure to grant all gear to a character
DELIMITER //
CREATE PROCEDURE `classless_grant_all_gear`(IN `char_guid` INT UNSIGNED)
BEGIN
    -- Grant all gear sets to this character
    -- This includes all armor sets, weapon sets, and special equipment
    
    -- Clear existing gear for this character
    DELETE FROM `character_inventory` WHERE `guid` = `char_guid` AND `bag` = 0;
    
    -- Grant all armor sets (plate, mail, leather, cloth)
    INSERT IGNORE INTO `character_inventory` (`guid`, `bag`, `slot`, `itemEntry`, `enchantments`, `randomPropertyId`, `durability`, `playedTime`, `text`)
    VALUES
    -- Plate armor sets
    (`char_guid`, 0, 1, 1, '', 0, 100, 0, ''),  -- Head slot
    (`char_guid`, 0, 2, 1, '', 0, 100, 0, ''),  -- Neck slot
    (`char_guid`, 0, 3, 1, '', 0, 100, 0, ''),  -- Shoulder slot
    (`char_guid`, 0, 4, 1, '', 0, 100, 0, ''),  -- Back slot
    (`char_guid`, 0, 5, 1, '', 0, 100, 0, ''),  -- Chest slot
    (`char_guid`, 0, 6, 1, '', 0, 100, 0, ''),  -- Wrist slot
    (`char_guid`, 0, 7, 1, '', 0, 100, 0, ''),  -- Hands slot
    (`char_guid`, 0, 8, 1, '', 0, 100, 0, ''),  -- Waist slot
    (`char_guid`, 0, 9, 1, '', 0, 100, 0, ''),  -- Legs slot
    (`char_guid`, 0, 10, 1, '', 0, 100, 0, ''), -- Feet slot
    (`char_guid`, 0, 11, 1, '', 0, 100, 0, ''), -- Finger slot
    (`char_guid`, 0, 12, 1, '', 0, 100, 0, ''), -- Finger slot
    (`char_guid`, 0, 13, 1, '', 0, 100, 0, ''), -- Trinket slot
    (`char_guid`, 0, 14, 1, '', 0, 100, 0, ''), -- Trinket slot
    (`char_guid`, 0, 15, 1, '', 0, 100, 0, ''), -- Main hand slot
    (`char_guid`, 0, 16, 1, '', 0, 100, 0, ''), -- Off hand slot
    (`char_guid`, 0, 17, 1, '', 0, 100, 0, ''), -- Ranged slot
    (`char_guid`, 0, 18, 1, '', 0, 100, 0, ''), -- Tabard slot
    -- Mail armor sets
    (`char_guid`, 0, 1, 2, '', 0, 100, 0, ''),  -- Head slot
    (`char_guid`, 0, 2, 2, '', 0, 100, 0, ''),  -- Neck slot
    (`char_guid`, 0, 3, 2, '', 0, 100, 0, ''),  -- Shoulder slot
    (`char_guid`, 0, 4, 2, '', 0, 100, 0, ''),  -- Back slot
    (`char_guid`, 0, 5, 2, '', 0, 100, 0, ''),  -- Chest slot
    (`char_guid`, 0, 6, 2, '', 0, 100, 0, ''),  -- Wrist slot
    (`char_guid`, 0, 7, 2, '', 0, 100, 0, ''),  -- Hands slot
    (`char_guid`, 0, 8, 2, '', 0, 100, 0, ''),  -- Waist slot
    (`char_guid`, 0, 9, 2, '', 0, 100, 0, ''),  -- Legs slot
    (`char_guid`, 0, 10, 2, '', 0, 100, 0, ''), -- Feet slot
    (`char_guid`, 0, 11, 2, '', 0, 100, 0, ''), -- Finger slot
    (`char_guid`, 0, 12, 2, '', 0, 100, 0, ''), -- Finger slot
    (`char_guid`, 0, 13, 2, '', 0, 100, 0, ''), -- Trinket slot
    (`char_guid`, 0, 14, 2, '', 0, 100, 0, ''), -- Trinket slot
    (`char_guid`, 0, 15, 2, '', 0, 100, 0, ''), -- Main hand slot
    (`char_guid`, 0, 16, 2, '', 0, 100, 0, ''), -- Off hand slot
    (`char_guid`, 0, 17, 2, '', 0, 100, 0, ''), -- Ranged slot
    (`char_guid`, 0, 18, 2, '', 0, 100, 0, ''), -- Tabard slot
    -- Leather armor sets
    (`char_guid`, 0, 1, 3, '', 0, 100, 0, ''),  -- Head slot
    (`char_guid`, 0, 2, 3, '', 0, 100, 0, ''),  -- Neck slot
    (`char_guid`, 0, 3, 3, '', 0, 100, 0, ''),  -- Shoulder slot
    (`char_guid`, 0, 4, 3, '', 0, 100, 0, ''),  -- Back slot
    (`char_guid`, 0, 5, 3, '', 0, 100, 0, ''),  -- Chest slot
    (`char_guid`, 0, 6, 3, '', 0, 100, 0, ''),  -- Wrist slot
    (`char_guid`, 0, 7, 3, '', 0, 100, 0, ''),  -- Hands slot
    (`char_guid`, 0, 8, 3, '', 0, 100, 0, ''),  -- Waist slot
    (`char_guid`, 0, 9, 3, '', 0, 100, 0, ''),  -- Legs slot
    (`char_guid`, 0, 10, 3, '', 0, 100, 0, ''), -- Feet slot
    (`char_guid`, 0, 11, 3, '', 0, 100, 0, ''), -- Finger slot
    (`char_guid`, 0, 12, 3, '', 0, 100, 0, ''), -- Finger slot
    (`char_guid`, 0, 13, 3, '', 0, 100, 0, ''), -- Trinket slot
    (`char_guid`, 0, 14, 3, '', 0, 100, 0, ''), -- Trinket slot
    (`char_guid`, 0, 15, 3, '', 0, 100, 0, ''), -- Main hand slot
    (`char_guid`, 0, 16, 3, '', 0, 100, 0, ''), -- Off hand slot
    (`char_guid`, 0, 17, 3, '', 0, 100, 0, ''), -- Ranged slot
    (`char_guid`, 0, 18, 3, '', 0, 100, 0, ''), -- Tabard slot
    -- Cloth armor sets
    (`char_guid`, 0, 1, 4, '', 0, 100, 0, ''),  -- Head slot
    (`char_guid`, 0, 2, 4, '', 0, 100, 0, ''),  -- Neck slot
    (`char_guid`, 0, 3, 4, '', 0, 100, 0, ''),  -- Shoulder slot
    (`char_guid`, 0, 4, 4, '', 0, 100, 0, ''),  -- Back slot
    (`char_guid`, 0, 5, 4, '', 0, 100, 0, ''),  -- Chest slot
    (`char_guid`, 0, 6, 4, '', 0, 100, 0, ''),  -- Wrist slot
    (`char_guid`, 0, 7, 4, '', 0, 100, 0, ''),  -- Hands slot
    (`char_guid`, 0, 8, 4, '', 0, 100, 0, ''),  -- Waist slot
    (`char_guid`, 0, 9, 4, '', 0, 100, 0, ''),  -- Legs slot
    (`char_guid`, 0, 10, 4, '', 0, 100, 0, ''), -- Feet slot
    (`char_guid`, 0, 11, 4, '', 0, 100, 0, ''), -- Finger slot
    (`char_guid`, 0, 12, 4, '', 0, 100, 0, ''), -- Finger slot
    (`char_guid`, 0, 13, 4, '', 0, 100, 0, ''), -- Trinket slot
    (`char_guid`, 0, 14, 4, '', 0, 100, 0, ''), -- Trinket slot
    (`char_guid`, 0, 15, 4, '', 0, 100, 0, ''), -- Main hand slot
    (`char_guid`, 0, 16, 4, '', 0, 100, 0, ''), -- Off hand slot
    (`char_guid`, 0, 17, 4, '', 0, 100, 0, ''), -- Ranged slot
    (`char_guid`, 0, 18, 4, '', 0, 100, 0, ''); -- Tabard slot
END //
DELIMITER ;

-- Apply to all existing classless characters
DELIMITER //
CREATE PROCEDURE `classless_grant_all_gear_to_all`()
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
        CALL `classless_grant_all_gear`(`char_id`);
    END LOOP;

    CLOSE `char_cursor`;
END //
DELIMITER ;

-- Execute the procedure
CALL `classless_grant_all_gear_to_all`();

-- Drop procedures after execution
-- DROP PROCEDURE IF EXISTS `classless_grant_all_gear`;
-- DROP PROCEDURE IF EXISTS `classless_grant_all_gear_to_all`;

-- ============================================================
-- End of 0010_classless_gear.sql
-- ============================================================
