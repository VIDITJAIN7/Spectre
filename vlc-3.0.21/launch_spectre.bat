@echo off
REM ============================================================================
REM Spectre VLC Launcher
REM Launches VLC with custom Spectre skin and horror extension
REM ============================================================================

setlocal enabledelayedexpansion

REM ============================================================================
REM CONFIGURATION
REM ============================================================================

set SCRIPT_DIR=%~dp0
set VLC_ROOT=%SCRIPT_DIR%
set ASSETS_DIR=%SCRIPT_DIR%..\assets
set SKIN_DIR=%VLC_ROOT%share\skins2\default
set CACHE_DIR=%TEMP%\spectre_cache
set LOG_FILE=%VLC_ROOT%spectre_debug.log

REM Check for debug mode
set DEBUG_MODE=0
if /i "%1"=="debug" set DEBUG_MODE=1

REM ============================================================================
REM BANNER
REM ============================================================================

echo.
echo ========================================================================
echo                         SPECTRE VLC LAUNCHER
echo                    Horror-Themed Media Player
echo ========================================================================
echo.

REM ============================================================================
REM PREREQUISITE CHECKS
REM ============================================================================

echo [1/6] Checking prerequisites...
echo.

REM Check if vlc.exe exists
if not exist "%VLC_ROOT%vlc.exe" (
    if not exist "%VLC_ROOT%bin\vlc.exe" (
        echo ERROR: vlc.exe not found!
        echo.
        echo This script expects VLC to be compiled in this directory.
        echo Please ensure you have either:
        echo   - vlc.exe in: %VLC_ROOT%
        echo   - vlc.exe in: %VLC_ROOT%bin\
        echo.
        echo If you haven't compiled VLC yet, this is source code only.
        echo Use the launcher scripts in the parent directory to use an installed VLC.
        echo.
        goto :error
    ) else (
        set VLC_EXE=%VLC_ROOT%bin\vlc.exe
    )
) else (
    set VLC_EXE=%VLC_ROOT%vlc.exe
)

echo    [OK] VLC executable found: !VLC_EXE!

REM Check if assets folder exists
if not exist "%ASSETS_DIR%" (
    echo    [WARNING] Assets folder not found: %ASSETS_DIR%
    echo    [INFO] Checking if assets are already deployed...
) else (
    echo    [OK] Assets folder found: %ASSETS_DIR%
)

REM Check if theme.xml exists
if not exist "%SKIN_DIR%\theme.xml" (
    echo    [ERROR] theme.xml not found at: %SKIN_DIR%\theme.xml
    echo    [INFO] Please ensure the Spectre skin is properly installed
    goto :error
) else (
    echo    [OK] Spectre theme found: %SKIN_DIR%\theme.xml
)

echo.

REM ============================================================================
REM ASSET DEPLOYMENT
REM ============================================================================

echo [2/6] Deploying assets...
echo.

REM Create skin directory if it doesn't exist
if not exist "%SKIN_DIR%" (
    echo    [INFO] Creating skin directory: %SKIN_DIR%
    mkdir "%SKIN_DIR%" 2>nul
)

REM Copy PNG assets from assets folder to skin directory
if exist "%ASSETS_DIR%" (
    echo    [INFO] Copying assets from: %ASSETS_DIR%
    
    REM Check and copy each required asset
    set ASSET_ERROR=0
    
    if exist "%ASSETS_DIR%\main_bg.png" (
        copy /Y "%ASSETS_DIR%\main_bg.png" "%SKIN_DIR%\main_bg.png" >nul 2>&1
        if !ERRORLEVEL! EQU 0 (
            echo    [OK] Copied: main_bg.png
        ) else (
            echo    [ERROR] Failed to copy: main_bg.png
            set ASSET_ERROR=1
        )
    ) else (
        echo    [WARNING] Asset not found: main_bg.png
    )
    
    if exist "%ASSETS_DIR%\buttons_strip.png" (
        copy /Y "%ASSETS_DIR%\buttons_strip.png" "%SKIN_DIR%\buttons_strip.png" >nul 2>&1
        if !ERRORLEVEL! EQU 0 (
            echo    [OK] Copied: buttons_strip.png
        ) else (
            echo    [ERROR] Failed to copy: buttons_strip.png
            set ASSET_ERROR=1
        )
    ) else (
        echo    [WARNING] Asset not found: buttons_strip.png
    )
    
    if exist "%ASSETS_DIR%\cone_icon.png" (
        copy /Y "%ASSETS_DIR%\cone_icon.png" "%SKIN_DIR%\cone_icon.png" >nul 2>&1
        if !ERRORLEVEL! EQU 0 (
            echo    [OK] Copied: cone_icon.png
        ) else (
            echo    [ERROR] Failed to copy: cone_icon.png
            set ASSET_ERROR=1
        )
    ) else (
        echo    [WARNING] Asset not found: cone_icon.png
    )
    
    if !ASSET_ERROR! EQU 1 (
        echo.
        echo    [WARNING] Some assets failed to copy, but continuing...
    )
) else (
    echo    [INFO] Assets folder not found, assuming assets already deployed
    
    REM Verify assets exist in skin directory
    if not exist "%SKIN_DIR%\main_bg.png" (
        echo    [WARNING] main_bg.png not found in skin directory
    )
    if not exist "%SKIN_DIR%\buttons_strip.png" (
        echo    [WARNING] buttons_strip.png not found in skin directory
    )
    if not exist "%SKIN_DIR%\cone_icon.png" (
        echo    [WARNING] cone_icon.png not found in skin directory
    )
)

