================================================================================
                        SPECTRE VLC LAUNCHER GUIDE
================================================================================

LOCATION: vlc-3.0.21/launch_spectre.bat

================================================================================
QUICK START
================================================================================

1. Normal Launch:
   Double-click: launch_spectre.bat
   
   OR from command line:
   cd vlc-3.0.21
   launch_spectre.bat

2. Debug Launch (keeps console open):
   launch_spectre.bat debug

================================================================================
WHAT THE LAUNCHER DOES
================================================================================

[1/6] Checks Prerequisites
      - Verifies vlc.exe exists (compiled or in bin/)
      - Checks for theme.xml in share/skins2/default/
      - Validates required files

[2/6] Deploys Assets
      - Copies PNG files from ../assets/ to share/skins2/default/
      - Required files:
        * main_bg.png (background image)
        * buttons_strip.png (control buttons)
        * cone_icon.png (VLC icon)

[3/6] Sets Up Cache Directory
      - Creates %TEMP%\spectre_cache\
      - Used for downloaded scary images/sounds

[4/6] Configures Environment
      - Sets VLC_DATA_PATH=./share
      - Sets VLC_PLUGIN_PATH=./plugins (if exists)

[5/6] Builds Launch Command
      - Configures skins2 interface
      - Loads Spectre theme
      - Enables extension auto-loader
      - Sets up logging

[6/6] Launches VLC
      - Starts VLC with all configurations
      - Creates spectre_debug.log for troubleshooting

================================================================================
LAUNCH COMMAND BREAKDOWN
================================================================================

vlc.exe
  --data-path "./share"                    # VLC data directory
  --intf skins2                            # Use skins2 interface
  --skins2-last "./share/skins2/default/theme.xml"  # Load Spectre skin
  --no-qt-name-in-title                    # Clean window title
  --title "Spectre Media Player"           # Custom title
  --extraintf luaintf                      # Load Lua interface
  --lua-intf spectre_loader                # Auto-load extension
  --extraintf logger                       # Enable logging
  --verbose 2                              # Verbose level 2
  --file-logging                           # Log to file
  --logfile "spectre_debug.log"            # Log file path

Debug mode adds:
  --console                                # Show console window
  --extraintf rc                           # Remote control interface

================================================================================
EXPECTED BEHAVIOR
================================================================================

After Launch:
1. VLC opens with dark Spectre skin (800x600 window)
2. Extension auto-loads in background
3. Horror events begin after 30 seconds
4. Log file created: vlc-3.0.21/spectre_debug.log

During Playback:
- Every 30 seconds: Random check (5% chance)
- If triggered: Downloads and displays scary image OR plays scary sound
- Log messages appear in spectre_debug.log

================================================================================
TROUBLESHOOTING
================================================================================

Problem: "vlc.exe not found"
Solution: This launcher expects a compiled VLC in vlc-3.0.21/
          If using installed VLC, use launch-vlc-spectre.bat in parent folder

Problem: "theme.xml not found"
Solution: Ensure you've created the Spectre skin files
          Check: vlc-3.0.21/share/skins2/default/theme.xml

Problem: Assets not copying
Solution: Verify assets folder exists: assets/
          Contains: main_bg.png, buttons_strip.png, cone_icon.png

Problem: Extension not loading
Solution: 1. Check log file: spectre_debug.log
          2. Look for "[Spectre Loader]" messages
          3. Verify: share/lua/extensions/spectre.lua exists
          4. Verify: share/lua/intf/spectre_loader.lua exists

Problem: No scary events triggering
Solution: 1. Check log for "[Spectre] Scare check" messages
          2. Verify internet connection (downloads from APIs)
          3. Wait at least 30 seconds during playback
          4. Try increasing trigger chance in spectre.lua

Problem: Skin not displaying
Solution: 1. Check that all PNG assets are in share/skins2/default/
          2. Verify theme.xml references correct file paths
          3. Check log for skin loading errors

================================================================================
DEBUG MODE
================================================================================

Launch with: launch_spectre.bat debug

Features:
- Console window stays open
- See real-time log messages
- VLC console output visible
- Easier to diagnose issues
- Press Ctrl+C to stop VLC

Use debug mode when:
- Extension not loading
- Scary events not triggering
- Investigating errors
- Testing modifications

================================================================================
LOG FILE ANALYSIS
================================================================================

Location: vlc-3.0.21/spectre_debug.log

Key Messages to Look For:

Extension Loading:
  [Spectre Loader] Starting auto-loader...
  [Spectre Loader] Extension file found!
  [Spectre Loader] Extension loaded successfully!
  [Spectre] Extension activated

Scare Checks:
  [Spectre] Scare check: rolled X/100
  [Spectre] Safe... for now

Scare Triggers:
  [Spectre] ⚠️  TRIGGERING SCARE EVENT! ⚠️
  [Spectre] 👻 Triggering IMAGE scare...
  [Spectre] 🔊 Triggering SOUND scare...
  HELP ME

Asset Downloads:
  [Spectre] Fetching scary image from Unsplash...
  [Spectre] Image URL: https://...
  [Spectre] Downloaded X bytes

Errors:
  [Spectre] Failed to fetch from Unsplash API
  [Spectre] Failed to download image
  [Spectre Loader] ERROR: spectre.lua not found

================================================================================
CUSTOMIZATION
================================================================================

Adjust Scare Frequency:
Edit: share/lua/extensions/spectre.lua
Change:
  local CHECK_INTERVAL = 30000000  -- 30 seconds
  local TRIGGER_CHANCE = 5         -- 5% chance

Modify Skin:
Edit: share/skins2/default/theme.xml
Change button positions, colors, sizes, etc.

Change Search Terms:
Edit: share/lua/extensions/spectre.lua
Modify:
  local SEARCH_TERMS = {"scary face", "skull", "ghost", ...}

================================================================================
FILE STRUCTURE
================================================================================

vlc-3.0.21/
├── launch_spectre.bat              ← THIS LAUNCHER
├── vlc.exe                          ← VLC executable (if compiled)
├── spectre_debug.log                ← Created on launch
├── share/
│   ├── lua/
│   │   ├── extensions/
│   │   │   └── spectre.lua          ← Horror extension
│   │   └── intf/
│   │       └── spectre_loader.lua   ← Auto-loader
│   └── skins2/
│       └── default/
│           ├── theme.xml            ← Spectre skin
│           ├── main_bg.png          ← Background
│           ├── buttons_strip.png    ← Buttons
│           └── cone_icon.png        ← Icon

../assets/                           ← Source assets
├── main_bg.png
├── buttons_strip.png
└── cone_icon.png

%TEMP%/spectre_cache/                ← Runtime cache
├── scare_img_*.jpg                  ← Downloaded images
└── scare_sound_*.mp3                ← Downloaded sounds

================================================================================
SAFETY NOTES
================================================================================

⚠️  WARNING: This extension downloads random horror content from the internet

- Images may be disturbing or graphic
- Sounds may be loud or startling
- Not recommended for:
  * Sensitive users
  * Children
  * Users with heart conditions
  * Users prone to anxiety

To disable horror events:
- Close VLC
- Or launch VLC without --lua-intf spectre_loader

================================================================================
SUPPORT
================================================================================

For issues or questions:
1. Check spectre_debug.log for error messages
2. Run in debug mode: launch_spectre.bat debug
3. Review SPECTRE_SETUP.md for detailed documentation
4. Check AUTO_LOAD_SOLUTION.md for technical details

================================================================================
