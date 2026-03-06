# Complete Windows 10 Style Theme Guide for GNOME

**Author:** Manus AI
**Date:** March 06, 2026
**Version:** 1.0

## 1. Introduction

This guide provides an automated method for installing the **We10X theme suite** by developer yeyushengfan258 [1]. It offers a faithful recreation of the Windows 10 user interface for the GNOME desktop, providing a distinct alternative to the Windows 11-style themes.

The process is managed by a single shell script that installs the complete suite, including the GTK theme, GNOME Shell theme, matching icons, and cursors. It provides a cohesive and polished Windows 10 look and feel for your ZorinOS 18 Pro or Ubuntu-based system.

## 2. What's Included

The installer script will configure the following components to match a Windows 10 aesthetic (dark mode with a purple accent, as requested):

| Component              | Description                                                                                             |
| ---------------------- | ------------------------------------------------------------------------------------------------------- |
| **GTK Theme**          | The main theme for application windows, with the characteristic sharp corners of Windows 10.            |
| **GNOME Shell Theme**  | Themes the top bar, activities overview, system menus, and notifications.                               |
| **Icon Theme**         | A full set of Windows 10 style icons for applications, folders, and system indicators.                  |
| **Cursor Theme**       | The Fluent Design mouse pointer (from vinceliuice's theme), which is visually consistent.               |
| **Libadwaita Override**| Applies the theme to modern GTK4 applications that use the `libadwaita` library.                        |
| **Flatpak Support**    | Connects the installed theme to Flatpak applications so they match the rest of the system.              |

## 3. Installation

This process involves running a single command in your terminal. The script will ask for your password to install necessary software packages and apply system-wide themes.

### Prerequisites

- A modern GNOME-based Linux distribution (e.g., ZorinOS 18, Ubuntu 22.04+, Fedora 38+).
- An active internet connection.
- `curl` and `bash` installed (these are standard on most systems).
- Administrative (`sudo`) privileges.

### One-Liner Installation Command

Open a terminal and paste the following command. This will download and execute the installation script automatically.

```bash
curl -fsSL https://raw.githubusercontent.com/Naftaliro/zorinos-gnome-themes/main/windows-themes/we10x-win10-theme-install.sh | bash
```

After running the command, the script will guide you through the process. Once finished, you **must log out and log back in** to see all the changes take full effect.

## 4. The Installation Script

For full transparency, the complete contents of the installation script are provided below.

```bash
#!/usr/bin/env bash
#
# We10X (Windows 10 Style) Full System Theme Installer
# for ZorinOS 18 Pro / Ubuntu (GNOME)
# ──────────────────────────────────────────────────────────────────────────────
# Installs: GTK theme (dark, purple accent), GNOME Shell theme, We10X icons
#           (purple), Fluent cursors (dark), libadwaita override, and Flatpak
#           theming. A faithful Windows 10 recreation for your Linux desktop.
#
# Theme suite by yeyushengfan258 (icons + GTK) and vinceliuice (cursors):
#   - We10X GTK Theme:   https://github.com/yeyushengfan258/We10X-gtk-theme
#   - We10X Icon Theme:  https://github.com/yeyushengfan258/We10X-icon-theme
#   - Fluent Cursors:    https://github.com/vinceliuice/Fluent-icon-theme
#
# Usage:
#   chmod +x we10x-win10-theme-install.sh && ./we10x-win10-theme-install.sh
#
# Author: Auto-generated guide
# License: MIT
# ──────────────────────────────────────────────────────────────────────────────

set -euo pipefail

# ── Color helpers ─────────────────────────────────────────────────────────────
RED=\'\033[0;31m\'; GREEN=\'\033[0;32m\'; YELLOW=\'\033[1;33m\'; CYAN=\'\033[0;36m\'; BOLD=\'\033[1m\'; NC=\'\033[0m\'
info()  { echo -e "${CYAN}[INFO]${NC}  $*"; }
ok()    { echo -e "${GREEN}[OK]${NC}    $*"; }
warn()  { echo -e "${YELLOW}[WARN]${NC}  $*"; }
err()   { echo -e "${RED}[ERROR]${NC} $*"; }
header(){ echo -e "\n${BOLD}═══════════════════════════════════════════════════════════${NC}"; echo -e "${BOLD}  $*${NC}"; echo -e "${BOLD}═══════════════════════════════════════════════════════════${NC}\n"; }

# ── Configuration (edit these to customize) ───────────────────────────────────
ACCENT="purple"          # GTK: default blue purple pink red orange yellow green teal grey
COLOR="dark"             # Options: standard light dark
SIZE="standard"          # Options: standard compact
SHELL_ICON="default"     # Options: default apple simple gnome ubuntu zorin arch manjaro fedora debian tux nixos
                         # "default" = Windows icon in the shell panel
TWEAKS="square noborder" # Options: solid float round blur noborder square
                         # "square" = square window buttons (classic Win10 look)
LIBADWAITA="yes"         # Override libadwaita (gtk4) apps with theme
FLATPAK_THEME="yes"      # Connect theme to Flatpak apps
ICON_ACCENT="purple"     # Icon: default black blue green orange purple red special
CURSOR_VARIANT="dark"    # Options: light dark

# ── Workspace ─────────────────────────────────────────────────────────────────
WORK_DIR="${HOME}/.we10x-install-tmp"
mkdir -p "${WORK_DIR}"

cleanup() {
    info "Cleaning up temporary files..."
    rm -rf "${WORK_DIR}"
    ok "Cleanup complete."
}
trap cleanup EXIT

# ══════════════════════════════════════════════════════════════════════════════
header "STEP 1/5: Installing System Dependencies"
# ══════════════════════════════════════════════════════════════════════════════

info "Updating package lists and installing required packages..."
sudo apt update -y
sudo apt install -y \
    git sassc libglib2.0-dev-bin libxml2-utils \
    gnome-tweaks gnome-shell-extensions \
    gtk2-engines-murrine gnome-themes-extra \
    dconf-cli

ok "All dependencies installed."

# ══════════════════════════════════════════════════════════════════════════════
header "STEP 2/5: Cloning Repositories"
# ══════════════════════════════════════════════════════════════════════════════

cd "${WORK_DIR}"

info "Cloning We10X GTK Theme..."
git clone https://github.com/yeyushengfan258/We10X-gtk-theme.git --depth=1

info "Cloning We10X Icon Theme..."
git clone https://github.com/yeyushengfan258/We10X-icon-theme.git --depth=1

info "Cloning Fluent Icon Theme (for cursors)..."
git clone https://github.com/vinceliuice/Fluent-icon-theme.git --depth=1

ok "All repositories cloned."

# ══════════════════════════════════════════════════════════════════════════════
header "STEP 3/5: Installing We10X GTK + GNOME Shell Theme"
# ══════════════════════════════════════════════════════════════════════════════

cd "${WORK_DIR}/We10X-gtk-theme"

INSTALL_ARGS=(
    -c "${COLOR}"
    -t "${ACCENT}"
    -s "${SIZE}"
    -i "${SHELL_ICON}"
)

if [[ -n "${TWEAKS}" ]]; then
    INSTALL_ARGS+=(--tweaks ${TWEAKS})
fi

info "Running: ./install.sh ${INSTALL_ARGS[*]}"
./install.sh "${INSTALL_ARGS[@]}"

# Install libadwaita override (gtk4 apps)
if [[ "${LIBADWAITA}" == "yes" ]]; then
    info "Installing libadwaita (gtk4) theme override..."
    ./install.sh -l -c "${COLOR}" -t "${ACCENT}"
fi

ok "GTK + GNOME Shell theme installed."

# ══════════════════════════════════════════════════════════════════════════════
header "STEP 4/5: Installing We10X Icons + Fluent Cursors"
# ══════════════════════════════════════════════════════════════════════════════

cd "${WORK_DIR}/We10X-icon-theme"

info "Installing We10X icons (${ICON_ACCENT} variant)..."
./install.sh -t "${ICON_ACCENT}" -a -b

cd "${WORK_DIR}/Fluent-icon-theme/cursors"

info "Installing Fluent cursor theme..."
./install.sh

ok "Icons and cursors installed."

# ══════════════════════════════════════════════════════════════════════════════
header "STEP 5/5: Applying Theme via gsettings"
# ══════════════════════════════════════════════════════════════════════════════

# Flatpak theme connection
if [[ "${FLATPAK_THEME}" == "yes" ]]; then
    info "Connecting theme to Flatpak apps..."
    sudo flatpak override --filesystem=xdg-config/gtk-3.0 2>/dev/null || true
    sudo flatpak override --filesystem=xdg-config/gtk-4.0 2>/dev/null || true
    ok "Flatpak theme overrides applied."
fi

# Determine exact theme names
ACCENT_PART="${ACCENT}"
[[ "${ACCENT}" == "default" ]] && ACCENT_PART=""

COLOR_PART=""
case "${COLOR}" in
    light)    COLOR_PART="-Light" ;;
    dark)     COLOR_PART="-Dark" ;;
    standard) COLOR_PART="" ;;
esac

if [[ -n "${ACCENT_PART}" ]]; then
    GTK_THEME="We10X-${ACCENT_PART}${COLOR_PART}"
else
    GTK_THEME="We10X${COLOR_PART}"
fi

# Icon theme: We10X-purple-dark
if [[ "${ICON_ACCENT}" == "default" ]]; then
    ICON_THEME="We10X-dark"
else
    ICON_THEME="We10X-${ICON_ACCENT}-dark"
fi

# Cursor theme
if [[ "${CURSOR_VARIANT}" == "dark" ]]; then
    CURSOR_THEME="Fluent-dark-cursors"
else
    CURSOR_THEME="Fluent-cursors"
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

# ══════════════════════════════════════════════════════════════════════════════
header "INSTALLATION COMPLETE!"
# ══════════════════════════════════════════════════════════════════════════════

echo -e "${GREEN}${BOLD}"
cat << \'EOF\'
   ╔══════════════════════════════════════════════════════════╗
   ║     We10X (Windows 10 Style) Theme - Fully Installed!   ║
   ╠══════════════════════════════════════════════════════════╣
   ║  GTK Theme:    We10X-purple-Dark                        ║
   ║  Shell Theme:  We10X-purple-Dark                        ║
   ║  Icon Theme:   We10X-purple-dark                        ║
   ║  Cursors:      Fluent-dark-cursors                      ║
   ║  Libadwaita:   Overridden with dark purple theme        ║
   ║  Tweaks:       Square buttons + No borders (Win10 look) ║
   ╠══════════════════════════════════════════════════════════╣
   ║                                                          ║
   ║  IMPORTANT: Please log out and log back in to see       ║
   ║  all changes take full effect.                          ║
   ║                                                          ║
   ║  RECOMMENDED GNOME EXTENSIONS:                          ║
   ║  • User Themes (required for shell theme)               ║
   ║  • Dash to Panel (Windows-style taskbar)                ║
   ║  • ArcMenu (Windows-style start menu)                   ║
   ║                                                          ║
   ╚══════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

echo -e "${CYAN}To uninstall everything later:${NC}"
echo "  ./install.sh -u    # From the We10X-gtk-theme directory"
echo ""
echo -e "${YELLOW}Log out and log back in to see all changes!${NC}"

```

### Customization

If you wish to change the accent color or other options, you can download the script and edit the configuration variables at the top before running it:

1.  Download the script:
    ```bash
    curl -O https://raw.githubusercontent.com/Naftaliro/zorinos-gnome-themes/main/windows-themes/we10x-win10-theme-install.sh
    ```
2.  Open `we10x-win10-theme-install.sh` in a text editor.
3.  Modify the variables in the "Configuration" section.
4.  Save the file, make it executable, and run it:
    ```bash
    chmod +x we10x-win10-theme-install.sh
    ./we10x-win10-theme-install.sh
    ```

## 5. References

[1] yeyushengfan258. *We10X GTK Theme*. GitHub Repository. [https://github.com/yeyushengfan258/We10X-gtk-theme](https://github.com/yeyushengfan258/We10X-gtk-theme)

[2] yeyushengfan258. *We10X Icon Theme*. GitHub Repository. [https://github.com/yeyushengfan258/We10X-icon-theme](https://github.com/yeyushengfan258/We10X-icon-theme)

[3] Vince Liuice. *Fluent Icon Theme* (for cursors). GitHub Repository. [https://github.com/vinceliuice/Fluent-icon-theme](https://github.com/vinceliuice/Fluent-icon-theme)
