#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2026 Naftali <https://github.com/Naftaliro>
#
# This script is provided "as is", without warranty of any kind. Use at your own risk.
# It is not affiliated with any of the upstream theme authors.
# For full details, see the repository's DISCLAIMER.md and LICENSE files.
# ORIGINALITY NOTICE: This script is an original automation wrapper written from
# scratch. It does not contain any code copied or adapted from the upstream theme
# repositories. It merely invokes the upstream projects' own install scripts.
#
# ------------------------------------------------------------------------------
# Catppuccin Mocha (Soothing Pastel Dark) Full System Theme Installer
# for ZorinOS 18 Pro / Ubuntu (GNOME)
# ------------------------------------------------------------------------------
# Installs: GTK theme (Mocha dark, purple/mauve accent), GNOME Shell theme,
#           Catppuccin-Mocha icons, Catppuccin-Mocha-Mauve cursors, libadwaita
#           override, and Flatpak theming. A warm, soothing pastel dark theme
#           beloved by the developer community.
#
# Theme suite:
#   - Catppuccin GTK Theme:  https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme (GPL-3.0)
#   - Catppuccin Cursors:    https://github.com/catppuccin/cursors                    (GPL-2.0)
# ------------------------------------------------------------------------------

set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; BOLD='\033[1m'; NC='\033[0m'
info()  { echo -e "${CYAN}[INFO]${NC}  $*"; }
ok()    { echo -e "${GREEN}[OK]${NC}    $*"; }
warn()  { echo -e "${YELLOW}[WARN]${NC}  $*"; }
header(){ echo -e "\n${BOLD}===================================================================${NC}"; echo -e "${BOLD}  $*${NC}"; echo -e "${BOLD}===================================================================${NC}\n"; }

# --- Configuration --------------------------------------------------------------
ACCENT="purple"          # Options: default purple pink red orange yellow green teal grey
COLOR="dark"             # Options: light dark
FLAVOR_TWEAK="macchiato" # Options: frappe macchiato (leave empty for Mocha default)
EXTRA_TWEAKS="black"     # Options: black float outline macos (space-separated, can combine)
LIBADWAITA="yes"
FLATPAK_THEME="yes"
CURSOR_FLAVOR="mocha"    # Options: latte frappe macchiato mocha
CURSOR_ACCENT="mauve"    # Options: blue dark flamingo green lavender maroon mauve peach pink red rosewater sapphire sky teal yellow

WORK_DIR="${HOME}/.catppuccin-install-tmp"
mkdir -p "${WORK_DIR}"
cleanup() { info "Cleaning up..."; rm -rf "${WORK_DIR}"; ok "Done."; }
trap cleanup EXIT

# ================================================================================
header "STEP 1/7: Installing System Dependencies"
# ================================================================================
info "Updating package lists and installing required packages..."
sudo apt update -y
sudo apt install -y \
    git sassc libglib2.0-dev-bin libxml2-utils \
    gnome-tweaks gnome-shell-extensions \
    gtk2-engines-murrine gnome-themes-extra \
    dconf-cli unzip wget
ok "All dependencies installed."

# ================================================================================
header "STEP 2/7: Cloning Catppuccin GTK Theme Repository"
# ================================================================================
cd "${WORK_DIR}"
info "Cloning Catppuccin GTK Theme (this is a large repo, please wait)..."
git clone https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme.git --depth=1
ok "Repository cloned."

# ================================================================================
header "STEP 3/7: Installing Catppuccin GTK + GNOME Shell Theme"
# ================================================================================
cd "${WORK_DIR}/Catppuccin-GTK-Theme/themes"
INSTALL_ARGS=(-c "${COLOR}" -t "${ACCENT}")
ALL_TWEAKS=""
[[ -n "${FLAVOR_TWEAK}" ]] && ALL_TWEAKS="${FLAVOR_TWEAK}"
[[ -n "${EXTRA_TWEAKS}" ]] && ALL_TWEAKS="${ALL_TWEAKS} ${EXTRA_TWEAKS}"
ALL_TWEAKS=$(echo "${ALL_TWEAKS}" | xargs)
[[ -n "${ALL_TWEAKS}" ]] && INSTALL_ARGS+=(--tweaks ${ALL_TWEAKS})
info "Running: ./install.sh ${INSTALL_ARGS[*]}"
./install.sh "${INSTALL_ARGS[@]}"
if [[ "${LIBADWAITA}" == "yes" ]]; then
    info "Installing libadwaita (gtk4) theme override..."
    ./install.sh -l -c "${COLOR}" -t "${ACCENT}"
