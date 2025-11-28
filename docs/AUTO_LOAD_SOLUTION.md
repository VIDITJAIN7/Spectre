# VLC Spectre Auto-Load Solution

## Selected Approach: OPTION B - Create Autoload Interface

**Reason for Selection**: This is the most reliable and cleanest method because:
1. ✅ No modification of existing VLC source files (safer for updates)
2. ✅ Uses VLC's built-in interface loading mechanism
3. ✅ Easy to enable/disable via command line
4. ✅ Follows VLC's extension architecture
5. ✅ Compatible with VLC 3.0.x API

---

## 1. Exact File Path Created

```
vlc-3.0.21/share/lua/intf/spectre_loader.lua
```

**File Type**: VLC Lua Interface Module  
**Purpose**: Auto-loads and activates the Spectre extension on VLC startup

---

## 2. Complete Code Block

The complete code has been written to:
```
vlc-3.0.21/share/lua/intf/spectre_loader.lua
```

**Key Functions**:
- `load_spectre_extension()` - Locates and loads spectre.lua
- Uses `dofile()` to execute the extension
- Calls `activate()` to start the horror events
- Includes error handling with `pcall()`
- Keeps interface alive with infinite loop

---

## 3. Command-Line Flags to Force Skins2 Mode

### Windows Batch File (launch-vlc-spectre.bat)
```batch
vlc.exe ^
    --intf skins2 ^
    --skins2-last "%SKIN_PATH%" ^
    --extraintf luaintf ^
    --lua-intf spectre_loader ^
    --verbose 2
```

### PowerShell (launch-vlc-spectre.ps1)
```powershell
& $VLC_PATH `
    --intf skins2 `
    --skins2-last "$SKIN_PATH" `
    --extraintf luaintf `
    --lua-intf spectre_loader `
    --verbose 2
```

### Direct Command Line
```bash
vlc --intf skins2 --skins2-last "./vlc-3.0.21/share/skins2/default/theme.xml" --extraintf luaintf --lua-intf spectre_loader
```

---

## 4. Explanation of Command-Line Arguments

| Argument | Purpose |
|----------|---------|
| `--intf skins2` | Forces VLC to use the skins2 interface instead of the default Qt interface |
| `--skins2-last "path/to/theme.xml"` | Loads the specified skin file (Spectre theme) |
| `--extraintf luaintf` | Loads the Lua interface **in addition to** skins2 (not instead of) |
| `--lua-intf spectre_loader` | Specifies which Lua interface script to run (our auto-loader) |
| `--verbose 2` | Enables verbose logging to see extension messages (optional) |

**Why `--extraintf` instead of `--intf`?**
- `--intf` replaces the main interface
- `--extraintf` adds an additional interface
- We need both skins2 (for UI) and luaintf (for extension loading)

---

## 5. How the Auto-Loading Works

### Execution Flow

```
1. VLC Starts
   ↓
2. Loads skins2 interface (Spectre theme)
   ↓
3. Loads luaintf with spectre_loader.lua
   ↓
4. spectre_loader.lua executes:
   - Waits 2 seconds for VLC initialization
   - Locates spectre.lua in extensions directory
   - Uses dofile() to load the extension code
   - Calls activate() function
   ↓
5. spectre.lua activate() runs:
   - Initializes cache directory
   - Starts trigger_loop()
   - Begins 30-second timer checks
   ↓
6. Horror events trigger randomly (5% chance per 30s)
```

### Code Injection Point

**File**: `vlc-3.0.21/share/lua/intf/spectre_loader.lua` (NEW FILE)  
**Location**: VLC's Lua interface directory  
**Loaded by**: VLC's `--lua-intf` command-line parameter

**Key Code Section**:
```lua
-- Load the extension using dofile
local success, err = pcall(function()
    dofile(ext_path)  -- Executes spectre.lua
end)

-- Activate the extension
if type(activate) == "function" then
    local success, err = pcall(activate)  -- Calls activate() from spectre.lua
