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
# Orchis (Material Design) Full System Theme Installer
# for ZorinOS 18 Pro / Ubuntu (GNOME)
# ------------------------------------------------------------------------------
# Installs: GTK theme (dark, purple accent), GNOME Shell theme, Tela icons
#           (purple), Graphite cursors (dark), libadwaita override, and Flatpak
#           theming. A polished Material Design look for your GNOME desktop.
#
# Theme suite by vinceliuice:
#   - Orchis GTK Theme:    https://github.com/vinceliuice/Orchis-theme       (GPL-3.0)
#   - Tela Icon Theme:     https://github.com/vinceliuice/Tela-icon-theme    (GPL-3.0)
#   - Graphite Cursors:    https://github.com/vinceliuice/Graphite-cursors   (GPL-3.0)
# ------------------------------------------------------------------------------

set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; BOLD='\033[1m'; NC='\033[0m'
info()  { echo -e "${CYAN}[INFO]${NC}  $*"; }
ok()    { echo -e "${GREEN}[OK]${NC}    $*"; }
warn()  { echo -e "${YELLOW}[WARN]${NC}  $*"; }
header(){ echo -e "\n${BOLD}===================================================================${NC}"; echo -e "${BOLD}  $*${NC}"; echo -e "${BOLD}===================================================================${NC}\n"; }

# --- Configuration --------------------------------------------------------------
ACCENT="purple"          # Options: default purple pink red orange yellow green teal grey
COLOR="dark"             # Options: standard light dark
SIZE="standard"          # Options: standard compact
SHELL_ICON="zorin"       # Options: default apple simple gnome ubuntu zorin arch manjaro fedora debian tux nixos
TWEAKS="black primary dock" # Options: solid compact black primary macos submenu nord dracula dock
LIBADWAITA="yes"
FLATPAK_THEME="yes"
ICON_COLOR="purple"      # Options: standard black blue brown green grey orange pink purple red yellow dracula nord
CURSOR_VARIANT="dark"    # Options: light dark

WORK_DIR="${HOME}/.orchis-install-tmp"
mkdir -p "${WORK_DIR}"
cleanup() { info "Cleaning up..."; rm -rf "${WORK_DIR}"; ok "Done."; }
trap cleanup EXIT

# ================================================================================
header "STEP 1/6: Installing System Dependencies"
# ================================================================================
info "Updating package lists and installing required packages..."
sudo apt update -y
sudo apt install -y \
    git sassc libglib2.0-dev-bin libxml2-utils \
    gnome-tweaks gnome-shell-extensions \
    gtk2-engines-murrine gnome-themes-extra \
    dconf-cli
ok "All dependencies installed."

# ================================================================================
header "STEP 2/6: Cloning Repositories"
# ================================================================================
cd "${WORK_DIR}"
info "Cloning Orchis GTK Theme..."
git clone https://github.com/vinceliuice/Orchis-theme.git --depth=1 --branch 2025-04-25
info "Cloning Tela Icon Theme..."
git clone https://github.com/vinceliuice/Tela-icon-theme.git --depth=1 --branch 2025-02-10
info "Cloning Graphite Cursors..."
git clone https://github.com/vinceliuice/Graphite-cursors.git --depth=1 --branch 2021-11-26
ok "All repositories cloned."

# ================================================================================
header "STEP 3/6: Installing Orchis GTK + GNOME Shell Theme"
# ================================================================================
cd "${WORK_DIR}/Orchis-theme"
INSTALL_ARGS=(-c "${COLOR}" -t "${ACCENT}" -s "${SIZE}" -i "${SHELL_ICON}")
[[ -n "${TWEAKS}" ]] && INSTALL_ARGS+=(--tweaks ${TWEAKS})
info "Running: ./install.sh ${INSTALL_ARGS[*]}"
./install.sh "${INSTALL_ARGS[@]}"
if [[ "${LIBADWAITA}" == "yes" ]]; then
    info "Installing libadwaita (gtk4) theme override..."
    ./install.sh -l -c "${COLOR}" -t "${ACCENT}"
fi
ok "GTK + GNOME Shell theme installed."

# ================================================================================
header "STEP 4/6: Installing Tela Icons"
# ================================================================================
cd "${WORK_DIR}/Tela-icon-theme"
info "Installing Tela icons (${ICON_COLOR} variant)..."
./install.sh "${ICON_COLOR}"
ok "Icons installed."

# ================================================================================
header "STEP 5/6: Installing Graphite Cursors"
# ================================================================================
cd "${WORK_DIR}/Graphite-cursors"
info "Installing Graphite cursors..."
DEST_DIR="${HOME}/.local/share/icons"
mkdir -p "${DEST_DIR}"
cp -r dist-dark "${DEST_DIR}/Graphite-dark-cursors"
cp -r dist-light "${DEST_DIR}/Graphite-light-cursors"
ok "Cursors installed."

# ================================================================================
header "STEP 6/6: Applying Theme via gsettings"
# ================================================================================
if [[ "${FLATPAK_THEME}" == "yes" ]]; then
    info "Connecting theme to Flatpak apps..."
    sudo flatpak override --filesystem=xdg-config/gtk-3.0 2>/dev/null || true
    sudo flatpak override --filesystem=xdg-config/gtk-4.0 2>/dev/null || true
fi

ACCENT_PART="${ACCENT}"; [[ "${ACCENT}" == "default" ]] && ACCENT_PART=""
COLOR_PART=""; case "${COLOR}" in light) COLOR_PART="-Light";; dark) COLOR_PART="-Dark";; esac
if [[ -n "${ACCENT_PART}" ]]; then GTK_THEME="Orchis-${ACCENT_PART}${COLOR_PART}"; else GTK_THEME="Orchis${COLOR_PART}"; fi
ICON_THEME="Tela-${ICON_COLOR}-dark"
CURSOR_THEME="Graphite-${CURSOR_VARIANT}-cursors"

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
   ║     Orchis (Material Design) Theme - Fully Installed!   ║
   ╠══════════════════════════════════════════════════════════╣
   ║  GTK Theme:    Orchis-purple-Dark                       ║
   ║  Shell Theme:  Orchis-purple-Dark                       ║
   ║  Icon Theme:   Tela-purple-dark                         ║
   ║  Cursors:      Graphite-dark-cursors                    ║
   ║  Libadwaita:   Overridden with dark purple theme        ║
   ║  Tweaks:       Black + Primary color radio buttons      ║
   ╠══════════════════════════════════════════════════════════╣
   ║                                                          ║
   ║  Please log out and log back in to see all changes.     ║
   ║                                                          ║
   ╚══════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"
echo -e "${YELLOW}Log out and log back in to see all changes!${NC}"
