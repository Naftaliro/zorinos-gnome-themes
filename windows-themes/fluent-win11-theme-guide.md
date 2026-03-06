# Complete Windows 11 Fluent Theme Guide for GNOME

**Author:** Manus AI
**Date:** March 06, 2026
**Version:** 1.0

## 1. Introduction

This guide provides a comprehensive, automated method for transforming your ZorinOS 18 Pro (or any modern GNOME-based Linux distribution) desktop with the look and feel of Windows 11. The process is managed by a single shell script that installs the complete **Fluent theme suite** developed by Vince Liuice [1]. This includes the GTK theme, GNOME Shell theme, icons, and cursors, all designed to emulate Microsoft's Fluent Design language.

The script is designed to be a "one-liner," meaning you can execute it directly from your terminal with a single command. It handles all dependencies, downloads the necessary theme components, and applies them system-wide for a consistent and polished Windows 11 experience.

## 2. What's Included

The installer script will configure the following components to match a Windows 11 aesthetic (dark mode with a purple accent, as requested):

| Component              | Description                                                                                             |
| ---------------------- | ------------------------------------------------------------------------------------------------------- |
| **GTK Theme**          | The main theme for application windows, buttons, and controls. Installed in a dark variant.             |
| **GNOME Shell Theme**  | Themes the top bar, activities overview, system menus, and notifications.                               |
| **Icon Theme**         | A full set of Fluent Design icons for applications, folders, and system indicators.                     |
| **Cursor Theme**       | The Fluent Design mouse pointer, which closely resembles the Windows 11 cursor.                         |
| **Libadwaita Override**| Applies the theme to modern GTK4 applications that use the `libadwaita` library, ensuring maximum consistency. |
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
curl -fsSL https://raw.githubusercontent.com/Naftaliro/zorinos-gnome-themes/main/windows-themes/fluent-win11-theme-install.sh | bash
```

After running the command, the script will guide you through the process, installing all dependencies and theme components. The entire process may take several minutes. Once finished, you **must log out and log back in** to see all the changes take full effect.

## 4. The Installation Script

For full transparency, the complete contents of the installation script are provided below. It is designed to be safe and informative, printing its progress at every step.

```bash
#!/usr/bin/env bash
#
# Fluent (Windows 11 Fluent Design) Full System Theme Installer
# for ZorinOS 18 Pro / Ubuntu (GNOME)
# ──────────────────────────────────────────────────────────────────────────────
# Installs: GTK theme (dark, purple accent), GNOME Shell theme, Fluent icons
#           (purple), Fluent cursors (dark), libadwaita override, and Flatpak
#           theming. A polished Windows 11 Fluent Design look for your desktop.
#
# Theme suite by vinceliuice:
#   - Fluent GTK Theme:  https://github.com/vinceliuice/Fluent-gtk-theme
#   - Fluent Icon Theme: https://github.com/vinceliuice/Fluent-icon-theme
#   - Fluent Cursors:    included in Fluent-icon-theme/cursors/
#
# Usage:
#   chmod +x fluent-win11-theme-install.sh && ./fluent-win11-theme-install.sh
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
ACCENT="purple"          # Options: default blue purple pink red orange yellow green teal grey
COLOR="dark"             # Options: standard light dark
SIZE="standard"          # Options: standard compact
SHELL_ICON="default"     # Options: default apple simple gnome ubuntu zorin arch manjaro fedora debian tux nixos
                         # "default" = Windows icon in the shell panel
TWEAKS="noborder round"  # Options: solid float round blur noborder square
                         # "noborder" = no window/menu borders, "round" = rounded windows
LIBADWAITA="yes"         # Override libadwaita (gtk4) apps with theme
FLATPAK_THEME="yes"      # Connect theme to Flatpak apps
ICON_COLOR="purple"      # Options: standard green grey orange pink purple red yellow teal
CURSOR_VARIANT="dark"    # Options: light dark

# ── Workspace ─────────────────────────────────────────────────────────────────
WORK_DIR="${HOME}/.fluent-install-tmp"
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
header "STEP 2/5: Cloning Fluent Repositories"
# ══════════════════════════════════════════════════════════════════════════════

