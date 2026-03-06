# Complete Material Design Theme Guide for ZorinOS 18 (GNOME)

**Author:** Manus AI
**Date:** March 06, 2026
**Version:** 1.0

## 1. Introduction

As a second option for a complete system-wide theme, this guide provides an automated method for installing the **Colloid theme suite** on your ZorinOS 18 Pro desktop. Developed by the prolific theme creator Vince Liuice [1], Colloid offers a clean, modern, and highly customizable Material Design aesthetic for the GNOME desktop.

Similar to the WhiteSur guide, this process is managed by a single shell script that installs the complete suite, including the GTK theme, GNOME Shell theme, matching icons, and cursors. It provides a cohesive and polished alternative to the default system appearance.

## 2. What's Included

The installer script will configure the following components to give your system a unified Material Design look:

| Component              | Description                                                                                             |
| ---------------------- | ------------------------------------------------------------------------------------------------------- |
| **GTK Theme**          | The main theme for application windows, buttons, and controls. Installed in a dark variant with deep black tweaks. |
| **GNOME Shell Theme**  | Themes the top bar, activities overview, system menus, and notifications.                               |
| **Icon Theme**         | A full set of Material Design icons with folder colors matching the chosen accent.                      |
| **Cursor Theme**       | A matching dark cursor theme.                                                                           |
| **Libadwaita Override**| Applies the theme to modern GTK4 applications that use the `libadwaita` library for better consistency.   |
| **Flatpak Support**    | Ensures Flatpak applications respect the new system theme.                                              |
| **Custom Tweaks**      | The script is pre-configured to use a "black" variant for a deeper dark mode and a "rimless" style for a cleaner look. |

*Note: Unlike the WhiteSur theme, the Colloid suite does not include a dedicated GDM (login screen) theme in its installation script.*

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
curl -fsSL https://raw.githubusercontent.com/manus-team/user-request-uy271n8y/main/colloid-material-theme-install.sh | bash
```

After running the command, the script will install all dependencies and theme components. Once finished, you **must log out and log back in** for all changes to take full effect.

## 4. The Installation Script

For full transparency, the complete contents of the installation script are provided below. It is designed to be safe and informative, printing its progress at every step.

```bash
#!/usr/bin/env bash
#
# Colloid Material Design Full System Theme Installer for ZorinOS 18 Pro / Ubuntu (GNOME)
# ──────────────────────────────────────────────────────────────────────────────
# Installs: GTK theme (dark, purple accent), GNOME Shell theme, matching icons
#           (purple), matching cursors (dark), libadwaita override, and Flatpak
#           theming. A modern, clean Material Design look for your desktop.
#
# Designed for: ZorinOS 18 Pro (Ubuntu 24.04 base) with GNOME desktop
# Hardware ref: Framework Laptop 13 (works on any GNOME system)
#
# Theme suite by vinceliuice:
#   - Colloid GTK Theme:  https://github.com/vinceliuice/Colloid-gtk-theme
#   - Colloid Icon Theme: https://github.com/vinceliuice/Colloid-icon-theme
#   - Colloid Cursors:    included in Colloid-icon-theme/cursors/
#
# Usage:
#   chmod +x colloid-material-theme-install.sh && ./colloid-material-theme-install.sh
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
TWEAKS="black rimless"   # Options: nord dracula gruvbox everforest catppuccin black rimless normal float
                         # "black" = deep black dark mode, "rimless" = no window borders
LIBADWAITA="yes"         # Override libadwaita (gtk4) apps with theme
FLATPAK_THEME="yes"      # Connect theme to Flatpak apps
ICON_SCHEME="default"    # Options: default nord dracula gruvbox everforest catppuccin
CURSOR_VARIANT="dark"    # Options: light dark

# ── Workspace ─────────────────────────────────────────────────────────────────
WORK_DIR="${HOME}/.colloid-install-tmp"
mkdir -p "${WORK_DIR}"

cleanup() {
    info "Cleaning up temporary files..."
    rm -rf "${WORK_DIR}"
    ok "Cleanup complete."
}
trap cleanup EXIT

# ══════════════════════════════════════════════════════════════════════════════
header "STEP 1/6: Installing System Dependencies"
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
header "STEP 2/6: Cloning Colloid Repositories"
# ══════════════════════════════════════════════════════════════════════════════

cd "${WORK_DIR}"

info "Cloning Colloid GTK Theme..."
git clone https://github.com/vinceliuice/Colloid-gtk-theme.git --depth=1

info "Cloning Colloid Icon Theme (includes cursors)..."
git clone https://github.com/vinceliuice/Colloid-icon-theme.git --depth=1

ok "All repositories cloned."

# ══════════════════════════════════════════════════════════════════════════════
header "STEP 3/6: Installing Colloid GTK + GNOME Shell Theme"
# ══════════════════════════════════════════════════════════════════════════════

cd "${WORK_DIR}/Colloid-gtk-theme"

