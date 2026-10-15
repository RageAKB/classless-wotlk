# Classless WotLK

A World of Warcraft: Wrath of the Lich King (WotLK) modification that allows classless characters using only built-in textures. This mod is similar to Ascension but with a unique classless character system.

## Features

- **Classless Characters**: Play as any class with all abilities
- **Built-in Textures**: Uses only official WoW textures - no custom models or textures required
- **All Spells**: Access to all spells from all classes
- **All Talents**: Access to all talent trees and talents
- **All Skills**: Max skill in all professions and combat skills
- **All Mounts**: Access to all ground and flying mounts
- **All Pets**: Access to all warlock, hunter, and death knight pets
- **All Items**: Access to all items in the game
- **All Achievements**: All achievements unlocked
- **All Quests**: All quests completed
- **All Gear**: All armor sets and equipment available

## Requirements

- World of Warcraft: Wrath of the Lich King (WotLK) client (3.3.5a)
- AzerothCore server (latest version)
- MySQL/MariaDB database
- Linux operating system (recommended)

## Installation

### Server Installation

1. Clone the AzerothCore repository:
   ```bash
   git clone https://github.com/azerothcore/azerothcore.git
   cd azerothcore
   ```

2. Install system dependencies:
   ```bash
   ./bin/azerothcore-env.sh install
   ```

3. Configure and build:
   ```bash
   mkdir build && cd build
   cmake .. -DCMAKE_INSTALL_PREFIX="../install" -DWITH_WARNINGS=0
   make -j$(nproc)
   make install
   ```

4. Apply classless patches:
   ```bash
   cd ../sql/character
   for patch in /path/to/classless-wotlk/sql/*.sql; do
       mysql -u root -p character < "$patch"
   done
   ```

5. Configure the server:
   ```bash
   cp install/etc/worldserver.conf.dist install/etc/worldserver.conf
   # Edit worldserver.conf with classless settings
   ```

6. Start the server:
   ```bash
   ./bin/worldserver
   ```

### Client Installation

1. Install the WotLK client (3.3.5a)
2. Configure the realmlist:
   ```bash
   echo "set realmlist 127.0.0.1:8085" > Wow/Client/WotLK/realmlist.wtf
   ```

3. Launch the game and create a classless character

## Configuration

### Server Configuration (worldserver.conf)

```ini
# Classless WotLK Configuration
ClasslessMode = 1
AllowedClasses = 0,1,2,3,4,5,6,7,8,9,11
MaxLevel = 80
StartingGold = 1000000
AllowAllTalents = 1
AllowAllSpells = 1
AllowAllMounts = 1
AllowAllPets = 1
AllowAllSkills = 1
AllowAllItems = 1
AllowAllAchievements = 1
AllowAllQuests = 1
AllowAllGear = 1
```

### Database Configuration

The database patches are located in the `sql/` directory and should be applied in order:

1. `0001_classless_character_creation.sql` - Creates classless character support
2. `0002_classless_all_spells.sql` - Grants all spells to classless characters
3. `0003_classless_talents.sql` - Grants all talents to classless characters
4. `0004_classless_skills.sql` - Grants all skills to classless characters
5. `0005_classless_mounts.sql` - Grants all mounts to classless characters
6. `0006_classless_pets.sql` - Grants all pets to classless characters
7. `0007_classless_items.sql` - Grants all items to classless characters
8. `0008_classless_achievements.sql` - Grants all achievements to classless characters
9. `0009_classless_quests.sql` - Grants all quests to classless characters
10. `0010_classless_gear.sql` - Grants all gear to classless characters

## Troubleshooting

### Common Issues

1. **Cannot connect to server**: Ensure the realmlist is correctly configured
2. **Character creation fails**: Check that the database patches were applied correctly
3. **Missing textures**: Ensure you're using the official WotLK client without custom textures
4. **Server crashes**: Check the worldserver.log for error messages

### Logs

- Server logs: `install/logs/`
- Client logs: `Wow/Client/WotLK/wtf/`

## Support

For support and questions, please visit our [GitHub repository](https://github.com/classless-wotlk/classless-wotlk) or join our [Discord server](https://discord.gg/classlesswotlk).

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

## Credits

- AzerothCore team for the server framework
- WoW community for the WotLK client
- Classless WotLK development team