cd "${WORK_DIR}"

info "Cloning Fluent GTK Theme..."
git clone https://github.com/vinceliuice/Fluent-gtk-theme.git --depth=1

info "Cloning Fluent Icon Theme (includes cursors)..."
git clone https://github.com/vinceliuice/Fluent-icon-theme.git --depth=1

ok "All repositories cloned."

# ══════════════════════════════════════════════════════════════════════════════
header "STEP 3/5: Installing Fluent GTK + GNOME Shell Theme"
# ══════════════════════════════════════════════════════════════════════════════

cd "${WORK_DIR}/Fluent-gtk-theme"

INSTALL_ARGS=(
    -c "${COLOR}"
    -t "${ACCENT}"
    -s "${SIZE}"
    -i "${SHELL_ICON}"
)

# Add tweaks if specified
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
header "STEP 4/5: Installing Fluent Icons + Cursors"
# ══════════════════════════════════════════════════════════════════════════════

cd "${WORK_DIR}/Fluent-icon-theme"

info "Installing Fluent icons (${ICON_COLOR} variant)..."
./install.sh "${ICON_COLOR}"

info "Installing Fluent cursor theme..."
cd cursors && ./install.sh && cd ..

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
# Fluent GTK theme naming: Fluent-purple-Dark (accent-Color)
ACCENT_PART="${ACCENT}"
[[ "${ACCENT}" == "default" ]] && ACCENT_PART=""

COLOR_PART=""
case "${COLOR}" in
    light)    COLOR_PART="-Light" ;;
    dark)     COLOR_PART="-Dark" ;;
    standard) COLOR_PART="" ;;
esac

if [[ -n "${ACCENT_PART}" ]]; then
    GTK_THEME="Fluent-${ACCENT_PART}${COLOR_PART}"
else
    GTK_THEME="Fluent${COLOR_PART}"
fi

# Icon theme: Fluent-purple-dark
if [[ "${ICON_COLOR}" == "standard" ]]; then
    ICON_THEME="Fluent-dark"
else
    ICON_THEME="Fluent-${ICON_COLOR}-dark"
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
   ║    Fluent (Windows 11 Design) Theme - Fully Installed!  ║
   ╠══════════════════════════════════════════════════════════╣
   ║  GTK Theme:    Fluent-purple-Dark                       ║
   ║  Shell Theme:  Fluent-purple-Dark                       ║
   ║  Icon Theme:   Fluent-purple-dark                       ║
   ║  Cursors:      Fluent-dark-cursors                      ║
   ║  Libadwaita:   Overridden with dark purple theme        ║
   ║  Tweaks:       No borders + Rounded windows             ║
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
echo "  ./install.sh -u    # From the Fluent-gtk-theme directory"
echo ""
echo -e "${YELLOW}Log out and log back in to see all changes!${NC}"

```

### Customization

If you wish to change the accent color or other options, you can download the script and edit the configuration variables at the top before running it:

1.  Download the script:
    ```bash
    curl -O https://raw.githubusercontent.com/Naftaliro/zorinos-gnome-themes/main/windows-themes/fluent-win11-theme-install.sh
    ```
2.  Open `fluent-win11-theme-install.sh` in a text editor.
3.  Modify the variables in the "Configuration" section (e.g., change `ACCENT="purple"` to `ACCENT="teal"`).
4.  Save the file, make it executable, and run it:
    ```bash
    chmod +x fluent-win11-theme-install.sh
    ./fluent-win11-theme-install.sh
    ```

## 5. References

[1] Vince Liuice. *Fluent GTK Theme*. GitHub Repository. [https://github.com/vinceliuice/Fluent-gtk-theme](https://github.com/vinceliuice/Fluent-gtk-theme)

[2] Vince Liuice. *Fluent Icon Theme*. GitHub Repository. [https://github.com/vinceliuice/Fluent-icon-theme](https://github.com/vinceliuice/Fluent-icon-theme)
