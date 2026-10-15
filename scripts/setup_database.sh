#!/bin/bash
# ============================================================
# Classless WotLK - Database Setup Script
# File: setup_database.sh
# Description: Sets up and configures the MySQL database
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

# Database configuration
DB_HOST="${DB_HOST:-127.0.0.1}"
DB_PORT="${DB_PORT:-3306}"
DB_USER="${DB_USER:-acore}"
DB_PASS="${DB_PASS:-acore}"
DB_NAME="${DB_NAME:-acore_world}"

# Check if MySQL is running
print_info "Checking MySQL connection..."
if ! mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASS" -e "SELECT 1" &>/dev/null; then
    print_error "Cannot connect to MySQL server"
    print_error "Please ensure MySQL is running and credentials are correct"
    exit 1
fi

# Create databases if they don't exist
print_info "Creating databases..."
mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASS" << EOF
CREATE DATABASE IF NOT EXISTS acore_world CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS acore_auth CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS acore_characters CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
EOF

# Apply classless patches
print_info "Applying classless patches..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SQL_DIR="${SCRIPT_DIR}/../sql"

if [ ! -d "$SQL_DIR" ]; then
    print_error "SQL directory not found at $SQL_DIR"
    exit 1
fi

for patch in "$SQL_DIR"/*.sql; do
    print_info "Applying patch: $(basename $patch)"
    mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < "$patch"
done

# Configure authentication database
print_info "Configuring authentication database..."
mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASS" acore_auth << EOF
-- Allow classless characters (class 0)
INSERT IGNORE INTO account_access (id, gmlevel, RealmID) VALUES (1, 6, -1);

-- Create admin account if not exists
INSERT IGNORE INTO account (username, sha_pass_hash) VALUES ('admin', MD5('admin'));

-- Grant all permissions to admin
INSERT IGNORE INTO account_access (id, gmlevel, RealmID) VALUES ((SELECT id FROM account WHERE username = 'admin'), 3, -1);
EOF

print_info "Database setup complete!"
print_info "You can now start the AzerothCore server"
