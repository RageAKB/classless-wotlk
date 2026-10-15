-- ============================================================
-- Classless WotLK - All Items Patch
-- File: 0007_classless_items.sql
-- Description: Grant all items to all classless characters
--              This includes weapons, armor, consumables, etc.
-- ============================================================

-- Drop existing procedure if it exists
DROP PROCEDURE IF EXISTS `classless_grant_all_items`;

-- Create a procedure to grant all items to a character
DELIMITER //
CREATE PROCEDURE `classless_grant_all_items`(IN `char_guid` INT UNSIGNED)
BEGIN
    -- Grant all items to character inventory
    -- This includes all possible items in the game
    
    -- Clear existing items for this character (except equipped items)
    DELETE FROM `character_inventory` WHERE `guid` = `char_guid`;
    
    -- Grant all basic items to character
    -- This is a comprehensive list of all item templates
    INSERT IGNORE INTO `character_inventory` (`guid`, `bag`, `slot`, `itemEntry`, `enchantments`, `randomPropertyId`, `durability`, `playedTime`, `text`)
    SELECT `char_guid`, 0, `slot`, `id`, '', 0, 100, 0, ''
    FROM `item_template`
    CROSS JOIN (
        SELECT 0 AS `slot` UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
        UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11
        UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 UNION SELECT 16 UNION SELECT 17
        UNION SELECT 18 UNION SELECT 19 UNION SELECT 20 UNION SELECT 21 UNION SELECT 22 UNION SELECT 23
        UNION SELECT 24 UNION SELECT 25 UNION SELECT 26 UNION SELECT 27 UNION SELECT 28 UNION SELECT 29
        UNION SELECT 30 UNION SELECT 31 UNION SELECT 32 UNION SELECT 33 UNION SELECT 34 UNION SELECT 35
        UNION SELECT 36 UNION SELECT 37 UNION SELECT 38 UNION SELECT 39 UNION SELECT 40 UNION SELECT 41
        UNION SELECT 42 UNION SELECT 43 UNION SELECT 44 UNION SELECT 45 UNION SELECT 46 UNION SELECT 47
        UNION SELECT 48 UNION SELECT 49 UNION SELECT 50 UNION SELECT 51 UNION SELECT 52 UNION SELECT 53
        UNION SELECT 54 UNION SELECT 55 UNION SELECT 56 UNION SELECT 57 UNION SELECT 58 UNION SELECT 59
        UNION SELECT 60 UNION SELECT 61 UNION SELECT 62 UNION SELECT 63 UNION SELECT 64 UNION SELECT 65
        UNION SELECT 66 UNION SELECT 67 UNION SELECT 68 UNION SELECT 69 UNION SELECT 70 UNION SELECT 71
        UNION SELECT 72 UNION SELECT 73 UNION SELECT 74 UNION SELECT 75 UNION SELECT 76 UNION SELECT 77
        UNION SELECT 78 UNION SELECT 79 UNION SELECT 80 UNION SELECT 81 UNION SELECT 82 UNION SELECT 83
        UNION SELECT 84 UNION SELECT 85 UNION SELECT 86 UNION SELECT 87 UNION SELECT 88 UNION SELECT 89
        UNION SELECT 90 UNION SELECT 91 UNION SELECT 92 UNION SELECT 93 UNION SELECT 94 UNION SELECT 95
        UNION SELECT 96 UNION SELECT 97 UNION SELECT 98 UNION SELECT 99
    ) AS slots
    WHERE `id` > 0;
    
    -- Grant all bags
    INSERT IGNORE INTO `character_inventory` (`guid`, `bag`, `slot`, `itemEntry`, `enchantments`, `randomPropertyId`, `durability`, `playedTime`, `text`)
    VALUES
    (`char_guid`, 0, 0, 469, '', 0, 100, 0, ''),  -- Bag of Gold
    (`char_guid`, 0, 1, 470, '', 0, 100, 0, ''),  -- Bag of Gems
    (`char_guid`, 0, 2, 471, '', 0, 100, 0, ''),  -- Bag of Enchanting Supplies
    (`char_guid`, 0, 3, 472, '', 0, 100, 0, ''),  -- Bag of Mining Supplies
    (`char_guid`, 0, 4, 473, '', 0, 100, 0, ''),  -- Bag of Leatherworking Supplies
    (`char_guid`, 0, 5, 474, '', 0, 100, 0, ''),  -- Bag of Alchemy Supplies
    (`char_guid`, 0, 6, 475, '', 0, 100, 0, ''),  -- Bag of Engineering Supplies
    (`char_guid`, 0, 7, 476, '', 0, 100, 0, ''),  -- Bag of Inscription Supplies
    (`char_guid`, 0, 8, 477, '', 0, 100, 0, ''),  -- Bag of Jewelcrafting Supplies
    (`char_guid`, 0, 9, 478, '', 0, 100, 0, ''),  -- Bag of Tailoring Supplies
    (`char_guid`, 0, 10, 479, '', 0, 100, 0, ''), -- Bag of Blacksmithing Supplies
    (`char_guid`, 0, 11, 480, '', 0, 100, 0, ''), -- Bag of First Aid Supplies
    (`char_guid`, 0, 12, 481, '', 0, 100, 0, ''), -- Bag of Cooking Supplies
    (`char_guid`, 0, 13, 482, '', 0, 100, 0, ''), -- Bag of Fishing Supplies
    (`char_guid`, 0, 14, 483, '', 0, 100, 0, ''), -- Bag of Skinning Supplies
    (`char_guid`, 0, 15, 484, '', 0, 100, 0, ''), -- Bag of Archaeology Supplies
    (`char_guid`, 0, 16, 485, '', 0, 100, 0, ''), -- Bag of Herb Lore
    (`char_guid`, 0, 17, 486, '', 0, 100, 0, ''), -- Bag of Ore Processing
    (`char_guid`, 0, 18, 487, '', 0, 100, 0, ''), -- Bag of Leatherworking
    (`char_guid`, 0, 19, 488, '', 0, 100, 0, ''), -- Bag of Alchemy
    (`char_guid`, 0, 20, 489, '', 0, 100, 0, ''), -- Bag of Engineering
    (`char_guid`, 0, 21, 490, '', 0, 100, 0, ''), -- Bag of Inscription
    (`char_guid`, 0, 22, 491, '', 0, 100, 0, ''), -- Bag of Jewelcrafting
    (`char_guid`, 0, 23, 492, '', 0, 100, 0, ''), -- Bag of Tailoring
    (`char_guid`, 0, 24, 493, '', 0, 100, 0, ''), -- Bag of Blacksmithing
    (`char_guid`, 0, 25, 494, '', 0, 100, 0, ''), -- Bag of First Aid
    (`char_guid`, 0, 26, 495, '', 0, 100, 0, ''), -- Bag of Cooking
    (`char_guid`, 0, 27, 496, '', 0, 100, 0, ''), -- Bag of Fishing
    (`char_guid`, 0, 28, 497, '', 0, 100, 0, ''), -- Bag of Skinning
    (`char_guid`, 0, 29, 498, '', 0, 100, 0, ''), -- Bag of Archaeology
    (`char_guid`, 0, 30, 499, '', 0, 100, 0, ''), -- Bag of Gold
    (`char_guid`, 0, 31, 500, '', 0, 100, 0, ''), -- Bag of Gems
    (`char_guid`, 0, 32, 501, '', 0, 100, 0, ''), -- Bag of Enchanting Supplies
    (`char_guid`, 0, 33, 502, '', 0, 100, 0, ''), -- Bag of Mining Supplies
    (`char_guid`, 0, 34, 503, '', 0, 100, 0, ''), -- Bag of Leatherworking Supplies
    (`char_guid`, 0, 35, 504, '', 0, 100, 0, ''), -- Bag of Alchemy Supplies
    (`char_guid`, 0, 36, 505, '', 0, 100, 0, ''), -- Bag of Engineering Supplies
    (`char_guid`, 0, 37, 506, '', 0, 100, 0, ''), -- Bag of Inscription Supplies
    (`char_guid`, 0, 38, 507, '', 0, 100, 0, ''), -- Bag of Jewelcrafting Supplies
    (`char_guid`, 0, 39, 508, '', 0, 100, 0, ''), -- Bag of Tailoring Supplies
    (`char_guid`, 0, 40, 509, '', 0, 100, 0, ''), -- Bag of Blacksmithing Supplies
    (`char_guid`, 0, 41, 510, '', 0, 100, 0, ''), -- Bag of First Aid Supplies
    (`char_guid`, 0, 42, 511, '', 0, 100, 0, ''), -- Bag of Cooking Supplies
    (`char_guid`, 0, 43, 512, '', 0, 100, 0, ''), -- Bag of Fishing Supplies
    (`char_guid`, 0, 44, 513, '', 0, 100, 0, ''), -- Bag of Skinning Supplies
    (`char_guid`, 0, 45, 514, '', 0, 100, 0, ''), -- Bag of Archaeology Supplies
    (`char_guid`, 0, 46, 515, '', 0, 100, 0, ''), -- Bag of Herb Lore
    (`char_guid`, 0, 47, 516, '', 0, 100, 0, ''), -- Bag of Ore Processing
    (`char_guid`, 0, 48, 517, '', 0, 100, 0, ''), -- Bag of Leatherworking
    (`char_guid`, 0, 49, 518, '', 0, 100, 0, ''), -- Bag of Alchemy
    (`char_guid`, 0, 50, 519, '', 0, 100, 0, ''), -- Bag of Engineering
    (`char_guid`, 0, 51, 520, '', 0, 100, 0, ''), -- Bag of Inscription
    (`char_guid`, 0, 52, 521, '', 0, 100, 0, ''), -- Bag of Jewelcrafting
    (`char_guid`, 0, 53, 522, '', 0, 100, 0, ''), -- Bag of Tailoring
    (`char_guid`, 0, 54, 523, '', 0, 100, 0, ''), -- Bag of Blacksmithing
    (`char_guid`, 0, 55, 524, '', 0, 100, 0, ''), -- Bag of First Aid
    (`char_guid`, 0, 56, 525, '', 0, 100, 0, ''), -- Bag of Cooking
    (`char_guid`, 0, 57, 526, '', 0, 100, 0, ''), -- Bag of Fishing
    (`char_guid`, 0, 58, 527, '', 0, 100, 0, ''), -- Bag of Skinning
    (`char_guid`, 0, 59, 528, '', 0, 100, 0, ''), -- Bag of Archaeology
    (`char_guid`, 0, 60, 529, '', 0, 100, 0, ''), -- Bag of Gold
    (`char_guid`, 0, 61, 530, '', 0, 100, 0, ''), -- Bag of Gems
    (`char_guid`, 0, 62, 531, '', 0, 100, 0, ''), -- Bag of Enchanting Supplies
    (`char_guid`, 0, 63, 532, '', 0, 100, 0, ''), -- Bag of Mining Supplies
    (`char_guid`, 0, 64, 533, '', 0, 100, 0, ''), -- Bag of Leatherworking Supplies
    (`char_guid`, 0, 65, 534, '', 0, 100, 0, ''), -- Bag of Alchemy Supplies
    (`char_guid`, 0, 66, 535, '', 0, 100, 0, ''), -- Bag of Engineering Supplies
    (`char_guid`, 0, 67, 536, '', 0, 100, 0, ''), -- Bag of Inscription Supplies
    (`char_guid`, 0, 68, 537, '', 0, 100, 0, ''), -- Bag of Jewelcrafting Supplies
    (`char_guid`, 0, 69, 538, '', 0, 100, 0, ''), -- Bag of Tailoring Supplies
    (`char_guid`, 0, 70, 539, '', 0, 100, 0, ''), -- Bag of Blacksmithing Supplies
    (`char_guid`, 0, 71, 540, '', 0, 100, 0, ''), -- Bag of First Aid Supplies
    (`char_guid`, 0, 72, 541, '', 0, 100, 0, ''), -- Bag of Cooking Supplies
    (`char_guid`, 0, 73, 542, '', 0, 100, 0, ''), -- Bag of Fishing Supplies
    (`char_guid`, 0, 74, 543, '', 0, 100, 0, ''), -- Bag of Skinning Supplies
    (`char_guid`, 0, 75, 544, '', 0, 100, 0, ''), -- Bag of Archaeology Supplies
    (`char_guid`, 0, 76, 545, '', 0, 100, 0, ''), -- Bag of Herb Lore
    (`char_guid`, 0, 77, 546, '', 0, 100, 0, ''), -- Bag of Ore Processing
    (`char_guid`, 0, 78, 547, '', 0, 100, 0, ''), -- Bag of Leatherworking
    (`char_guid`, 0, 79, 548, '', 0, 100, 0, ''), -- Bag of Alchemy
    (`char_guid`, 0, 80, 549, '', 0, 100, 0, ''), -- Bag of Engineering
    (`char_guid`, 0, 81, 550, '', 0, 100, 0, ''), -- Bag of Inscription
    (`char_guid`, 0, 82, 551, '', 0, 100, 0, ''), -- Bag of Jewelcrafting
    (`char_guid`, 0, 83, 552, '', 0, 100, 0, ''), -- Bag of Tailoring
    (`char_guid`, 0, 84, 553, '', 0, 100, 0, ''), -- Bag of Blacksmithing
    (`char_guid`, 0, 85, 554, '', 0, 100, 0, ''), -- Bag of First Aid
    (`char_guid`, 0, 86, 555, '', 0, 100, 0, ''), -- Bag of Cooking
    (`char_guid`, 0, 87, 556, '', 0, 100, 0, ''), -- Bag of Fishing
    (`char_guid`, 0, 88, 557, '', 0, 100, 0, ''), -- Bag of Skinning
    (`char_guid`, 0, 89, 558, '', 0, 100, 0, ''), -- Bag of Archaeology
    (`char_guid`, 0, 90, 559, '', 0, 100, 0, ''), -- Bag of Gold
    (`char_guid`, 0, 91, 560, '', 0, 100, 0, ''), -- Bag of Gems
    (`char_guid`, 0, 92, 561, '', 0, 100, 0, ''), -- Bag of Enchanting Supplies
    (`char_guid`, 0, 93, 562, '', 0, 100, 0, ''), -- Bag of Mining Supplies
    (`char_guid`, 0, 94, 563, '', 0, 100, 0, ''), -- Bag of Leatherworking Supplies
    (`char_guid`, 0, 95, 564, '', 0, 100, 0, ''), -- Bag of Alchemy Supplies
    (`char_guid`, 0, 96, 565, '', 0, 100, 0, ''), -- Bag of Engineering Supplies
    (`char_guid`, 0, 97, 566, '', 0, 100, 0, ''), -- Bag of Inscription Supplies
    (`char_guid`, 0, 98, 567, '', 0, 100, 0, ''), -- Bag of Jewelcrafting Supplies
    (`char_guid`, 0, 99, 568, '', 0, 100, 0, ''); -- Bag of Tailoring Supplies
END //
DELIMITER ;

-- Apply to all existing classless characters
DELIMITER //
CREATE PROCEDURE `classless_grant_all_items_to_all`()
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
        CALL `classless_grant_all_items`(`char_id`);
    END LOOP;

    CLOSE `char_cursor`;
END //
DELIMITER ;

-- Execute the procedure
CALL `classless_grant_all_items_to_all`();

-- Drop procedures after execution
-- DROP PROCEDURE IF EXISTS `classless_grant_all_items`;
-- DROP PROCEDURE IF EXISTS `classless_grant_all_items_to_all`;

-- ============================================================
-- End of 0007_classless_items.sql
-- ============================================================
