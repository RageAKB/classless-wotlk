-- ============================================================
-- Classless WotLK - All Pets/Companions Patch
-- File: 0006_classless_pets.sql
-- Description: Grant all pets and companions to classless characters
-- ============================================================

-- Drop existing procedure if it exists
DROP PROCEDURE IF EXISTS `classless_grant_all_pets`;

-- Create a procedure to grant all pets to a character
DELIMITER //
CREATE PROCEDURE `classless_grant_all_pets`(IN `char_guid` INT UNSIGNED)
BEGIN
    -- Grant all pet spells (pets are learned via spells in WotLK)
    -- This includes warlock pets, hunter pets, death knight pets, etc.
    
    -- Clear existing pets for this character
    DELETE FROM `character_spell` WHERE `guid` = `char_guid` AND `spell` IN (
        SELECT `id` FROM `spell` WHERE `spell_family_name` = 'Pet'
    );
    
    -- Grant all warlock pet spells
    INSERT IGNORE INTO `character_spell` (`guid`, `spell`, `active`, `disabled`, `SpecGroup`, `SpecId`)
    SELECT `char_guid`, `id`, 1, 0, 0, 0
    FROM `spell`
    WHERE `spell_family_name` = 'Pet'
    AND `spell_family_group` = 1  -- Warlock pets
    AND `id` NOT IN (
        SELECT `spell` FROM `character_spell` WHERE `guid` = `char_guid`
    );
    
    -- Grant all hunter pet spells
    INSERT IGNORE INTO `character_spell` (`guid`, `spell`, `active`, `disabled`, `SpecGroup`, `SpecId`)
    SELECT `char_guid`, `id`, 1, 0, 0, 0
    FROM `spell`
    WHERE `spell_family_name` = 'Pet'
    AND `spell_family_group` = 2  -- Hunter pets
    AND `id` NOT IN (
        SELECT `spell` FROM `character_spell` WHERE `guid` = `char_guid`
    );
    
    -- Grant all death knight pet spells
    INSERT IGNORE INTO `character_spell` (`guid`, `spell`, `active`, `disabled`, `SpecGroup`, `SpecId`)
    SELECT `char_guid`, `id`, 1, 0, 0, 0
    FROM `spell`
    WHERE `spell_family_name` = 'Pet'
    AND `spell_family_group` = 3  -- Death knight pets
    AND `id` NOT IN (
        SELECT `spell` FROM `character_spell` WHERE `guid` = `char_guid`
    );
    
    -- Grant all companion spells (non-combat pets)
    INSERT IGNORE INTO `character_spell` (`guid`, `spell`, `active`, `disabled`, `SpecGroup`, `SpecId`)
    SELECT `char_guid`, `id`, 1, 0, 0, 0
    FROM `spell`
    WHERE `spell_family_name` = 'Companion'
    AND `id` NOT IN (
        SELECT `spell` FROM `character_spell` WHERE `guid` = `char_guid`
    );
    
    -- Grant all pet-related talents
    INSERT IGNORE INTO `character_talent` (`guid`, `talentId`, `SpecGroup`, `SpecId`)
    SELECT `char_guid`, `id`, 0, 0
    FROM `talent`
    WHERE `spellId` IN (
        SELECT `id` FROM `spell` WHERE `spell_family_name` = 'Pet'
    );
END //
DELIMITER ;

-- Apply to all existing classless characters
DELIMITER //
CREATE PROCEDURE `classless_grant_all_pets_to_all`()
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
        CALL `classless_grant_all_pets`(`char_id`);
    END LOOP;

    CLOSE `char_cursor`;
END //
DELIMITER ;

-- Execute the procedure
CALL `classless_grant_all_pets_to_all`();

-- Drop procedures after execution
-- DROP PROCEDURE IF EXISTS `classless_grant_all_pets`;
-- DROP PROCEDURE IF EXISTS `classless_grant_all_pets_to_all`;

-- ============================================================
-- End of 0006_classless_pets.sql
-- ============================================================
