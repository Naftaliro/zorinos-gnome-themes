#!/usr/bin/env bash
#
# This script is provided "as is", without warranty of any kind. Use at your own risk.
# It is not affiliated with any of the upstream theme authors.
# For full details, see the repository's DISCLAIMER.md and LICENSE files.
#
# ------------------------------------------------------------------------------
# WhiteSur macOS Full System Theme Installer for ZorinOS 18 Pro / Ubuntu (GNOME)
# ------------------------------------------------------------------------------
# Installs: GTK theme (dark, purple accent), GNOME Shell theme, GDM login theme,
#           macOS icons (purple), macOS cursors, macOS wallpapers, libadwaita
#           override, Firefox theme, and Flatpak theming.
#
# Designed for: ZorinOS 18 Pro (Ubuntu 24.04 base) with GNOME desktop
# ------------------------------------------------------------------------------

set -euo pipefail

# --- Color helpers --------------------------------------------------------------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'
info()  { echo -e "${CYAN}[INFO]${NC}  $*"; }
ok()    { echo -e "${GREEN}[OK]${NC}    $*"; }
warn()  { echo -e "${YELLOW}[WARN]${NC}  $*"; }
err()   { echo -e "${RED}[ERROR]${NC} $*"; }
header(){ echo -e "\n${BOLD}===================================================================${NC}"; echo -e "${BOLD}  $*${NC}"; echo -e "${BOLD}===================================================================${NC}\n"; }

# --- Configuration (edit these to customize) ------------------------------------
ACCENT="purple"          # Options: default blue purple pink red orange yellow green grey
COLOR="dark"             # Options: light dark
OPACITY="normal"         # Options: normal solid
NAUTILUS_STYLE="stable"  # Options: stable normal mojave glassy right
ACTIVITIES_ICON="zorin"  # Options: apple simple gnome ubuntu tux arch manjaro fedora debian zorin ...
PANEL_OPACITY="default"  # Options: default 30 45 60 75
WALLPAPER_RES="2k"       # Options: 1080p 2k 4k  (Framework 13 = 2256x1504, so 2k is ideal)
ROUNDED_WINDOWS="yes"    # Set maximized windows to rounded corners
LIBADWAITA="yes"         # Override libadwaita (gtk4) apps with theme
FIREFOX_THEME="yes"      # Install Firefox theme
FLATPAK_THEME="yes"      # Connect theme to Flatpak apps
GDM_THEME="yes"          # Install GDM (login screen) theme
INSTALL_WALLPAPERS="yes" # Install macOS-style wallpapers
INSTALL_GNOME_BG="yes"   # Install time-based GNOME backgrounds

# --- Workspace ------------------------------------------------------------------
WORK_DIR="${HOME}/.whitesur-install-tmp"
mkdir -p "${WORK_DIR}"

cleanup() {
    info "Cleaning up temporary files..."
    rm -rf "${WORK_DIR}"
    ok "Cleanup complete."
}
trap cleanup EXIT

# ================================================================================
header "STEP 1/8: Installing System Dependencies"
# ================================================================================

info "Updating package lists and installing required packages..."
sudo apt update -y
sudo apt install -y \
    git sassc libglib2.0-dev-bin libxml2-utils \
    imagemagick dialog optipng inkscape \
    gnome-tweaks gnome-shell-extensions \
    gtk2-engines-murrine gnome-themes-extra \
    dconf-cli

ok "All dependencies installed."

# ================================================================================
header "STEP 2/8: Cloning All WhiteSur Repositories"
# ================================================================================

cd "${WORK_DIR}"

info "Cloning WhiteSur GTK Theme..."
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1

info "Cloning WhiteSur Icon Theme..."
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git --depth=1

info "Cloning WhiteSur Cursors..."
git clone https://github.com/vinceliuice/WhiteSur-cursors.git --depth=1

info "Cloning WhiteSur Wallpapers..."
git clone https://github.com/vinceliuice/WhiteSur-wallpapers.git --depth=1

ok "All repositories cloned."

# ================================================================================
header "STEP 3/8: Installing WhiteSur GTK + GNOME Shell Theme"
# ================================================================================

