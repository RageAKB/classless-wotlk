-- ============================================================
-- Classless WotLK - All Skills/Professions Patch
-- File: 0004_classless_skills.sql
-- Description: Grant all skills and professions to classless characters
-- ============================================================

-- Drop existing procedure if it exists
DROP PROCEDURE IF EXISTS `classless_grant_all_skills`;

-- Create a procedure to grant all skills to a character
DELIMITER //
CREATE PROCEDURE `classless_grant_all_skills`(IN `char_guid` INT UNSIGNED)
BEGIN
    -- Clear existing skills for this character
    DELETE FROM `character_skills` WHERE `guid` = `char_guid`;
    
    -- Grant all skill lines (all professions, combat skills, etc.)
    -- In WotLK, there are many skill lines including:
    -- Weapon skills, armor types, professions, quests, etc.
    
    -- Insert all possible skill lines with max rank
    INSERT IGNORE INTO `character_skills` (`guid`, `skill`, `value`, `max`)
    SELECT `char_guid`, `id`, 525, 525
    FROM `skill_lines`
    WHERE `id` > 0;
    
    -- Also grant all profession-specific skills
    -- Blacksmithing, Engineering, Leatherworking, etc.
    INSERT IGNORE INTO `character_skills` (`guid`, `skill`, `value`, `max`)
    VALUES 
    (`char_guid`, 164, 525, 525),  -- Blacksmithing
    (`char_guid`, 165, 525, 525),  -- Leatherworking
    (`char_guid`, 166, 525, 525),  -- Alchemy
    (`char_guid`, 171, 525, 525),  -- First Aid
    (`char_guid`, 177, 525, 525),  -- Cooking
    (`char_guid`, 197, 525, 525),  -- Fishing
    (`char_guid`, 210, 525, 525),  -- Enchanting
    (`char_guid`, 225, 525, 525),  -- Jewelcrafting
    (`char_guid`, 226, 525, 525),  -- Tailoring
    (`char_guid`, 251, 525, 525),  -- Engineering
    (`char_guid`, 313, 525, 525),  -- Inscription
    (`char_guid`, 356, 525, 525),  -- Skinning
    (`char_guid`, 393, 525, 525),  -- Archaeology
    (`char_guid`, 773, 525, 525);  -- Cooking (alternate)
    
    -- Grant weapon skills
    INSERT IGNORE INTO `character_skills` (`guid`, `skill`, `value`, `max`)
    VALUES
    (`char_guid`, 43, 525, 525),   -- Sword
    (`char_guid`, 44, 525, 525),   -- Mace
    (`char_guid`, 45, 525, 525),   -- Axe
    (`char_guid`, 46, 525, 525),   -- Dagger
    (`char_guid`, 47, 525, 525),   -- Fist Weapon
    (`char_guid`, 49, 525, 525),   -- Polearm
    (`char_guid`, 50, 525, 525),   -- Staff
    (`char_guid`, 52, 525, 525),   -- Two-Handed Sword
    (`char_guid`, 53, 525, 525),   -- Two-Handed Mace
    (`char_guid`, 54, 525, 525),   -- Two-Handed Axe
    (`char_guid`, 55, 525, 525),   -- Bow
    (`char_guid`, 56, 525, 525),   -- Gun
    (`char_guid`, 57, 525, 525),   -- Crossbow
    (`char_guid`, 58, 525, 525),   -- Fishing Pole
    (`char_guid`, 59, 525, 525),   -- Missile
    (`char_guid`, 60, 525, 525),   -- Fencing
    (`char_guid`, 62, 525, 525),   -- Racial
    (`char_guid`, 95, 525, 525),   -- Unarmed Combat
    (`char_guid`, 118, 525, 525),  -- Wargear
    (`char_guid`, 136, 525, 525),  -- Shield
    (`char_guid`, 139, 525, 525),  -- Off-hand
    (`char_guid`, 140, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 141, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 142, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 143, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 144, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 145, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 146, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 147, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 148, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 149, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 150, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 151, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 152, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 153, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 154, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 155, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 156, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 157, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 158, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 159, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 160, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 161, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 162, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 163, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 164, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 165, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 166, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 167, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 168, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 169, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 170, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 171, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 172, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 173, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 174, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 175, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 176, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 177, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 178, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 179, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 180, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 181, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 182, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 183, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 184, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 185, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 186, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 187, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 188, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 189, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 190, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 191, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 192, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 193, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 194, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 195, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 196, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 197, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 198, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 199, 525, 525),  -- Wargear (alternate)
    (`char_guid`, 200, 525, 525);  -- Wargear (alternate)
END //
DELIMITER ;

-- Apply to all existing classless characters
DELIMITER //
CREATE PROCEDURE `classless_grant_all_skills_to_all`()
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
        CALL `classless_grant_all_skills`(`char_id`);
    END LOOP;

    CLOSE `char_cursor`;
END //
DELIMITER ;

-- Execute the procedure
CALL `classless_grant_all_skills_to_all`();

-- Drop procedures after execution
-- DROP PROCEDURE IF EXISTS `classless_grant_all_skills`;
-- DROP PROCEDURE IF EXISTS `classless_grant_all_skills_to_all`;

-- ============================================================
-- End of 0004_classless_skills.sql
-- ============================================================
