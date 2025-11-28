# VLC Spectre - Horror Extension Setup Guide

## Overview

This project adds a horror-themed experience to VLC Media Player with:
- **Custom Spectre Skin**: Dark theme with intentional design flaws
- **Horror Extension**: Random scary images and sounds during playback
- **Auto-loader**: Automatically activates the extension on startup

## Files Created

### 1. Spectre Skin
- **Location**: `vlc-3.0.21/share/skins2/default/theme.xml`
- **Assets**: `vlc-3.0.21/share/skins2/default/*.png`
- **Features**:
  - 800x600 custom interface
  - Play button offset by +5px (intentional corruption)
  - Volume slider 3px narrower (intentional corruption)
  - Hidden panel overlay for jump scares

### 2. Spectre Extension
- **Location**: `vlc-3.0.21/share/lua/extensions/spectre.lua`
- **Features**:
  - Checks every 30 seconds for scare triggers
  - 5% chance per check to trigger an event
  - Downloads scary images from Unsplash API
  - Downloads scary sounds from Freesound API
  - Displays images and plays sounds randomly

### 3. Auto-Loader Interface
- **Location**: `vlc-3.0.21/share/lua/intf/spectre_loader.lua`
- **Purpose**: Automatically loads and activates the Spectre extension on VLC startup
- **Method**: Uses `dofile()` to execute the extension and calls `activate()`

## Installation Methods

### Method 1: Using Launcher Scripts (Recommended)

#### Windows Batch File
```batch
launch-vlc-spectre.bat
```
Double-click to launch VLC with Spectre configuration.

#### PowerShell Script
```powershell
.\launch-vlc-spectre.ps1
```
Right-click and "Run with PowerShell" or execute from PowerShell terminal.

### Method 2: Manual VLC Installation

If you have VLC installed, copy the files to your VLC installation:

1. **Copy Skin Files**:
   ```
   Copy from: vlc-3.0.21/share/skins2/default/*
   Copy to: C:\Program Files\VideoLAN\VLC\skins\*
   ```

2. **Copy Extension**:
   ```
   Copy from: vlc-3.0.21/share/lua/extensions/spectre.lua
   Copy to: C:\Program Files\VideoLAN\VLC\lua\extensions\spectre.lua
   ```

3. **Copy Auto-Loader**:
   ```
   Copy from: vlc-3.0.21/share/lua/intf/spectre_loader.lua
   Copy to: C:\Program Files\VideoLAN\VLC\lua\intf\spectre_loader.lua
   ```

4. **Launch VLC with Command Line**:
   ```batch
   vlc.exe --intf skins2 --skins2-last "C:\Program Files\VideoLAN\VLC\skins\theme.xml" --extraintf luaintf --lua-intf spectre_loader
   ```

### Method 3: Compile VLC from Source

For advanced users who want to build VLC with Spectre built-in:

1. Install build dependencies (MSYS2, MinGW, etc.)
2. Navigate to `vlc-3.0.21/`
3. Run `./configure` and `make`
4. The Spectre files are already in the correct locations in the source tree

## Command Line Arguments Explained

```batch
vlc.exe ^
    --intf skins2                           # Use skins2 interface (not default Qt)
    --skins2-last "path/to/theme.xml"       # Load the Spectre skin
    --extraintf luaintf                     # Load Lua interface in addition to skins2
    --lua-intf spectre_loader               # Run the spectre_loader.lua interface
    --verbose 2                             # Enable verbose logging (optional)
```

## How It Works

### Auto-Loading Process

1. **VLC Starts** with `--lua-intf spectre_loader`
2. **spectre_loader.lua** executes:
   - Waits 2 seconds for VLC to initialize
   - Locates `spectre.lua` in extensions directory
   - Uses `dofile()` to load the extension
   - Calls `activate()` to start the horror events
3. **spectre.lua** runs:
   - Enters infinite loop checking every 30 seconds
   - 5% chance per check to trigger a scare
   - Downloads and displays/plays scary content

### Scare Event Flow

```
Timer (30s) → Random Check (5%) → Trigger Event
                                      ↓
                            ┌─────────┴─────────┐
                            ↓                   ↓
                      Image Scare         Sound Scare
                            ↓                   ↓
                    Unsplash API        Freesound API
                            ↓                   ↓
                    Download Image      Download Audio
                            ↓                   ↓
                    Show via OSD        Play via Playlist
```

## Configuration

### API Keys
Located in `appsettings.json`:
```json
{
  "ScareConfig": {
    "UnsplashAccessKey": "85X1wfGGaP0xnKVBGQx6xv49fOE4-4xELwZBfruitXQ",
    "FreesoundApiKey": "HMTnCSkqCBzRXCZO3ZNQM6GvIQmU48YG0PazHrUq",
    "SearchTerms": ["scary face", "skull", "ghost", "horror", "zombie", "clown"],
    "SafeSearch": true
  }
}
```

### Adjusting Scare Frequency
Edit `vlc-3.0.21/share/lua/extensions/spectre.lua`:
```lua
local CHECK_INTERVAL = 30000000  -- 30 seconds (change to adjust)
local TRIGGER_CHANCE = 5         -- 5% chance (change to adjust)
```

### Cache Directory
Downloaded assets are stored in:
```
%APPDATA%\vlc\spectre_cache\
```

## Troubleshooting

### Extension Not Loading
1. Check VLC messages log (Tools → Messages, Verbosity: 2)
2. Look for "[Spectre Loader]" messages
3. Verify file paths are correct

### No Scary Events Triggering
1. Check that extension activated: Look for "[Spectre] Extension activated"
2. Verify API keys are valid
3. Check internet connection (required for downloading assets)
4. Increase `TRIGGER_CHANCE` for testing

### Skin Not Displaying
1. Verify `--intf skins2` is in command line
2. Check that `theme.xml` path is correct
3. Ensure all PNG assets are in the same directory as theme.xml

### VLC Not Found
1. Install VLC from https://www.videolan.org/vlc/
2. Or update the launcher script with your VLC path

## Testing

### Test Extension Manually
1. Open VLC
2. Go to View → Extensions Manager
3. Find "Spectre" in the list
4. Click to activate
5. Check Tools → Messages for log output

### Test Skin Manually
1. Open VLC
2. Go to Tools → Preferences
3. Click "All" (bottom left)
4. Navigate to Interface → Main interfaces → Skins
5. Browse to `theme.xml`
6. Restart VLC

## Safety Notes

⚠️ **Warning**: This extension downloads random horror content from the internet.
- Images may be disturbing
- Sounds may be loud or startling
- Not recommended for sensitive users
- Disable by closing VLC or deactivating the extension

## Technical Details

### VLC Lua API Used
- `vlc.stream()` - HTTP requests for API calls
- `vlc.misc.mwait()` - Timer for 30-second intervals
- `vlc.osd.message()` - On-screen display notifications
- `vlc.playlist.add()` - Audio playback
- `vlc.msg.*()` - Logging functions

### Compatibility
- VLC 3.0.x (tested with 3.0.21)
- Windows (batch/PowerShell scripts)
- Lua 5.1 (VLC's embedded version)

## Credits

- **Unsplash API**: https://unsplash.com/developers
- **Freesound API**: https://freesound.org/docs/api/
- **VLC Lua Documentation**: https://wiki.videolan.org/Documentation:Lua/

## License

This project is for educational/entertainment purposes.
VLC Media Player is licensed under GPL v2.