cd "${WORK_DIR}/WhiteSur-gtk-theme"

INSTALL_ARGS=(
    -c "${COLOR}"
    -t "${ACCENT}"
    -o "${OPACITY}"
    -N "${NAUTILUS_STYLE}"
    --shell -i "${ACTIVITIES_ICON}" -p "${PANEL_OPACITY}"
)

# Add rounded maximized windows if requested
if [[ "${ROUNDED_WINDOWS}" == "yes" ]]; then
    INSTALL_ARGS+=(--round)
fi

info "Running: ./install.sh ${INSTALL_ARGS[*]}"
./install.sh "${INSTALL_ARGS[@]}"

# Install libadwaita override (gtk4 apps)
if [[ "${LIBADWAITA}" == "yes" ]]; then
    info "Installing libadwaita (gtk4) theme override..."
    ./install.sh -l -c "${COLOR}" -t "${ACCENT}"
fi

ok "GTK + GNOME Shell theme installed."

# ================================================================================
header "STEP 4/8: Installing WhiteSur Icon Theme"
# ================================================================================

cd "${WORK_DIR}/WhiteSur-icon-theme"

info "Installing WhiteSur icons with ${ACCENT} accent..."
./install.sh -t "${ACCENT}" -a -b

ok "Icon theme installed."

# ================================================================================
header "STEP 5/8: Installing WhiteSur Cursors"
# ================================================================================

cd "${WORK_DIR}/WhiteSur-cursors"

info "Installing WhiteSur cursor theme..."
./install.sh

ok "Cursor theme installed."

# ================================================================================
header "STEP 6/8: Installing WhiteSur Wallpapers"
# ================================================================================

cd "${WORK_DIR}/WhiteSur-wallpapers"

if [[ "${INSTALL_WALLPAPERS}" == "yes" ]]; then
    info "Installing WhiteSur wallpapers (${WALLPAPER_RES}, dark)..."
    ./install-wallpapers.sh -t whitesur -c dark -s "${WALLPAPER_RES}"
fi

if [[ "${INSTALL_GNOME_BG}" == "yes" ]]; then
    info "Installing time-based GNOME backgrounds..."
    sudo ./install-gnome-backgrounds.sh -t whitesur -s "${WALLPAPER_RES}"
fi

ok "Wallpapers installed."

# ================================================================================
header "STEP 7/8: Applying Tweaks (GDM, Firefox, Flatpak)"
# ================================================================================

cd "${WORK_DIR}/WhiteSur-gtk-theme"

# GDM (login screen) theme
if [[ "${GDM_THEME}" == "yes" ]]; then
    info "Installing GDM login screen theme (requires sudo)..."
    sudo ./tweaks.sh -g -c "${COLOR}" -t "${ACCENT}"
    ok "GDM theme installed."
fi

# Firefox theme
if [[ "${FIREFOX_THEME}" == "yes" ]]; then
    info "Installing Firefox theme..."
    ./tweaks.sh -f
    ok "Firefox theme installed."
fi

# Flatpak theme connection
if [[ "${FLATPAK_THEME}" == "yes" ]]; then
    info "Connecting theme to Flatpak apps..."
    sudo flatpak override --filesystem=xdg-config/gtk-3.0 2>/dev/null || true
    sudo flatpak override --filesystem=xdg-config/gtk-4.0 2>/dev/null || true
    ./tweaks.sh -F -c "${COLOR}" -t "${ACCENT}" 2>/dev/null || warn "Flatpak tweaks skipped (Flatpak may not be installed)."
    ok "Flatpak theme connected."
fi

# Dash to Dock fix
info "Applying Dash to Dock fix..."
./tweaks.sh -d 2>/dev/null || warn "Dash to Dock fix skipped (extension may not be installed)."

# ================================================================================
header "STEP 8/8: Applying Theme via gsettings"
# ================================================================================

# Determine the exact theme directory names
# GTK theme: WhiteSur-Dark-purple (color=Dark, accent=purple, opacity=normal -> no suffix)
GTK_THEME="WhiteSur-Dark-${ACCENT}"
if [[ "${ACCENT}" == "default" ]]; then
    GTK_THEME="WhiteSur-Dark"
