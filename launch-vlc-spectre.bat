@echo off
REM VLC Spectre Launcher - Windows Batch Script
REM Launches VLC with Spectre skin and auto-loads the horror extension

echo ========================================
echo VLC Spectre Launcher
echo ========================================
echo.

REM Set paths
set VLC_SOURCE=%~dp0vlc-3.0.21
set SKIN_PATH=%VLC_SOURCE%\share\skins2\default\theme.xml
set VLC_EXE=vlc.exe

echo Checking for VLC installation...
echo.

REM Try to find VLC in common installation paths
set VLC_PATH=

REM Check Program Files
if exist "C:\Program Files\VideoLAN\VLC\vlc.exe" (
    set VLC_PATH=C:\Program Files\VideoLAN\VLC\vlc.exe
    goto :found
)

REM Check Program Files (x86)
if exist "C:\Program Files (x86)\VideoLAN\VLC\vlc.exe" (
    set VLC_PATH=C:\Program Files (x86)\VideoLAN\VLC\vlc.exe
    goto :found
)

REM Check if vlc is in PATH
where vlc.exe >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    set VLC_PATH=vlc.exe
    goto :found
)

REM VLC not found
echo ERROR: VLC not found!
echo.
echo Please install VLC Media Player or add it to your PATH
echo Download from: https://www.videolan.org/vlc/
echo.
pause
exit /b 1

:found
echo Found VLC at: %VLC_PATH%
echo.
echo Launching VLC with Spectre configuration...
echo - Skin: Spectre (custom horror theme)
echo - Extension: Auto-loading horror events
echo.

REM Launch VLC with Spectre configuration
REM --intf skins2: Use skins2 interface
REM --skins2-last: Load the specified skin
REM --extraintf luaintf: Load Lua interface in addition to skins2
REM --lua-intf spectre_loader: Auto-load the Spectre extension

"%VLC_PATH%" ^
    --intf skins2 ^
    --skins2-last "%SKIN_PATH%" ^
    --extraintf luaintf ^
    --lua-intf spectre_loader ^
    --verbose 2

echo.
echo VLC has been closed
pause
