# 🎭 Spectre - Horror-Themed Media Player

**A custom-built VLC Media Player 3.0.21** compiled from source with integrated horror modifications. This is not just a skin - it's a complete custom VLC build featuring a dark horror-themed interface and a Lua extension that triggers random scary events during playback.

![Spectre](https://img.shields.io/badge/VLC-3.0.21-orange) ![License](https://img.shields.io/badge/license-GPL--2.0-blue) ![Platform](https://img.shields.io/badge/platform-Windows-lightgrey) ![Build](https://img.shields.io/badge/build-from%20source-red)

## ⚠️ Warning

This project downloads and displays random horror content from the internet during video playback. Not recommended for:
- Sensitive users
- Children
- Users with heart conditions
- Users prone to anxiety

## � Kiroween Hackathon Submission

This project was built for the **Kiroween Hackathon** using **Kiro AI** as the primary development assistant. Kiro was instrumental in:

- **Spec-Driven Development**: Used Kiro's spec feature to define requirements, design, and implementation tasks for the corrupted horror skin
- **Code Generation**: Generated Lua extension code for the horror event system
- **API Integration**: Implemented Unsplash and Freesound API integrations with Kiro's assistance
- **Documentation**: Created comprehensive documentation and setup guides
- **Debugging**: Troubleshot VLC skin XML issues and Lua extension loading problems
- **Project Structure**: Organized the codebase and created launcher scripts

The `.kiro/specs/` folder contains the full specification documents that guided the development process, showcasing how AI-assisted development can accelerate complex projects like VLC modifications.

### Kiro Development Workflow

1. **Requirements Phase**: Defined the horror-themed skin concept and extension behavior in `requirements.md`
2. **Design Phase**: Created detailed technical specifications for VLC Skins2 XML structure and Lua extension architecture in `design.md`
3. **Implementation Phase**: Broke down the work into manageable tasks in `tasks.md` and implemented each component
4. **Iteration**: Used Kiro to debug issues, refine the design, and add features like API integration and auto-loading

This spec-driven approach with Kiro enabled rapid development of a complex VLC modification that would typically take weeks to implement manually.

## 🎯 Features

### Custom Horror Skin
- **Dark themed interface** (800x600)
- **Custom button graphics** with blood splatter effects
- **Hover states** for interactive feedback
- **Slider backgrounds** for time and volume controls
- **Intentional corruption elements** for unsettling UX:
  - Play button offset by +5px
  - Volume slider 3px narrower than background
  - Hidden jumpscare overlay panel

### Horror Extension
- **Random scary events** during playback
- **5% chance every 30 seconds** to trigger
- **Downloads scary images** from Unsplash API
- **Downloads scary sounds** from Freesound API
- **Automatic activation** on VLC startup
- **Comprehensive logging** for debugging

## 📁 Project Structure

```
vlc-spectre/
├── assets/                          # Source image assets
│   ├── main_bg.png                  # Background image
│   ├── buttons_strip.png            # Normal button states
│   ├── buttons_hover.png            # Hover button states
│   ├── slider_bg.png                # Slider backgrounds
│   └── cone_icon.png                # VLC icon
│
├── vlc-3.0.21/                      # VLC source code (modified)
│   ├── share/
│   │   ├── skins2/default/          # Spectre skin files
│   │   └── lua/
│   │       ├── extensions/          # Horror extension
│   │       └── intf/                # Auto-loader
│   └── launch_spectre.bat           # Launcher for compiled VLC
│
├── launch-vlc-spectre.bat           # Launcher for installed VLC
├── launch-vlc-spectre.ps1           # PowerShell launcher
├── create_vlt_package.ps1           # Creates installable skin
├── spectre.vlt                      # Installable skin package
├── appsettings.json                 # API configuration
│
└── docs/                            # Documentation
    ├── SPECTRE_SETUP.md             # Setup guide
    ├── AUTO_LOAD_SOLUTION.md        # Technical details
    ├── COMPILE_AND_RUN.md           # Compilation guide
    └── STATUS_SUMMARY.md            # Project status
```

## 🚀 Quick Start

### Building the Custom VLC

This project compiles VLC 3.0.21 from source with the Spectre modifications baked in.

**Requirements:**
- MSYS2 (MinGW-w64 environment for Windows)
- 2-4 hours for compilation
- ~10GB disk space

**Build Steps:**

1. **Clone this repository**
   ```bash
   git clone https://github.com/yourusername/vlc-spectre.git
   cd vlc-spectre
   ```

2. **Install MSYS2** (if not already installed)
   - Download from: https://www.msys2.org/
   - Install to: `C:\msys64`

3. **Open MSYS2 MinGW 64-bit terminal and navigate to project**
   ```bash
   cd /c/path/to/vlc-spectre/vlc-3.0.21
   ```

4. **Run the build script**
   ```bash
   ./build_vlc.sh
   ```
   This will:
   - Install required dependencies
   - Verify Spectre files are in place
   - Configure the build with Skins2 and Lua support
   - Compile VLC (2-4 hours)
   - Create `vlc.exe` with integrated Spectre modifications

5. **Launch your custom VLC**
   ```bash
   ./launch_spectre.bat
   ```

### Alternative: Test Without Compiling

If you want to test the skin and extension separately on an existing VLC installation, see [COMPILE_AND_RUN.md](docs/COMPILE_AND_RUN.md) for quick test instructions.

## 📖 Documentation

- **[SPECTRE_SETUP.md](SPECTRE_SETUP.md)** - Complete setup and usage guide
- **[AUTO_LOAD_SOLUTION.md](AUTO_LOAD_SOLUTION.md)** - Technical implementation details
- **[COMPILE_AND_RUN.md](COMPILE_AND_RUN.md)** - VLC compilation instructions
- **[STATUS_SUMMARY.md](STATUS_SUMMARY.md)** - Project status and features

## 🔧 Configuration

### API Keys

The extension uses two APIs for fetching horror content. Keys are configured in `appsettings.json`:

```json
{
  "ScareConfig": {
    "UnsplashAccessKey": "YOUR_KEY_HERE",
    "FreesoundApiKey": "YOUR_KEY_HERE",
    "SearchTerms": ["scary face", "skull", "ghost", "horror", "zombie", "clown"],
    "SafeSearch": true
  }
}
```

**Get your API keys:**
- Unsplash: https://unsplash.com/developers
- Freesound: https://freesound.org/apiv2/apply/

### Adjusting Scare Frequency

Edit `vlc-3.0.21/share/lua/extensions/spectre.lua`:

```lua
local CHECK_INTERVAL = 30000000  -- 30 seconds (in microseconds)
local TRIGGER_CHANCE = 5         -- 5% chance per check
```

## 🎨 Skin Customization

The skin is defined in `vlc-3.0.21/share/skins2/default/theme.xml`. You can:
- Modify button positions
- Change colors and transparency
- Adjust window size
- Add new controls

Replace assets in the `assets/` folder and run `create_vlt_package.ps1` to rebuild.

## 🐛 Troubleshooting

### Extension Not Loading
- Check VLC Messages: `Tools → Messages` (Ctrl+M)
- Set Verbosity to "2 (Debug)"
- Look for `[Spectre]` log messages

### No Scary Events Triggering
- Verify internet connection (required for API calls)
- Check API keys in `appsettings.json`
- Increase `TRIGGER_CHANCE` for testing
- Ensure media is playing (extension only active during playback)

### Skin Not Displaying
- Verify all PNG assets are in the correct directory
- Check that `theme.xml` references match asset filenames
- Try using the VLT package: double-click `spectre.vlt`

## 📊 Technical Details

### Technologies Used
- **VLC Media Player 3.0.21** - Compiled from source with custom modifications
- **MSYS2/MinGW-w64** - Windows build environment
- **VLC Skins2** - Custom UI framework (compiled into VLC)
- **Lua 5.1** - Extension scripting language (integrated)
- **Unsplash API** - Scary image source
- **Freesound API** - Scary sound source

### Key Components

1. **theme.xml** - Skin definition (VLC Skins2 XML format)
2. **spectre.lua** - Horror extension (Lua script)
3. **spectre_loader.lua** - Auto-loader interface (Lua script)
4. **Launcher scripts** - Batch/PowerShell for easy launching

### How It Works

```
Custom VLC Build Process
    ↓
VLC 3.0.21 source + Spectre modifications
    ↓
Compile with Skins2 & Lua enabled
    ↓
Result: vlc.exe with integrated horror features
    ↓
VLC Startup
    ↓
Load Skins2 Interface (Spectre theme)
    ↓
Load Lua Interface (spectre_loader)
    ↓
spectre_loader executes spectre.lua
    ↓
Extension activates and starts timer loop
    ↓
Every 30 seconds: Random check (5% chance)
    ↓
If triggered: Download and display/play scary content
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### Areas for Contribution
- Additional skin themes
- More scare event types
- Improved API integration
- Cross-platform support (Linux, macOS)
- Additional horror content sources

## 📜 License

This project is licensed under the GPL-2.0 License - see the LICENSE file for details.

VLC Media Player is licensed under GPL v2 by VideoLAN.

## 🙏 Credits

- **VLC Media Player** - VideoLAN (https://www.videolan.org/)
- **Unsplash API** - Free high-quality images (https://unsplash.com/)
- **Freesound API** - Collaborative sound database (https://freesound.org/)

## ⚡ Performance

- **Skin**: Minimal performance impact
- **Extension**: Lightweight, only active during playback
- **API Calls**: Asynchronous, non-blocking
- **Cache**: Downloads stored in `%TEMP%\spectre_cache\`

## 🔒 Privacy

- Extension only downloads content when triggered
- No personal data collected or transmitted
- API calls are made directly to Unsplash and Freesound
- Downloaded content cached locally

## 📞 Support

For issues, questions, or suggestions:
- Open an issue on GitHub
- Check the documentation in the `docs/` folder
- Review the troubleshooting section above

---

**Made with 🎭 for horror enthusiasts and VLC lovers**

*Disclaimer: This is an unofficial modification of VLC Media Player. Use at your own risk.*
