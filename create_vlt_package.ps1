# Create Spectre VLT Package with all new assets

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Creating Spectre VLT Package" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Clean up old package
if (Test-Path "spectre_skin") {
    Remove-Item "spectre_skin" -Recurse -Force
}
if (Test-Path "spectre.vlt") {
    Remove-Item "spectre.vlt" -Force
}

# Create package directory
Write-Host "Creating package directory..." -ForegroundColor Yellow
New-Item -ItemType Directory -Path "spectre_skin" -Force | Out-Null

# Copy theme.xml
Write-Host "Copying theme.xml..." -ForegroundColor Yellow
Copy-Item "vlc-3.0.21\share\skins2\default\theme.xml" -Destination "spectre_skin\theme.xml" -Force

# Copy all assets
Write-Host "Copying assets..." -ForegroundColor Yellow
$assets = @("main_bg.png", "buttons_strip.png", "buttons_hover.png", "slider_bg.png", "cone_icon.png")
foreach ($asset in $assets) {
    Copy-Item "assets\$asset" -Destination "spectre_skin\$asset" -Force
    Write-Host "  - $asset" -ForegroundColor Gray
}

# List package contents
Write-Host ""
Write-Host "Package contents:" -ForegroundColor Yellow
Get-ChildItem "spectre_skin" | ForEach-Object { 
    $size = [math]::Round($_.Length / 1KB, 2)
    Write-Host "  - $($_.Name) ($size KB)" -ForegroundColor Gray 
}

# Create VLT (ZIP) package
Write-Host ""
Write-Host "Creating spectre.vlt..." -ForegroundColor Yellow
Compress-Archive -Path "spectre_skin\*" -DestinationPath "spectre.zip" -Force
Move-Item "spectre.zip" "spectre.vlt" -Force

$vltSize = [math]::Round((Get-Item "spectre.vlt").Length / 1KB, 2)
Write-Host "  OK - spectre.vlt created ($vltSize KB)" -ForegroundColor Green

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Package created successfully!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "To install:" -ForegroundColor Yellow
Write-Host "1. Double-click spectre.vlt" -ForegroundColor White
Write-Host "2. Or copy to VLC and use Tools -> Preferences -> Interface" -ForegroundColor White
Write-Host ""