fi

# Icon theme: WhiteSur-purple-dark
ICON_THEME="WhiteSur-${ACCENT}-dark"
if [[ "${ACCENT}" == "default" ]]; then
    ICON_THEME="WhiteSur-dark"
fi

# Cursor theme
CURSOR_THEME="WhiteSur-cursors"

info "Setting GTK theme to: ${GTK_THEME}"
gsettings set org.gnome.desktop.interface gtk-theme "${GTK_THEME}"

info "Setting GNOME Shell theme to: ${GTK_THEME}"
gsettings set org.gnome.shell.extensions.user-theme name "${GTK_THEME}" 2>/dev/null || warn "User Themes extension may not be enabled yet."

info "Setting Window Manager theme to: ${GTK_THEME}"
gsettings set org.gnome.desktop.wm.preferences theme "${GTK_THEME}"

info "Setting icon theme to: ${ICON_THEME}"
gsettings set org.gnome.desktop.interface icon-theme "${ICON_THEME}"

info "Setting cursor theme to: ${CURSOR_THEME}"
gsettings set org.gnome.desktop.interface cursor-theme "${CURSOR_THEME}"

info "Setting color scheme to prefer-dark..."
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# Set wallpaper if installed
if [[ "${INSTALL_WALLPAPERS}" == "yes" ]]; then
    WALLPAPER_PATH=""
    # Check common wallpaper locations
    for dir in "/usr/share/backgrounds" "${HOME}/.local/share/backgrounds"; do
        found=$(find "${dir}" -iname "*whitesur*dark*" -type f 2>/dev/null | head -1)
        if [[ -n "${found}" ]]; then
            WALLPAPER_PATH="${found}"
            break
        fi
    done
    if [[ -n "${WALLPAPER_PATH}" ]]; then
        info "Setting wallpaper to: ${WALLPAPER_PATH}"
        gsettings set org.gnome.desktop.background picture-uri "file://${WALLPAPER_PATH}"
        gsettings set org.gnome.desktop.background picture-uri-dark "file://${WALLPAPER_PATH}"
    fi
fi

ok "All gsettings applied."

# ================================================================================
header "INSTALLATION COMPLETE!"
# ================================================================================

echo -e "${GREEN}${BOLD}"
cat << 'EOF'
   ╔══════════════════════════════════════════════════════════╗
   ║          WhiteSur macOS Theme - Fully Installed!        ║
   ╠══════════════════════════════════════════════════════════╣
   ║  GTK Theme:    WhiteSur-Dark-purple                     ║
   ║  Shell Theme:  WhiteSur-Dark-purple                     ║
   ║  Icon Theme:   WhiteSur-purple-dark                     ║
   ║  Cursors:      WhiteSur-cursors                         ║
   ║  GDM Theme:    WhiteSur (dark, purple)                  ║
   ║  Wallpapers:   WhiteSur macOS-style (dark)              ║
   ║  Firefox:      WhiteSur theme applied                   ║
   ║  Libadwaita:   Overridden with dark purple theme        ║
   ╠══════════════════════════════════════════════════════════╣
   ║                                                          ║
   ║  IMPORTANT: Please log out and log back in (or reboot)  ║
   ║  to see the GDM login screen theme and all changes.     ║
   ║                                                          ║
   ║  RECOMMENDED GNOME EXTENSIONS:                          ║
   ║  • User Themes (required for shell theme)               ║
   ║  • Dash to Dock (macOS-style dock)                      ║
   ║  • Blur My Shell (frosted glass effects)                ║
   ║                                                          ║
   ╚══════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

echo -e "${CYAN}To uninstall everything later, run:${NC}"
echo "  cd ~/.whitesur-install-tmp/WhiteSur-gtk-theme  (if still present)"
echo "  ./install.sh -r                  # Remove GTK themes"
echo "  sudo ./tweaks.sh -g -r           # Remove GDM theme"
echo "  ./tweaks.sh -f -r                # Remove Firefox theme"

echo ""
echo -e "${YELLOW}Log out and log back in to see all changes!${NC}"
