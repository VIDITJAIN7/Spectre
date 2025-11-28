# VLC Spectre - Project Verification Script
# Verifies all required files are present and properly organized

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "VLC Spectre - Project Verification" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$allGood = $true

# Check required files
Write-Host "Checking required files..." -ForegroundColor Yellow
Write-Host ""

$requiredFiles = @{
    "README.md" = "Main documentation"
    "LICENSE" = "License file"
    "CONTRIBUTING.md" = "Contribution guidelines"
    ".gitignore" = "Git ignore rules"
    "appsettings.json" = "API configuration"
    "launch-vlc-spectre.bat" = "Windows launcher"
    "launch-vlc-spectre.ps1" = "PowerShell launcher"
    "create_vlt_package.ps1" = "Skin packager"
    "spectre.vlt" = "Installable skin"
}

foreach ($file in $requiredFiles.Keys) {
    if (Test-Path $file) {
        Write-Host "  [OK] $file - $($requiredFiles[$file])" -ForegroundColor Green
    } else {
        Write-Host "  [MISSING] $file - $($requiredFiles[$file])" -ForegroundColor Red
        $allGood = $false
    }
}

# Check directories
Write-Host ""
Write-Host "Checking directories..." -ForegroundColor Yellow
Write-Host ""

$requiredDirs = @{
    "assets" = "Source image assets"
    "docs" = "Documentation"
    "vlc-3.0.21" = "VLC source code"
    "vlc-3.0.21\share\skins2\default" = "Skin files"
    "vlc-3.0.21\share\lua\extensions" = "Lua extensions"
    "vlc-3.0.21\share\lua\intf" = "Lua interfaces"
}

foreach ($dir in $requiredDirs.Keys) {
    if (Test-Path $dir) {
        $count = (Get-ChildItem $dir -File -ErrorAction SilentlyContinue).Count
        Write-Host "  [OK] $dir - $($requiredDirs[$dir]) ($count files)" -ForegroundColor Green
    } else {
        Write-Host "  [MISSING] $dir - $($requiredDirs[$dir])" -ForegroundColor Red
        $allGood = $false
    }
}

# Check assets
Write-Host ""
Write-Host "Checking assets..." -ForegroundColor Yellow
Write-Host ""

$requiredAssets = @(
    "main_bg.png",
    "buttons_strip.png",
    "buttons_hover.png",
    "slider_bg.png",
    "cone_icon.png"
)

foreach ($asset in $requiredAssets) {
    if (Test-Path "assets\$asset") {
        $size = [math]::Round((Get-Item "assets\$asset").Length / 1KB, 2)
        Write-Host "  [OK] $asset ($size KB)" -ForegroundColor Green
    } else {
        Write-Host "  [MISSING] $asset" -ForegroundColor Red
        $allGood = $false
    }
}

# Check documentation
Write-Host ""
Write-Host "Checking documentation..." -ForegroundColor Yellow
Write-Host ""

$requiredDocs = @(
    "SPECTRE_SETUP.md",
    "AUTO_LOAD_SOLUTION.md",
    "COMPILE_AND_RUN.md",
    "STATUS_SUMMARY.md"
)

foreach ($doc in $requiredDocs) {
    if (Test-Path "docs\$doc") {
        Write-Host "  [OK] $doc" -ForegroundColor Green
    } else {
        Write-Host "  [MISSING] $doc" -ForegroundColor Red
        $allGood = $false
    }
}

# Check VLC files
Write-Host ""
Write-Host "Checking VLC files..." -ForegroundColor Yellow
Write-Host ""

$vlcFiles = @{
    "vlc-3.0.21\share\skins2\default\theme.xml" = "Skin definition"
    "vlc-3.0.21\share\lua\extensions\spectre.lua" = "Horror extension"
    "vlc-3.0.21\share\lua\intf\spectre_loader.lua" = "Auto-loader"
}

foreach ($file in $vlcFiles.Keys) {
    if (Test-Path $file) {
        Write-Host "  [OK] $($vlcFiles[$file])" -ForegroundColor Green
    } else {
        Write-Host "  [MISSING] $($vlcFiles[$file])" -ForegroundColor Red
        $allGood = $false
    }
}

# Final result
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan

if ($allGood) {
    Write-Host "✅ ALL CHECKS PASSED!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Project is ready for GitHub upload!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host "1. git init" -ForegroundColor White
    Write-Host "2. git add ." -ForegroundColor White
    Write-Host "3. git commit -m 'Initial commit'" -ForegroundColor White
    Write-Host "4. Create GitHub repository" -ForegroundColor White
    Write-Host "5. git remote add origin <url>" -ForegroundColor White
    Write-Host "6. git push -u origin main" -ForegroundColor White
} else {
    Write-Host "❌ SOME CHECKS FAILED" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please fix the missing files/directories above." -ForegroundColor Yellow
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
