# Complete Windows 11 Style Theme Guide for GNOME

**Author:** Manus AI
**Date:** March 06, 2026
**Version:** 1.0

## 1. Introduction

This guide provides an automated method for installing the **Win11 theme suite** by developer yeyushengfan258 [1]. It offers a faithful recreation of the Windows 11 user interface for the GNOME desktop, providing an alternative to the Fluent theme by vinceliuice.

The process is managed by a single shell script that installs the complete suite, including the GTK theme, GNOME Shell theme, matching icons, and cursors. It provides a cohesive and polished Windows 11 look and feel for your ZorinOS 18 Pro or Ubuntu-based system.

## 2. What's Included

The installer script will configure the following components to match a Windows 11 aesthetic (dark mode with a purple accent, as requested):

| Component              | Description                                                                                             |
| ---------------------- | ------------------------------------------------------------------------------------------------------- |
| **GTK Theme**          | The main theme for application windows, buttons, and controls.                                          |
| **GNOME Shell Theme**  | Themes the top bar, activities overview, system menus, and notifications.                               |
| **Icon Theme**         | A full set of Windows 11 style icons for applications, folders, and system indicators.                  |
| **Cursor Theme**       | The Fluent Design mouse pointer (from vinceliuice's theme), which is visually identical.                |
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
curl -fsSL https://raw.githubusercontent.com/Naftaliro/zorinos-gnome-themes/main/windows-themes/win11-theme-install.sh | bash
```

After running the command, the script will guide you through the process. Once finished, you **must log out and log back in** to see all the changes take full effect.

## 4. The Installation Script

For full transparency, the complete contents of the installation script are provided below.

```bash
#!/usr/bin/env bash
#
# Win11 (Windows 11 Style) Full System Theme Installer
# for ZorinOS 18 Pro / Ubuntu (GNOME)
# ──────────────────────────────────────────────────────────────────────────────
# Installs: GTK theme (dark, purple accent), GNOME Shell theme, Win11 icons
#           (purple), Fluent cursors (dark), libadwaita override, and Flatpak
#           theming. A faithful Windows 11 recreation for your Linux desktop.
#
# Theme suite by yeyushengfan258 (icons + GTK) and vinceliuice (cursors):
#   - Win11 GTK Theme:   https://github.com/yeyushengfan258/Win11-gtk-theme
#   - Win11 Icon Theme:  https://github.com/yeyushengfan258/Win11-icon-theme
#   - Fluent Cursors:    https://github.com/vinceliuice/Fluent-icon-theme
#
# Usage:
#   chmod +x win11-theme-install.sh && ./win11-theme-install.sh
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
TWEAKS="round noborder"  # Options: solid float round blur noborder square
LIBADWAITA="yes"         # Override libadwaita (gtk4) apps with theme
FLATPAK_THEME="yes"      # Connect theme to Flatpak apps
ICON_ACCENT="purple"     # Icon: default black blue green nord purple red
CURSOR_VARIANT="dark"    # Options: light dark

# ── Workspace ─────────────────────────────────────────────────────────────────
WORK_DIR="${HOME}/.win11-install-tmp"
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

info "Cloning Win11 GTK Theme..."
git clone https://github.com/yeyushengfan258/Win11-gtk-theme.git --depth=1

info "Cloning Win11 Icon Theme..."
git clone https://github.com/yeyushengfan258/Win11-icon-theme.git --depth=1

info "Cloning Fluent Icon Theme (for cursors)..."
git clone https://github.com/vinceliuice/Fluent-icon-theme.git --depth=1

ok "All repositories cloned."

# ══════════════════════════════════════════════════════════════════════════════
header "STEP 3/5: Installing Win11 GTK + GNOME Shell Theme"
# ══════════════════════════════════════════════════════════════════════════════

cd "${WORK_DIR}/Win11-gtk-theme"

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
header "STEP 4/5: Installing Win11 Icons + Fluent Cursors"
# ══════════════════════════════════════════════════════════════════════════════

cd "${WORK_DIR}/Win11-icon-theme"

info "Installing Win11 icons (${ICON_ACCENT} variant)..."
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
    GTK_THEME="Win11-${ACCENT_PART}${COLOR_PART}"
else
    GTK_THEME="Win11${COLOR_PART}"
fi

# Icon theme: Win11-purple-dark
if [[ "${ICON_ACCENT}" == "default" ]]; then
    ICON_THEME="Win11-dark"
else
    ICON_THEME="Win11-${ICON_ACCENT}-dark"
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
   ║     Win11 (Windows 11 Style) Theme - Fully Installed!   ║
   ╠══════════════════════════════════════════════════════════╣
   ║  GTK Theme:    Win11-purple-Dark                        ║
   ║  Shell Theme:  Win11-purple-Dark                        ║
   ║  Icon Theme:   Win11-purple-dark                        ║
   ║  Cursors:      Fluent-dark-cursors                      ║
   ║  Libadwaita:   Overridden with dark purple theme        ║
   ║  Tweaks:       Rounded windows + No borders             ║
   ╠══════════════════════════════════════════════════════════╣
   ║                                                          ║
   ║  IMPORTANT: Please log out and log back in to see       ║
   ║  all changes take full effect.                          ║
   ║                                                          ║
   ║  RECOMMENDED GNOME EXTENSIONS:                          ║
   ║  • User Themes (required for shell theme)               ║
   ║  • Dash to Panel (Windows-style taskbar)                ║
   ║  • ArcMenu (Windows-style start menu)                   ║
   ║  • Blur My Shell (acrylic/mica effects)                 ║
   ║                                                          ║
   ╚══════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

echo -e "${CYAN}To uninstall everything later:${NC}"
echo "  ./install.sh -u    # From the Win11-gtk-theme directory"
echo ""
echo -e "${YELLOW}Log out and log back in to see all changes!${NC}"

```

### Customization

If you wish to change the accent color or other options, you can download the script and edit the configuration variables at the top before running it:

1.  Download the script:
    ```bash
    curl -O https://raw.githubusercontent.com/Naftaliro/zorinos-gnome-themes/main/windows-themes/win11-theme-install.sh
    ```
2.  Open `win11-theme-install.sh` in a text editor.
3.  Modify the variables in the "Configuration" section.
4.  Save the file, make it executable, and run it:
    ```bash
    chmod +x win11-theme-install.sh
    ./win11-theme-install.sh
    ```

## 5. References

[1] yeyushengfan258. *Win11 GTK Theme*. GitHub Repository. [https://github.com/yeyushengfan258/Win11-gtk-theme](https://github.com/yeyushengfan258/Win11-gtk-theme)

[2] yeyushengfan258. *Win11 Icon Theme*. GitHub Repository. [https://github.com/yeyushengfan258/Win11-icon-theme](https://github.com/yeyushengfan258/Win11-icon-theme)

[3] Vince Liuice. *Fluent Icon Theme* (for cursors). GitHub Repository. [https://github.com/vinceliuice/Fluent-icon-theme](https://github.com/vinceliuice/Fluent-icon-theme)
