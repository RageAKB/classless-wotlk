-- ============================================================
-- Classless WotLK - All Spells Patch
-- File: 0002_classless_all_spells.sql
-- Description: Grant all spells to all classless characters
--              Uses stored procedures for efficiency
-- ============================================================

-- Drop existing procedure if it exists
DROP PROCEDURE IF EXISTS `classless_grant_all_spells`;

-- Create a procedure to grant all spells to a character
DELIMITER //
CREATE PROCEDURE `classless_grant_all_spells`(IN `char_guid` INT UNSIGNED)
BEGIN
    -- Grant all spells from the dbc_spell table
    -- This inserts all spell IDs into character_spell for this character
    INSERT INTO `character_spell` (`guid`, `spell`, `active`, `disabled`, `SpecGroup`, `SpecId`)
    SELECT `char_guid`, `id`, 1, 0, 0, 0
    FROM `spell`
    WHERE `id` > 0
    AND `id` NOT IN (
        SELECT `spell` FROM `character_spell` WHERE `guid` = `char_guid`
    );

    -- Grant all talent spells (spells with spellClassMask that are talent-related)
    INSERT IGNORE INTO `character_spell` (`guid`, `spell`, `active`, `disabled`, `SpecGroup`, `SpecId`)
    SELECT `char_guid`, `id`, 1, 0, 0, 0
    FROM `spell`
    WHERE `spell_family_name` IS NOT NULL
    AND `id` NOT IN (
        SELECT `spell` FROM `character_spell` WHERE `guid` = `char_guid`
    );

    -- Grant all racial spells
    INSERT IGNORE INTO `character_spell` (`guid`, `spell`, `active`, `disabled`, `SpecGroup`, `SpecId`)
    SELECT `char_guid`, `id`, 1, 0, 0, 0
    FROM `spell`
    WHERE `spell_family_name` = 'Racial'
    AND `id` NOT IN (
        SELECT `spell` FROM `character_spell` WHERE `guid` = `char_guid`
    );

    -- Grant all class-specific spells for all classes
    -- Warrior spells (spellClassMask 1)
    INSERT IGNORE INTO `character_spell` (`guid`, `spell`, `active`, `disabled`, `SpecGroup`, `SpecId`)
    SELECT `char_guid`, `id`, 1, 0, 0, 0
    FROM `spell`
    WHERE `spellClassMask` & 1
    AND `id` NOT IN (
        SELECT `spell` FROM `character_spell` WHERE `guid` = `char_guid`
    );

    -- Paladin spells (spellClassMask 2)
    INSERT IGNORE INTO `character_spell` (`guid`, `spell`, `active`, `disabled`, `SpecGroup`, `SpecId`)
    SELECT `char_guid`, `id`, 1, 0, 0, 0
    FROM `spell`
    WHERE `spellClassMask` & 2
    AND `id` NOT IN (
        SELECT `spell` FROM `character_spell` WHERE `guid` = `char_guid`
    );

    -- Hunter spells (spellClassMask 4)
    INSERT IGNORE INTO `character_spell` (`guid`, `spell`, `active`, `disabled`, `SpecGroup`, `SpecId`)
    SELECT `char_guid`, `id`, 1, 0, 0, 0
    FROM `spell`
    WHERE `spellClassMask` & 4
    AND `id` NOT IN (
        SELECT `spell` FROM `character_spell` WHERE `guid` = `char_guid`
    );

    -- Rogue spells (spellClassMask 8)
    INSERT IGNORE INTO `character_spell` (`guid`, `spell`, `active`, `disabled`, `SpecGroup`, `SpecId`)
    SELECT `char_guid`, `id`, 1, 0, 0, 0
    FROM `spell`
    WHERE `spellClassMask` & 8
    AND `id` NOT IN (
        SELECT `spell` FROM `character_spell` WHERE `guid` = `char_guid`
    );

    -- Priest spells (spellClassMask 16)
    INSERT IGNORE INTO `character_spell` (`guid`, `spell`, `active`, `disabled`, `SpecGroup`, `SpecId`)
    SELECT `char_guid`, `id`, 1, 0, 0, 0
    FROM `spell`
    WHERE `spellClassMask` & 16
    AND `id` NOT IN (
        SELECT `spell` FROM `character_spell` WHERE `guid` = `char_guid`
    );

    -- Shaman spells (spellClassMask 32)
    INSERT IGNORE INTO `character_spell` (`guid`, `spell`, `active`, `disabled`, `SpecGroup`, `SpecId`)
    SELECT `char_guid`, `id`, 1, 0, 0, 0
    FROM `spell`
    WHERE `spellClassMask` & 32
    AND `id` NOT IN (
        SELECT `spell` FROM `character_spell` WHERE `guid` = `char_guid`
    );

    -- Mage spells (spellClassMask 64)
    INSERT IGNORE INTO `character_spell` (`guid`, `spell`, `active`, `disabled`, `SpecGroup`, `SpecId`)
    SELECT `char_guid`, `id`, 1, 0, 0, 0
    FROM `spell`
    WHERE `spellClassMask` & 64
    AND `id` NOT IN (
        SELECT `spell` FROM `character_spell` WHERE `guid` = `char_guid`
    );

    -- Warlock spells (spellClassMask 128)
    INSERT IGNORE INTO `character_spell` (`guid`, `spell`, `active`, `disabled`, `SpecGroup`, `SpecId`)
    SELECT `char_guid`, `id`, 1, 0, 0, 0
    FROM `spell`
    WHERE `spellClassMask` & 128
    AND `id` NOT IN (
        SELECT `spell` FROM `character_spell` WHERE `guid` = `char_guid`
    );

    -- Druid spells (spellClassMask 256)
    INSERT IGNORE INTO `character_spell` (`guid`, `spell`, `active`, `disabled`, `SpecGroup`, `SpecId`)
    SELECT `char_guid`, `id`, 1, 0, 0, 0
    FROM `spell`
    WHERE `spellClassMask` & 256
    AND `id` NOT IN (
        SELECT `spell` FROM `character_spell` WHERE `guid` = `char_guid`
    );

    -- Death Knight spells (spellClassMask 512)
    INSERT IGNORE INTO `character_spell` (`guid`, `spell`, `active`, `disabled`, `SpecGroup`, `SpecId`)
    SELECT `char_guid`, `id`, 1, 0, 0, 0
    FROM `spell`
    WHERE `spellClassMask` & 512
    AND `id` NOT IN (
        SELECT `spell` FROM `character_spell` WHERE `guid` = `char_guid`
    );
END //
DELIMITER ;

-- Apply to all existing classless characters (class = 0)
-- This can be run manually for each character or via a loop
DELIMITER //
CREATE PROCEDURE `classless_grant_all_spells_to_all`()
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
        CALL `classless_grant_all_spells`(`char_id`);
    END LOOP;

    CLOSE `char_cursor`;
END //
DELIMITER ;

-- Execute the procedure to grant spells to all classless characters
CALL `classless_grant_all_spells_to_all`();

-- Drop the procedures after execution (optional - keep if you need to re-run)
-- DROP PROCEDURE IF EXISTS `classless_grant_all_spells`;
-- DROP PROCEDURE IF EXISTS `classless_grant_all_spells_to_all`;

-- ============================================================
-- End of 0002_classless_all_spells.sql
-- ============================================================
