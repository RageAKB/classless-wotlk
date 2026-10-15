#!/bin/bash
# ============================================================
# Classless WotLK - Server Installation Script
# File: install_server.sh
# Description: Installs and configures the AzerothCore server
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

# Check if AzerothCore directory exists
AC_DIR="${AC_DIR:-$HOME/AzerothCore}"

if [ ! -d "$AC_DIR" ]; then
    print_info "AzercotCore directory not found at $AC_DIR"
    print_info "Cloning AzercotCore repository..."
    git clone https://github.com/azerothcore/azerothcore.git "$AC_DIR"
fi

cd "$AC_DIR"

# Install dependencies
print_info "Installing system dependencies..."
if [ -f /etc/debian_version ]; then
    sudo apt-get update
    sudo apt-get install -y cmake make gcc g++ libmysqlclient-dev libreadline-dev \
        libncurses5-dev libncursesw5-dev zlib1g-dev libbz2-dev liblzma-dev \
        libssl-dev libgeoip-dev libmysqlclient-dev libpq-dev libcurl4-openssl-dev \
        libboost-all-dev libtool autoconf pkg-config
elif [ -f /etc/redhat-release ]; then
    sudo yum install -y cmake make gcc gcc-c++ mysql-devel readline-devel \
        ncurses-devel zlib-devel bzip2-devel xz-devel openssl-devel GeoIP-devel \
        postgresql-devel libcurl-devel boost-devel libtool autoconf pkgconfig
fi

# Configure AzercotCore
print_info "Configuring AzercotCore..."
mkdir -p build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX="$AC_DIR/install" -DWITH_WARNINGS=0
make -j$(nproc)
make install

# Configure database
print_info "Configuring database..."
cd "$AC_DIR"
./bin/azerothcore-env.sh install

# Apply classless patches
print_info "Applying classless patches..."
cd "$AC_DIR/sql/character"
for patch in /path/to/classless-wotlk/sql/*.sql; do
    print_info "Applying patch: $patch"
    mysql -u root -p<password> character < "$patch"
done

# Configure server
print_info "Configuring server..."
cat > "$AC_DIR/install/etc/worldserver.conf" << EOF
# Classless WotLK Configuration
# Enable classless characters
ClasslessMode = 1

# Allow all classes
AllowedClasses = 0,1,2,3,4,5,6,7,8,9,11

# Max level
MaxLevel = 80

# Starting gold
StartingGold = 1000000

# Allow all talents
AllowAllTalents = 1

# Allow all spells
AllowAllSpells = 1

# Allow all mounts
AllowAllMounts = 1

# Allow all pets
AllowAllPets = 1

# Allow all skills
AllowAllSkills = 1

# Allow all items
AllowAllItems = 1

# Allow all achievements
AllowAllAchievements = 1

# Allow all quests
AllowAllQuests = 1

# Allow all gear
AllowAllGear = 1

# Server settings
ServerName = "Classless WotLK"
RealmZone = 0
RealmID = 1
RealmName = "Classless WotLK"
BindIP = "0.0.0.0"
WorldServerPort = 8085
DatabaseServer = "127.0.0.1"
DatabasePort = 3306
DatabaseName = "acore_world"
DatabaseUser = "acore"
DatabasePassword = "acore"
EOF

print_info "Installation complete!"
print_info "Start the server with: $AC_DIR/bin/worldserver"
