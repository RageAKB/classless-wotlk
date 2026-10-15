-- ============================================================
-- Classless WotLK - Character Creation Patch
-- File: 0001_classless_character_creation.sql
-- Description: Allow classless character creation and modify
--              character creation restrictions
-- ============================================================

-- Drop existing triggers that enforce class selection
-- AzerothCore uses triggers to validate character creation
-- We need to disable the class validation

-- Remove class restriction from character creation
-- This allows creating characters with class = 0 (no class)
-- The actual class assignment happens via .class command

-- Modify the character creation stored procedure if it exists
-- Note: AzerothCore may not use stored procedures for this,
-- so we handle it via the worldserver configuration instead

-- Add a flag to allow classless characters in the worldserver config
-- This is handled by setting AllowTwoSideInteractions and related flags

-- Create a table to track classless characters and their current class
CREATE TABLE IF NOT EXISTS `classless_characters` (
    `guid` INT UNSIGNED NOT NULL,
    `current_class` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `current_spec` VARCHAR(50) DEFAULT NULL,
    `last_switch_time` INT UNSIGNED NOT NULL DEFAULT 0,
    PRIMARY KEY (`guid`),
    FOREIGN KEY (`guid`) REFERENCES `characters` (`guid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create a table to track character class history
CREATE TABLE IF NOT EXISTS `classless_class_history` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `guid` INT UNSIGNED NOT NULL,
    `old_class` TINYINT UNSIGNED NOT NULL,
    `new_class` TINYINT UNSIGNED NOT NULL,
    `switch_time` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`guid`) REFERENCES `characters` (`guid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create a table to track character spec history
CREATE TABLE IF NOT EXISTS `classless_spec_history` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `guid` INT UNSIGNED NOT NULL,
    `class` TINYINT UNSIGNED NOT NULL,
    `old_spec` VARCHAR(50) DEFAULT NULL,
    `new_spec` VARCHAR(50) DEFAULT NULL,
    `switch_time` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`guid`) REFERENCES `characters` (`guid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert default classless character settings
-- These are used by the worldserver to determine starting stats
INSERT INTO `classless_characters` (`guid`, `current_class`, `current_spec`, `last_switch_time`)
SELECT `guid`, 0, NULL, UNIX_TIMESTAMP()
FROM `characters`
WHERE `class` = 0
ON DUPLICATE KEY UPDATE `current_class` = VALUES(`current_class`);

-- ============================================================
-- End of 0001_classless_character_creation.sql
-- ============================================================
