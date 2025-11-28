# VLC Spectre - Compilation and Installation Guide

## Current Status

✅ **All assets updated in VLC source:**
- `vlc-3.0.21/share/skins2/default/main_bg.png`
- `vlc-3.0.21/share/skins2/default/buttons_strip.png`
- `vlc-3.0.21/share/skins2/default/buttons_hover.png` (NEW)
- `vlc-3.0.21/share/skins2/default/slider_bg.png` (NEW)
- `vlc-3.0.21/share/skins2/default/cone_icon.png`

✅ **Theme.xml updated** with all new assets and proper references

✅ **Horror Extension (spectre.lua)** with jumpscare functionality:
- Downloads scary images from Unsplash API
- Downloads scary sounds from Freesound API
- 5% chance every 30 seconds during playback
- Logs "HELP ME" when triggered

✅ **Auto-loader (spectre_loader.lua)** to activate extension on startup

## Compilation Requirements

### Windows Build Environment

To compile VLC 3.0.21 on Windows, you need:

1. **MSYS2** - Unix-like environment for Windows
   - Download: https://www.msys2.org/
   - Install to: `C:\msys64`

2. **MinGW-w64 Toolchain**
   ```bash
   pacman -S mingw-w64-x86_64-toolchain
   ```

3. **Build Dependencies**
   ```bash
   pacman -S base-devel mingw-w64-x86_64-gcc mingw-w64-x86_64-pkg-config
   pacman -S autoconf automake libtool make git
   ```

4. **VLC Dependencies**
   ```bash
   pacman -S mingw-w64-x86_64-lua mingw-w64-x86_64-qt5
   pacman -S mingw-w64-x86_64-ffmpeg mingw-w64-x86_64-libvorbis
   ```

### Compilation Steps

1. **Open MSYS2 MinGW 64-bit terminal**

2. **Navigate to VLC source**
   ```bash
   cd /c/Users/vidit/Desktop/Projects/Kiro_Hackathon/vlc-3.0.21
   ```

3. **Bootstrap** (if not already done)
   ```bash
   ./bootstrap
   ```

4. **Configure**
   ```bash
   ./configure --enable-skins2 --enable-lua
   ```

5. **Compile**
   ```bash
   make -j4
   ```
   (This will take 2-4 hours)

6. **Install** (optional)
   ```bash
   make install
   ```

## Alternative: Quick Test Without Compilation

Since compilation takes hours, you can test the skin and extension separately:

### Test the Skin

1. Create VLT package:
   ```powershell
   .\create_vlt_package.ps1
   ```

2. Double-click `spectre.vlt` to install in VLC

### Test the Extension

1. Copy files to installed VLC:
   ```powershell
   Copy-Item vlc-3.0.21\share\lua\extensions\spectre.lua -Destination "C:\Program Files\VideoLAN\VLC\lua\extensions\"
   Copy-Item vlc-3.0.21\share\lua\intf\spectre_loader.lua -Destination "C:\Program Files\VideoLAN\VLC\lua\intf\"
   ```

2. Launch VLC:
   ```powershell
   & "C:\Program Files\VideoLAN\VLC\vlc.exe" --extraintf luaintf --lua-intf spectre_loader
   ```

## Jumpscare Verification

The extension logs all activity. To verify jumpscares are working:

1. **Enable verbose logging:**
   ```bash
   vlc --verbose 2 --file-logging --logfile spectre.log
   ```

2. **Check for these messages:**
   ```
   [Spectre] Extension activated
   [Spectre] Horror events enabled...
   [Spectre] Scare check: rolled X/100
   [Spectre] ⚠️  TRIGGERING SCARE EVENT! ⚠️
   [Spectre] 👻 Triggering IMAGE scare...
   [Spectre] Fetching scary image from Unsplash...
   [Spectre] Image URL: https://...
   [Spectre] Downloaded X bytes
   HELP ME
   ```

3. **Check cache directory:**
   ```
   %TEMP%\spectre_cache\
   ```
   Should contain downloaded images and sounds.

## File Structure After Compilation

```
vlc-3.0.21/
├── vlc.exe                          ← Compiled VLC executable
├── share/
│   ├── skins2/
│   │   └── default/
│   │       ├── theme.xml            ← Spectre skin
│   │       ├── main_bg.png          ← Background
│   │       ├── buttons_strip.png    ← Normal buttons
│   │       ├── buttons_hover.png    ← Hover buttons
│   │       ├── slider_bg.png        ← Slider background
│   │       └── cone_icon.png        ← Icon
│   └── lua/
│       ├── extensions/
│       │   └── spectre.lua          ← Horror extension
│       └── intf/
│           └── spectre_loader.lua   ← Auto-loader
```

## Launch Command After Compilation

```bash
./vlc.exe \
  --intf skins2 \
  --skins2-last "./share/skins2/default/theme.xml" \
  --extraintf luaintf \
  --lua-intf spectre_loader \
  --verbose 2
```

Or use the provided launcher:
```bash
./launch_spectre.bat
```

## Troubleshooting Compilation

### Error: "configure: error: Could not find lua"
```bash
pacman -S mingw-w64-x86_64-lua
export LUA_CFLAGS="-I/mingw64/include"
export LUA_LIBS="-L/mingw64/lib -llua"
```

### Error: "No package 'qt5' found"
```bash
pacman -S mingw-w64-x86_64-qt5
```

### Error: "make: *** No targets specified"
```bash
./bootstrap
./configure
```

## Expected Behavior

After successful compilation and launch:

1. **VLC opens with Spectre skin**
   - Dark background from main_bg.png
   - Button strip with blood splatter effects
   - Hover effects on buttons
   - Slider backgrounds visible

2. **Horror extension activates**
   - Logs appear in console/log file
   - Every 30 seconds: random check
   - 5% chance: downloads and displays scary content

3. **Corruption elements visible**
   - Play button 5px lower than others
   - Volume slider 3px narrower
   - Hidden panel ready for jumpscares

## Next Steps

1. **If you want to compile:**
   - Install MSYS2 and dependencies
   - Run compilation steps above
   - Wait 2-4 hours
   - Test with launch_spectre.bat

2. **If you want to test now:**
   - Use the VLT package for skin testing
   - Copy Lua files to installed VLC
   - Test extension functionality separately

## Notes

- Compilation is **not required** to test the skin and extension
- The skin works on any VLC installation
- The extension works on any VLC installation
- Compilation only bundles everything together in one custom VLC build
- Estimated compilation time: **2-4 hours** on modern hardware

## Support

Check these files for detailed information:
- `SPECTRE_SETUP.md` - Complete setup guide
- `AUTO_LOAD_SOLUTION.md` - Technical implementation details
- `vlc-3.0.21/LAUNCHER_README.txt` - Launcher usage guide
