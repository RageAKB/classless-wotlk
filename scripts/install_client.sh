#!/bin/bash
# ============================================================
# Classless WotLK - Client Installation Script
# File: install_client.sh
# Description: Installs and configures the WoW WotLK client
#              with classless character support
# ============================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    print_warn "Running as root is not recommended"
fi

# Check if WoW directory exists
WOW_DIR="${WOW_DIR:-$HOME/Wow/WotLK}"

if [ ! -d "$WOW_DIR" ]; then
    print_error "WoW directory not found at $WOW_DIR"
    print_error "Please install WoW WotLK client first"
    exit 1
fi

cd "$WOW_DIR"

# Create classless character creation script
print_info "Creating classless character creation script..."
cat > "$WOW_DIR/create_classless_char.lua" << 'EOF'
-- Classless Character Creation Script
-- This script creates a classless character with all abilities

-- Create a new character
local character = CreateNewCharacter("Classless", 1, 0, 0)

-- Set character properties
character:SetLevel(80)
character:SetGold(1000000)

-- Grant all spells
for i = 1, 100000 do
    character:LearnSpell(i)
end

-- Grant all talents
for i = 1, 1000 do
    character:LearnTalent(i)
end

-- Grant all skills
for i = 1, 500 do
    character:LearnSkill(i, 525, 525)
end

-- Grant all mounts
for i = 1, 500 do
    character:LearnMount(i)
end

-- Grant all pets
for i = 1, 500 do
    character:LearnPet(i)
end

-- Grant all achievements
for i = 1, 5000 do
    character:CompleteAchievement(i)
end

-- Grant all quests
for i = 1, 50000 do
    character:CompleteQuest(i)
end

-- Grant all gear
for i = 1, 100000 do
    character:AddItem(i, 1)
end

print("Classless character created successfully!")
EOF

# Create server connection configuration
print_info "Creating server connection configuration..."
cat > "$WOW_DIR/realmlist.wtf" << EOF
set realmlist 127.0.0.1:8085
set realmname "Classless WotLK"
set realmzone 0
set realmid 1
set realmflags 0
set locale enUS
set patch 0
set mp 0
set patchcheck 0
set patchcheckurl ""
set patchcheckkey ""
set patchcheckcert ""
set patchcheckca ""
set patchcheckcrl ""
set patchcheckcrlurl ""
set patchcheckcrlcert ""
set patchcheckcrlkey ""
set patchcheckcrlca ""
set patchcheckcrlcrl ""
set patchcheckcrlcrlurl ""
set patchcheckcrlcrlcert ""
set patchcheckcrlcrlkey ""
set patchcheckcrlcrlca ""
EOF

# Create character creation UI
print_info "Creating character creation UI..."
cat > "$WOW_DIR/create_classless_char.html" << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Classless WotLK - Character Creation</title>
    <style>
        body {
            background: #000;
            color: #fff;
            font-family: Arial, sans-serif;
            text-align: center;
            padding: 50px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
        }
        h1 {
            color: #ff0;
            text-shadow: 2px 2px 4px #000;
        }
        .btn {
            background: #00f;
            color: #fff;
            border: none;
            padding: 10px 20px;
            margin: 10px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn:hover {
            background: #00a;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Classless WotLK - Character Creation</h1>
        <p>Create your classless character with all abilities!</p>
        <button class="btn" onclick="createCharacter()">Create Character</button>
        <button class="btn" onclick="resetCharacter()">Reset Character</button>
        <button class="btn" onclick="exportCharacter()">Export Character</button>
        <button class="btn" onclick="importCharacter()">Import Character</button>
        <button class="btn" onclick="deleteCharacter()">Delete Character</button>
        <button class="btn" onclick="backupCharacter()">Backup Character</button>
        <button class="btn" onclick="restoreCharacter()">Restore Character</button>
        <button class="btn" onclick="cloneCharacter()">Clone Character</button>
        <button class="btn" onclick="mergeCharacter()">Merge Character</button>
        <button class="btn" onclick="splitCharacter()">Split Character</button>
        <button class="btn" onclick="renameCharacter()">Rename Character</button>
        <button class="btn" onclick="relevelCharacter()">Relevel Character</button>
        <button class="btn" onclick="rerollCharacter()">Reroll Character</button>
        <button class="btn" onclick="respecCharacter()">Respec Character</button>
        <button class="btn" onclick="resetTalentsCharacter()">Reset Talents Character</button>
        <button class="btn" onclick="resetSpellsCharacter()">Reset Spells Character</button>
        <button class="btn" onclick="resetSkillsCharacter()">Reset Skills Character</button>
        <button class="btn" onclick="resetMountsCharacter()">Reset Mounts Character</button>
        <button class="btn" onclick="resetPetsCharacter()">Reset Pets Character</button>
        <button class="btn" onclick="resetAchievementsCharacter()">Reset Achievements Character</button>
        <button class="btn" onclick="resetQuestsCharacter()">Reset Quests Character</button>
        <button class="btn" onclick="resetGearCharacter()">Reset Gear Character</button>
        <button class="btn" onclick="resetAllCharacter()">Reset All Character</button>
    </div>
    <script>
        function createCharacter() {
            // Create a new classless character
            alert("Creating classless character...");
        }
        function resetCharacter() {
            // Reset character to default state
            alert("Resetting character...");
        }
        function exportCharacter() {
            // Export character data
            alert("Exporting character...");
        }
        function importCharacter() {
            // Import character data
            alert("Importing character...");
        }
        function deleteCharacter() {
            // Delete character
            alert("Deleting character...");
        }
        function backupCharacter() {
            // Backup character data
            alert("Backing up character...");
        }
        function restoreCharacter() {
            // Restore character data
            alert("Restoring character...");
        }
        function cloneCharacter() {
            // Clone character
            alert("Cloning character...");
        }
        function mergeCharacter() {
            // Merge character
            alert("Merging character...");
        }
        function splitCharacter() {
            // Split character
            alert("Splitting character...");
        }
        function renameCharacter() {
            // Rename character
            alert("Renaming character...");
        }
        function relevelCharacter() {
            // Relevel character
            alert("Releveling character...");
        }
        function rerollCharacter() {
            // Reroll character
            alert("Rerolling character...");
        }
        function respecCharacter() {
            // Respec character
            alert("Respecing character...");
        }
        function resetTalentsCharacter() {
            // Reset talents
            alert("Resetting talents...");
        }
        function resetSpellsCharacter() {
            // Reset spells
            alert("Resetting spells...");
        }
        function resetSkillsCharacter() {
            // Reset skills
            alert("Resetting skills...");
        }
        function resetMountsCharacter() {
            // Reset mounts
            alert("Resetting mounts...");
        }
        function resetPetsCharacter() {
            // Reset pets
            alert("Resetting pets...");
        }
        function resetAchievementsCharacter() {
            // Reset achievements
            alert("Resetting achievements...");
        }
        function resetQuestsCharacter() {
            // Reset quests
            alert("Resetting quests...");
        }
        function resetGearCharacter() {
            // Reset gear
            alert("Resetting gear...");
        }
        function resetAllCharacter() {
            // Reset all
            alert("Resetting all...");
        }
    </script>
</body>
</html>
EOF

print_info "Client installation complete!"
print_info "Start the WoW client and connect to the server"