echo.

REM ============================================================================
REM CACHE DIRECTORY SETUP
REM ============================================================================

echo [3/6] Setting up cache directory...
echo.

if not exist "%CACHE_DIR%" (
    echo    [INFO] Creating cache directory: %CACHE_DIR%
    mkdir "%CACHE_DIR%" 2>nul
    if !ERRORLEVEL! EQU 0 (
        echo    [OK] Cache directory created
    ) else (
        echo    [WARNING] Failed to create cache directory
    )
) else (
    echo    [OK] Cache directory exists: %CACHE_DIR%
)

echo.

REM ============================================================================
REM ENVIRONMENT SETUP
REM ============================================================================

echo [4/6] Configuring environment...
echo.

REM Set VLC data path
set VLC_DATA_PATH=%VLC_ROOT%share
echo    [OK] VLC_DATA_PATH=%VLC_DATA_PATH%

REM Set VLC plugin path (if custom build)
if exist "%VLC_ROOT%plugins" (
    set VLC_PLUGIN_PATH=%VLC_ROOT%plugins
    echo    [OK] VLC_PLUGIN_PATH=%VLC_PLUGIN_PATH%
) else (
    echo    [INFO] No custom plugins directory found
)

echo.

REM ============================================================================
REM BUILD LAUNCH COMMAND
REM ============================================================================

echo [5/6] Building launch command...
echo.

REM Base command
set VLC_CMD="!VLC_EXE!"

REM Data path
set VLC_CMD=!VLC_CMD! --data-path "%VLC_DATA_PATH%"

REM Interface configuration
set VLC_CMD=!VLC_CMD! --intf skins2
set VLC_CMD=!VLC_CMD! --skins2-last "%SKIN_DIR%\theme.xml"

REM Window configuration
set VLC_CMD=!VLC_CMD! --no-qt-name-in-title
set VLC_CMD=!VLC_CMD! --title "Spectre Media Player"

REM Extension auto-loader
set VLC_CMD=!VLC_CMD! --extraintf luaintf
set VLC_CMD=!VLC_CMD! --lua-intf spectre_loader

REM Logging configuration
set VLC_CMD=!VLC_CMD! --extraintf logger
set VLC_CMD=!VLC_CMD! --verbose 2
set VLC_CMD=!VLC_CMD! --file-logging
set VLC_CMD=!VLC_CMD! --logfile "%LOG_FILE%"

REM Debug mode additions
if %DEBUG_MODE% EQU 1 (
    echo    [DEBUG] Debug mode enabled
    set VLC_CMD=!VLC_CMD! --console
    set VLC_CMD=!VLC_CMD! --extraintf rc
)

echo    [OK] Launch command configured

echo.

REM ============================================================================
REM DISPLAY CONFIGURATION
REM ============================================================================

echo [6/6] Launch configuration:
echo.
echo    VLC Executable : !VLC_EXE!
echo    Skin Theme     : %SKIN_DIR%\theme.xml
echo    Extension      : spectre_loader (auto-load)
echo    Cache Directory: %CACHE_DIR%
echo    Log File       : %LOG_FILE%
echo    Debug Mode     : %DEBUG_MODE%
echo.

REM ============================================================================
REM LAUNCH VLC
REM ============================================================================

echo ========================================================================
echo                         LAUNCHING SPECTRE VLC
echo ========================================================================
echo.
echo Starting VLC with Spectre configuration...
echo.
echo TIP: Check the log file for extension activity:
echo      %LOG_FILE%
echo.
echo WARNING: Horror events will trigger randomly during playback!
echo          - Scary images may appear
echo          - Scary sounds may play
echo          - Events occur every 30 seconds (5%% chance)
echo.

REM Display full command in debug mode
if %DEBUG_MODE% EQU 1 (
    echo [DEBUG] Full command:
    echo !VLC_CMD!
    echo.
)

REM Launch VLC
if %DEBUG_MODE% EQU 1 (
    REM Debug mode: Keep console open
    echo Press any key to launch VLC in debug mode...
    pause >nul
    echo.
    echo Launching VLC...
    echo.
    !VLC_CMD!
    echo.
    echo VLC has exited.
    echo.
    goto :end_with_pause
) else (
    REM Normal mode: Launch and exit
    start "Spectre Media Player" !VLC_CMD!
    
    REM Wait a moment to check if VLC started
    timeout /t 2 /nobreak >nul
    
    echo.
    echo [OK] VLC launched successfully!
    echo.
    echo The Spectre extension is now active.
    echo Check the log file for details: %LOG_FILE%
    echo.
    goto :end
)

REM ============================================================================
REM ERROR HANDLING
REM ============================================================================

:error
echo.
echo ========================================================================
echo                              ERROR
echo ========================================================================
echo.
echo The launcher encountered errors and cannot continue.
echo Please review the messages above and fix the issues.
echo.
goto :end_with_pause

REM ============================================================================
REM EXIT
REM ============================================================================

:end_with_pause
echo Press any key to exit...
pause >nul
goto :end

:end
echo ========================================================================
echo                         LAUNCHER COMPLETE
echo ========================================================================
echo.
endlocal
exit /b 0