INSTALL_ARGS=(
    -c "${COLOR}"
    -t "${ACCENT}"
    -s "${SIZE}"
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
header "STEP 4/6: Installing Colloid Icon Theme"
# ══════════════════════════════════════════════════════════════════════════════

cd "${WORK_DIR}/Colloid-icon-theme"

info "Installing Colloid icons with ${ACCENT} accent and ${ICON_SCHEME} scheme..."
ICON_ARGS=(-t "${ACCENT}")
if [[ "${ICON_SCHEME}" != "default" ]]; then
    ICON_ARGS+=(-s "${ICON_SCHEME}")
fi

./install.sh "${ICON_ARGS[@]}"

ok "Icon theme installed."

# ══════════════════════════════════════════════════════════════════════════════
header "STEP 5/6: Installing Colloid Cursors"
# ══════════════════════════════════════════════════════════════════════════════

cd "${WORK_DIR}/Colloid-icon-theme/cursors"

info "Installing Colloid cursor theme..."
./install.sh

ok "Cursor theme installed (both light and dark variants)."

# ══════════════════════════════════════════════════════════════════════════════
header "STEP 6/6: Applying Theme via gsettings"
# ══════════════════════════════════════════════════════════════════════════════

# Flatpak theme connection
if [[ "${FLATPAK_THEME}" == "yes" ]]; then
    info "Connecting theme to Flatpak apps..."
    sudo flatpak override --filesystem=xdg-config/gtk-3.0 2>/dev/null || true
    sudo flatpak override --filesystem=xdg-config/gtk-4.0 2>/dev/null || true
    ok "Flatpak theme overrides applied."
fi

# Determine the exact theme directory names
# GTK theme naming: Colloid-Purple-Dark  (capitalized color name)
# The install.sh capitalizes the first letter of the accent
ACCENT_CAP="$(echo "${ACCENT}" | sed 's/^./\U&/')"
COLOR_CAP="$(echo "${COLOR}" | sed 's/^./\U&/')"

GTK_THEME="Colloid-${ACCENT_CAP}-${COLOR_CAP}"
if [[ "${ACCENT}" == "default" ]]; then
    GTK_THEME="Colloid-${COLOR_CAP}"
fi
if [[ "${COLOR}" == "standard" ]]; then
    GTK_THEME="Colloid-${ACCENT_CAP}"
    [[ "${ACCENT}" == "default" ]] && GTK_THEME="Colloid"
fi

# Check for tweaks suffix
TWEAK_SUFFIX=""
for tw in ${TWEAKS}; do
    case "${tw}" in
        nord|dracula|gruvbox|everforest|catppuccin)
            TWEAK_SUFFIX="-${tw^}"
            ;;
    esac
done
GTK_THEME="${GTK_THEME}${TWEAK_SUFFIX}"

# Icon theme: Colloid-purple-dark
ICON_THEME="Colloid-${ACCENT}-dark"
if [[ "${ACCENT}" == "default" ]]; then
    ICON_THEME="Colloid-dark"
fi

# Cursor theme
if [[ "${CURSOR_VARIANT}" == "dark" ]]; then
    CURSOR_THEME="Colloid-dark-cursors"
else
    CURSOR_THEME="Colloid-cursors"
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
   ║       Colloid Material Design Theme - Fully Installed!  ║
   ╠══════════════════════════════════════════════════════════╣
   ║  GTK Theme:    Colloid-Purple-Dark                      ║
   ║  Shell Theme:  Colloid-Purple-Dark                      ║
   ║  Icon Theme:   Colloid-purple-dark                      ║
   ║  Cursors:      Colloid-dark-cursors                     ║
   ║  Libadwaita:   Overridden with dark purple theme        ║
   ║  Tweaks:       Black (deep dark) + Rimless (no borders) ║
   ╠══════════════════════════════════════════════════════════╣
   ║                                                          ║
   ║  IMPORTANT: Please log out and log back in to see       ║
   ║  all changes take full effect.                          ║
   ║                                                          ║
   ║  RECOMMENDED GNOME EXTENSIONS:                          ║
   ║  • User Themes (required for shell theme)               ║
   ║  • Dash to Dock or Dash to Panel                        ║
   ║  • Blur My Shell (frosted glass effects)                ║
   ║                                                          ║
   ║  COLORSCHEME OPTIONS (re-run with --tweaks):            ║
   ║  • nord      - Nord color palette                       ║
   ║  • dracula   - Dracula color palette                    ║
   ║  • gruvbox   - Gruvbox color palette                    ║
   ║  • everforest - Everforest color palette                ║
   ║  • catppuccin - Catppuccin color palette                ║
   ║                                                          ║
   ╚══════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

echo -e "${CYAN}To uninstall everything later:${NC}"
echo "  cd ~/.colloid-install-tmp/Colloid-gtk-theme  (if still present)"
echo "  ./install.sh -r                  # Remove GTK themes"
echo ""
echo -e "${YELLOW}Log out and log back in to see all changes!${NC}"

```

### Customization

If you wish to change the accent color or other options, you can download the script and edit the configuration variables at the top before running it:

1.  Download the script:
    ```bash
    curl -O https://raw.githubusercontent.com/manus-team/user-request-uy271n8y/main/colloid-material-theme-install.sh
    ```
2.  Open `colloid-material-theme-install.sh` in a text editor.
3.  Modify the variables in the "Configuration" section (e.g., change `ACCENT="purple"` to `ACCENT="teal"`).
4.  Save the file, make it executable, and run it:
    ```bash
    chmod +x colloid-material-theme-install.sh
    ./colloid-material-theme-install.sh
    ```

## 5. References

[1] Vince Liuice. *Colloid GTK Theme*. GitHub Repository. [https://github.com/vinceliuice/Colloid-gtk-theme](https://github.com/vinceliuice/Colloid-gtk-theme)

[2] Vince Liuice. *Colloid Icon Theme*. GitHub Repository. [https://github.com/vinceliuice/Colloid-icon-theme](https://github.com/vinceliuice/Colloid-icon-theme)