end
```

---

## 6. Why This Location Was Chosen

### Advantages of `share/lua/intf/` Directory

1. **Official VLC Interface Location**
   - VLC automatically searches this directory for interface modules
   - No need to modify VLC's core source code
   - Follows VLC's plugin architecture

2. **Command-Line Accessible**
   - Can be loaded with `--lua-intf spectre_loader`
   - Easy to enable/disable without recompiling
   - Works with installed VLC or source builds

3. **Persistent Execution**
   - Interface modules stay running (unlike one-shot scripts)
   - Can maintain the extension's infinite loop
   - Proper lifecycle management (activate/deactivate)

4. **Error Isolation**
   - If the loader fails, VLC continues running
   - Doesn't break other VLC functionality
   - Easy to debug with `--verbose` flag

5. **No Source Modification**
   - Doesn't require editing existing VLC files
   - Safe for VLC updates
   - Can be distributed as standalone files

### Alternative Locations Considered (and why rejected)

| Location | Why Not Used |
|----------|--------------|
| `modules/common.lua` | Would affect all Lua scripts, too invasive |
| `intf/cli.lua` | Only loads with CLI interface, not skins2 |
| `intf/dummy.lua` | Exits immediately, can't maintain extension |
| Extension auto-load | VLC doesn't have built-in extension auto-load |

---

## 7. Installation Instructions

### Quick Start (Recommended)

**Windows Users**:
1. Double-click `launch-vlc-spectre.bat`
   OR
2. Run `.\launch-vlc-spectre.ps1` in PowerShell

**Manual Installation**:
1. Copy files to VLC installation:
   ```
   spectre.lua → C:\Program Files\VideoLAN\VLC\lua\extensions\
   spectre_loader.lua → C:\Program Files\VideoLAN\VLC\lua\intf\
   theme.xml + assets → C:\Program Files\VideoLAN\VLC\skins\
   ```

2. Launch VLC with:
   ```
   vlc --intf skins2 --skins2-last "path\to\theme.xml" --extraintf luaintf --lua-intf spectre_loader
   ```

---

## 8. Verification Steps

### Check if Auto-Load is Working

1. **Launch VLC** with the command line above
2. **Open Messages Window**: Tools → Messages (Ctrl+M)
3. **Set Verbosity**: Change to "2 (Debug)"
4. **Look for these messages**:
   ```
   [Spectre Loader] Starting auto-loader...
   [Spectre Loader] Extension file found!
   [Spectre Loader] Extension loaded successfully!
   [Spectre Loader] Activating Spectre extension...
   [Spectre] Extension activated
   [Spectre] Horror events enabled...
   ```

5. **Verify Extension is Running**:
   - View → Extensions Manager
   - "Spectre" should be listed and active

### Test Scare Events

1. Play any video
2. Wait 30 seconds
3. Check messages for:
   ```
   [Spectre] Scare check: rolled X/100
   ```
4. If roll ≤ 5, you'll see:
   ```
   [Spectre] ⚠️  TRIGGERING SCARE EVENT! ⚠️
   ```

---

## 9. Troubleshooting

### Extension Not Loading

**Problem**: No "[Spectre Loader]" messages in log

**Solutions**:
- Verify `--lua-intf spectre_loader` is in command line
- Check that `spectre_loader.lua` exists in `lua/intf/` directory
- Try `--verbose 2` for more detailed logging

### Extension Loads But Doesn't Activate

**Problem**: See "Extension loaded" but no "Extension activated"

**Solutions**:
- Check that `activate()` function exists in `spectre.lua`
- Verify no syntax errors in `spectre.lua`
- Check error messages in VLC log

### Skin Not Showing

**Problem**: Default VLC interface appears instead of Spectre skin

**Solutions**:
- Verify `--intf skins2` is first in command line
- Check that `theme.xml` path is correct and absolute
- Ensure all PNG assets are in same directory as `theme.xml`

---

## 10. Advanced Configuration

### Make Auto-Load Permanent

**Option 1: VLC Configuration File**

Edit `%APPDATA%\vlc\vlcrc` (Windows) and add:
```ini
[core]
intf=skins2
extraintf=luaintf

[lua]
lua-intf=spectre_loader

[skins2]
skins2-last=C:\path\to\theme.xml
```

**Option 2: Desktop Shortcut**

Create shortcut with target:
```
"C:\Program Files\VideoLAN\VLC\vlc.exe" --intf skins2 --skins2-last "C:\path\to\theme.xml" --extraintf luaintf --lua-intf spectre_loader
```

---

## Summary

✅ **Created**: `vlc-3.0.21/share/lua/intf/spectre_loader.lua`  
✅ **Method**: Auto-load interface (Option B)  
✅ **Command**: `vlc --intf skins2 --skins2-last "theme.xml" --extraintf luaintf --lua-intf spectre_loader`  
✅ **Launcher Scripts**: `launch-vlc-spectre.bat` and `launch-vlc-spectre.ps1`  
✅ **Documentation**: Complete setup guide in `SPECTRE_SETUP.md`

The Spectre horror extension will now automatically load and activate whenever VLC is launched with these parameters!
