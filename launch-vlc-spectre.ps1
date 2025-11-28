# VLC Spectre Launcher - PowerShell Script
# Launches VLC with Spectre skin and auto-loads the horror extension

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "VLC Spectre Launcher" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Set paths
$VLC_SOURCE = Join-Path $PSScriptRoot "vlc-3.0.21"
$SKIN_PATH = Join-Path $VLC_SOURCE "share\skins2\default\theme.xml"

Write-Host "Checking for VLC installation..." -ForegroundColor Yellow
Write-Host ""

# Try to find VLC in common installation paths
$VLC_PATH = $null

$possiblePaths = @(
    "C:\Program Files\VideoLAN\VLC\vlc.exe",
    "C:\Program Files (x86)\VideoLAN\VLC\vlc.exe",
    "$env:LOCALAPPDATA\Programs\VLC\vlc.exe"
)

foreach ($path in $possiblePaths) {
    if (Test-Path $path) {
        $VLC_PATH = $path
        break
    }
}

# Check if vlc is in PATH
if (-not $VLC_PATH) {
    try {
        $vlcCommand = Get-Command vlc.exe -ErrorAction Stop
        $VLC_PATH = $vlcCommand.Source
    } catch {
        # VLC not found
    }
}

if (-not $VLC_PATH) {
    Write-Host "ERROR: VLC not found!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please install VLC Media Player or add it to your PATH" -ForegroundColor Yellow
    Write-Host "Download from: https://www.videolan.org/vlc/" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "Found VLC at: $VLC_PATH" -ForegroundColor Green
Write-Host ""
Write-Host "Launching VLC with Spectre configuration..." -ForegroundColor Yellow
Write-Host "- Skin: Spectre (custom horror theme)" -ForegroundColor White
Write-Host "- Extension: Auto-loading horror events" -ForegroundColor White
Write-Host ""

# Build command line arguments
$arguments = @(
    "--intf", "skins2",
    "--skins2-last", "`"$SKIN_PATH`"",
    "--extraintf", "luaintf",
    "--lua-intf", "spectre_loader",
    "--verbose", "2"
)

Write-Host "Command line:" -ForegroundColor Cyan
Write-Host "$VLC_PATH $($arguments -join ' ')" -ForegroundColor Gray
Write-Host ""

# Launch VLC
try {
    & $VLC_PATH $arguments
    Write-Host ""
    Write-Host "VLC has been closed" -ForegroundColor Yellow
} catch {
    Write-Host "ERROR: Failed to launch VLC" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
}

Write-Host ""
Read-Host "Press Enter to exit"