fi
ok "GTK + GNOME Shell theme installed."

# ================================================================================
header "STEP 4/7: Installing Catppuccin Icons"
# ================================================================================
cd "${WORK_DIR}/Catppuccin-GTK-Theme"
ICON_DEST="${HOME}/.local/share/icons"
mkdir -p "${ICON_DEST}"
info "Installing Catppuccin-Mocha icons..."
cp -r icons/Catppuccin-Mocha "${ICON_DEST}/"
ok "Icons installed to ${ICON_DEST}/Catppuccin-Mocha."

# ================================================================================
header "STEP 5/7: Downloading and Installing Catppuccin Cursors"
# ================================================================================
cd "${WORK_DIR}"
CURSOR_ZIP="catppuccin-${CURSOR_FLAVOR}-${CURSOR_ACCENT}-cursors.zip"
CURSOR_URL="https://github.com/catppuccin/cursors/releases/download/v2.0.0/${CURSOR_ZIP}"
info "Downloading Catppuccin cursors (${CURSOR_FLAVOR}-${CURSOR_ACCENT})..."
wget -q "${CURSOR_URL}" -O "${CURSOR_ZIP}"
info "Extracting cursors..."
unzip -qo "${CURSOR_ZIP}" -d "${HOME}/.local/share/icons/"
ok "Cursors installed."

# ================================================================================
header "STEP 6/7: Determining Theme Names"
# ================================================================================
# Catppuccin theme naming: Catppuccin-<Accent>-<Color>[-<Flavor>][-<Tweaks>]
# The install script creates names like: Catppuccin-purple-Dark-Macchiato
COLOR_PART=""; case "${COLOR}" in light) COLOR_PART="-Light";; dark) COLOR_PART="-Dark";; esac
ACCENT_PART="${ACCENT}"; [[ "${ACCENT}" == "default" ]] && ACCENT_PART=""
FLAVOR_PART=""
case "${FLAVOR_TWEAK}" in
    frappe)     FLAVOR_PART="-Frappe";;
    macchiato)  FLAVOR_PART="-Macchiato";;
esac
if [[ -n "${ACCENT_PART}" ]]; then
    GTK_THEME="Catppuccin-${ACCENT_PART}${COLOR_PART}${FLAVOR_PART}"
else
    GTK_THEME="Catppuccin${COLOR_PART}${FLAVOR_PART}"
fi
ICON_THEME="Catppuccin-Mocha"
CURSOR_THEME="catppuccin-${CURSOR_FLAVOR}-${CURSOR_ACCENT}-cursors"
info "Resolved GTK theme name: ${GTK_THEME}"

# ================================================================================
header "STEP 7/7: Applying Theme via gsettings"
# ================================================================================
if [[ "${FLATPAK_THEME}" == "yes" ]]; then
    info "Connecting theme to Flatpak apps..."
    sudo flatpak override --filesystem=xdg-config/gtk-3.0 2>/dev/null || true
    sudo flatpak override --filesystem=xdg-config/gtk-4.0 2>/dev/null || true
fi

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
ok "All gsettings applied."

header "INSTALLATION COMPLETE!"
echo -e "${GREEN}${BOLD}"
cat << 'EOF'
   ╔══════════════════════════════════════════════════════════╗
   ║   Catppuccin Mocha (Pastel Dark) - Fully Installed!     ║
   ╠══════════════════════════════════════════════════════════╣
   ║  GTK Theme:    Catppuccin-purple-Dark-Macchiato         ║
   ║  Shell Theme:  Catppuccin-purple-Dark-Macchiato         ║
   ║  Icon Theme:   Catppuccin-Mocha                         ║
   ║  Cursors:      catppuccin-mocha-mauve-cursors           ║
   ║  Libadwaita:   Overridden with Catppuccin dark theme    ║
   ║  Flavor:       Macchiato (warm, soothing tones)         ║
   ╠══════════════════════════════════════════════════════════╣
   ║                                                          ║
   ║  Please log out and log back in to see all changes.     ║
   ║                                                          ║
   ╚══════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"
echo -e "${YELLOW}Log out and log back in to see all changes!${NC}"
