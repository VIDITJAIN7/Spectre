#!/bin/bash
################################################################################
# VLC Spectre Custom Build Script
# Compiles VLC 3.0.21 with Spectre skin and horror extension
################################################################################

set -e  # Exit on error

echo "========================================"
echo "VLC Spectre Custom Build"
echo "========================================"
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Build directory
BUILD_DIR="/c/Users/vidit/Desktop/Projects/Kiro_Hackathon/vlc-3.0.21"
cd "$BUILD_DIR"

echo -e "${CYAN}[1/6] Checking dependencies...${NC}"
echo ""

# Check for required packages
REQUIRED_PACKAGES=(
    "mingw-w64-x86_64-gcc"
    "mingw-w64-x86_64-pkg-config"
    "mingw-w64-x86_64-lua"
    "autoconf"
    "automake"
    "libtool"
    "make"
)

MISSING_PACKAGES=()

for package in "${REQUIRED_PACKAGES[@]}"; do
    if ! pacman -Q "$package" &>/dev/null; then
        MISSING_PACKAGES+=("$package")
        echo -e "${RED}  Missing: $package${NC}"
    else
        echo -e "${GREEN}  OK: $package${NC}"
    fi
done

if [ ${#MISSING_PACKAGES[@]} -gt 0 ]; then
    echo ""
    echo -e "${YELLOW}Installing missing packages...${NC}"
    pacman -S --noconfirm "${MISSING_PACKAGES[@]}"
fi

echo ""
echo -e "${CYAN}[2/6] Verifying Spectre files...${NC}"
echo ""

# Check Spectre files
SPECTRE_FILES=(
    "share/skins2/default/theme.xml"
    "share/skins2/default/main_bg.png"
    "share/skins2/default/buttons_strip.png"
    "share/skins2/default/buttons_hover.png"
    "share/skins2/default/slider_bg.png"
    "share/skins2/default/cone_icon.png"
    "share/lua/extensions/spectre.lua"
    "share/lua/intf/spectre_loader.lua"
)

ALL_FILES_PRESENT=true

for file in "${SPECTRE_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo -e "${GREEN}  OK: $file${NC}"
    else
        echo -e "${RED}  MISSING: $file${NC}"
        ALL_FILES_PRESENT=false
    fi
done

if [ "$ALL_FILES_PRESENT" = false ]; then
    echo ""
    echo -e "${RED}ERROR: Some Spectre files are missing!${NC}"
    exit 1
fi

echo ""
echo -e "${CYAN}[3/6] Running bootstrap...${NC}"
echo ""

if [ ! -f "configure" ]; then
    echo "Running bootstrap to generate configure script..."
    ./bootstrap
else
    echo "Configure script already exists, skipping bootstrap"
fi

echo ""
echo -e "${CYAN}[4/6] Configuring build...${NC}"
echo ""

# Set build compiler
export BUILDCC=gcc

# Configure with minimal options for faster build
./configure \
    --enable-skins2 \
    --enable-lua \
    --disable-a52 \
    --disable-avcodec \
    --disable-avformat \
    --disable-swscale \
    --disable-postproc \
    --disable-mad \
    --disable-libmpeg2 \
    --disable-dca \
    --disable-libass \
    --disable-kate \
    --disable-tiger \
    --disable-dvdread \
    --disable-dvdnav \
    --disable-bluray \
    --disable-opencv \
    --disable-smbclient \
    --disable-sftp \
    --disable-nfs \
    --disable-v4l2 \
    --disable-decklink \
    --disable-vcd \
    --disable-libcddb \
    --disable-screen \
    --disable-vnc \
    --disable-freerdp \
    --disable-realrtsp \
    --disable-macosx \
    --disable-sparkle \
    --disable-ncurses \
    --disable-goom \
    --disable-projectm \
    --disable-vsxu

echo ""
echo -e "${CYAN}[5/6] Compiling VLC...${NC}"
echo ""
echo -e "${YELLOW}This will take 2-4 hours. Please be patient...${NC}"
echo ""

# Get number of CPU cores
CORES=$(nproc)
echo "Using $CORES CPU cores for compilation"
echo ""

# Compile
make -j$CORES

echo ""
echo -e "${CYAN}[6/6] Build complete!${NC}"
echo ""

# Check if vlc.exe was created
if [ -f "bin/vlc.exe" ] || [ -f "vlc.exe" ]; then
    echo -e "${GREEN}SUCCESS! VLC compiled successfully!${NC}"
    echo ""
    echo "VLC executable location:"
    if [ -f "bin/vlc.exe" ]; then
        echo "  $(pwd)/bin/vlc.exe"
    else
        echo "  $(pwd)/vlc.exe"
    fi
    echo ""
    echo "To run your custom VLC:"
    echo "  ./launch_spectre.bat"
    echo ""
else
    echo -e "${RED}ERROR: VLC executable not found after compilation${NC}"
    echo "Check the build log for errors"
    exit 1
fi

echo "========================================"
echo "Build Complete!"
echo "========================================"
