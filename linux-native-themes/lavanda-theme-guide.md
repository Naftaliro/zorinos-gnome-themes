# Lavanda (Purple-Native Elegance) Theme: Full Installation Guide

> **Disclaimer:** This repository is a compilation of installation scripts for publicly available open-source themes. The scripts were created with the assistance of AI. The maintainer takes no responsibility for any changes made to your system. **Use at your own risk.** Please read the full [DISCLAIMER.md](../../DISCLAIMER.md) before proceeding.

This guide provides a comprehensive overview and step-by-step installation for the **Lavanda** theme suite, a beautiful and elegant theme for GNOME created by Vince Liuice [1]. Unlike other themes that use purple as an accent, Lavanda is **inherently purple**—the entire design is built around a soothing lavender color palette, making it the perfect choice for purple lovers.

## Theme Components

The script installs and configures the following components for a cohesive desktop experience:

| Component | Theme | Variant | Source |
|---|---|---|---|
| **GTK Theme** | Lavanda | `Lavanda-Dark` | [vinceliuice/Lavanda-gtk-theme][1] |
| **GNOME Shell** | Lavanda | `Lavanda-Dark` | [vinceliuice/Lavanda-gtk-theme][1] |
| **Icon Theme** | Tela | `Tela-purple-dark` | [vinceliuice/Tela-icon-theme][2] |
| **Cursor Theme**| Graphite | `Graphite-dark-cursors` | [vinceliuice/Graphite-cursors][3] |
| **Libadwaita** | Lavanda | Overridden for GTK4 apps | [vinceliuice/Lavanda-gtk-theme][1] |
| **Flatpak** | Lavanda | Filesystem override | N/A |

This combination results in a visually consistent and elegant purple desktop, from the login screen to the application windows.

## Installation

There are two ways to install the theme: the one-liner `curl` command or by cloning the repository.

### Method 1: One-Liner Install (Recommended)

This is the fastest and easiest method. Open a terminal and run the following command:

```bash
curl -fsSL https://raw.githubusercontent.com/Naftaliro/zorinos-gnome-themes/main/linux-native-themes/lavanda-theme-install.sh | bash
```

The script will handle everything: installing dependencies, cloning the necessary repositories, building the themes, and applying them via `gsettings`.

### Method 2: Manual Install (from Repo)

If you have already cloned the repository, you can run the script directly.

1.  **Navigate to the script directory:**
    ```bash
    cd /path/to/zorinos-gnome-themes/linux-native-themes
    ```

2.  **Make the script executable:**
    ```bash
    chmod +x lavanda-theme-install.sh
    ```

3.  **Run the installer:**
    ```bash
    ./lavanda-theme-install.sh
    ```

## Post-Installation

After the script finishes, you **must log out and log back in** for all changes to take effect, especially for the GNOME Shell theme.

### Enable User Themes Extension

The script installs the `gnome-shell-extensions` package and attempts to enable the **User Themes** extension. If your shell theme does not apply correctly after logging back in, you may need to enable it manually:

1.  Open the **Extensions** application.
2.  Find **User Themes** in the list.
3.  Toggle it on if it is disabled.

## Customization

You can easily customize the theme by editing the configuration variables at the top of the `lavanda-theme-install.sh` script before running it.

```bash
# ── Configuration ─────────────────────────────────────────────────────────────
THEME_VARIANT="standard" # Options: standard sea (sea = teal/ocean variant)
COLOR="dark"             # Options: standard light dark
SIZE="standard"          # Options: standard compact
SHELL_ICON="zorin"       # Options: default apple manjaro ubuntu fedora debian arch gnome budgie popos gentoo void zorin mxlinux opensuse tux
LIBADWAITA="yes"
FLATPAK_THEME="yes"
ICON_COLOR="purple"      # Options: standard black blue brown green grey orange pink purple red yellow dracula nord
CURSOR_VARIANT="dark"    # Options: light dark
```

For example, to install the teal/ocean variant, you would change `THEME_VARIANT` to `"sea"`.

## Full Installation Script

For transparency, the full source code of the installation script is provided below.

```bash
#!/usr/bin/env bash
#
# Lavanda (Purple-Native Elegance) Full System Theme Installer
# for ZorinOS 18 Pro / Ubuntu (GNOME)
# ──────────────────────────────────────────────────────────────────────────────
# Installs: GTK theme (dark), GNOME Shell theme, Tela icons (purple),
#           Graphite cursors (dark), libadwaita override, and Flatpak theming.
#           Lavanda is inherently purple — the entire theme is built around a
#           lavender/purple color palette, making it the perfect choice for
#           purple lovers.
#
# DISCLAIMER: This script is provided "as is" without warranty of any kind.
# It was created with the assistance of AI. Use at your own risk. See the
# full DISCLAIMER.md in the repository root for details.
#
# Theme suite by vinceliuice:
#   - Lavanda GTK Theme:   https://github.com/vinceliuice/Lavanda-gtk-theme
#   - Tela Icon Theme:     https://github.com/vinceliuice/Tela-icon-theme
#   - Graphite Cursors:    https://github.com/vinceliuice/Graphite-cursors
#
# Usage:
#   chmod +x lavanda-theme-install.sh && ./lavanda-theme-install.sh
# ──────────────────────────────────────────────────────────────────────────────

set -euo pipefail

RED=\'\033[0;31m\'; GREEN=\'\033[0;32m\'; YELLOW=\'\033[1;33m\'; CYAN=\'\033[0;36m\'; BOLD=\'\033[1m\'; NC=\'\033[0m\'
info()  { echo -e "${CYAN}[INFO]${NC}  $*"; }
ok()    { echo -e "${GREEN}[OK]${NC}    $*"; }
warn()  { echo -e "${YELLOW}[WARN]${NC}  $*"; }
header(){ echo -e "\n${BOLD}═══════════════════════════════════════════════════════════${NC}"; echo -e "${BOLD}  $*${NC}"; echo -e "${BOLD}═══════════════════════════════════════════════════════════${NC}\n"; }

# ── Configuration ─────────────────────────────────────────────────────────────
THEME_VARIANT="standard" # Options: standard sea (sea = teal/ocean variant)
COLOR="dark"             # Options: standard light dark
SIZE="standard"          # Options: standard compact
SHELL_ICON="zorin"       # Options: default apple manjaro ubuntu fedora debian arch gnome budgie popos gentoo void zorin mxlinux opensuse tux
LIBADWAITA="yes"
FLATPAK_THEME="yes"
ICON_COLOR="purple"      # Options: standard black blue brown green grey orange pink purple red yellow dracula nord
CURSOR_VARIANT="dark"    # Options: light dark

WORK_DIR="${HOME}/.lavanda-install-tmp"
mkdir -p "${WORK_DIR}"
cleanup() { info "Cleaning up..."; rm -rf "${WORK_DIR}"; ok "Done."; }
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
header "STEP 2/6: Cloning Repositories"
# ══════════════════════════════════════════════════════════════════════════════
cd "${WORK_DIR}"
info "Cloning Lavanda GTK Theme..."
git clone https://github.com/vinceliuice/Lavanda-gtk-theme.git --depth=1
info "Cloning Tela Icon Theme..."
git clone https://github.com/vinceliuice/Tela-icon-theme.git --depth=1
info "Cloning Graphite Cursors..."
git clone https://github.com/vinceliuice/Graphite-cursors.git --depth=1
ok "All repositories cloned."

# ══════════════════════════════════════════════════════════════════════════════
header "STEP 3/6: Installing Lavanda GTK + GNOME Shell Theme"
# ══════════════════════════════════════════════════════════════════════════════
cd "${WORK_DIR}/Lavanda-gtk-theme"
INSTALL_ARGS=(-c "${COLOR}" -s "${SIZE}" -i "${SHELL_ICON}")
[[ "${THEME_VARIANT}" != "standard" ]] && INSTALL_ARGS+=(-t "${THEME_VARIANT}")
info "Running: ./install.sh ${INSTALL_ARGS[*]}"
./install.sh "${INSTALL_ARGS[@]}"
if [[ "${LIBADWAITA}" == "yes" ]]; then
    info "Installing libadwaita (gtk4) theme override..."
    ./install.sh -l -c "${COLOR}"
fi
ok "GTK + GNOME Shell theme installed."

# ══════════════════════════════════════════════════════════════════════════════
header "STEP 4/6: Installing Tela Icons"
# ══════════════════════════════════════════════════════════════════════════════
cd "${WORK_DIR}/Tela-icon-theme"
info "Installing Tela icons (${ICON_COLOR} variant)..."
./install.sh "${ICON_COLOR}"
ok "Icons installed."

# ══════════════════════════════════════════════════════════════════════════════
header "STEP 5/6: Installing Graphite Cursors"
# ══════════════════════════════════════════════════════════════════════════════
cd "${WORK_DIR}/Graphite-cursors"
info "Installing Graphite cursors..."
DEST_DIR="${HOME}/.local/share/icons"
mkdir -p "${DEST_DIR}"
cp -r dist-dark "${DEST_DIR}/Graphite-dark-cursors"
cp -r dist-light "${DEST_DIR}/Graphite-light-cursors"
ok "Cursors installed."

# ══════════════════════════════════════════════════════════════════════════════
header "STEP 6/6: Applying Theme via gsettings"
# ══════════════════════════════════════════════════════════════════════════════
if [[ "${FLATPAK_THEME}" == "yes" ]]; then
    info "Connecting theme to Flatpak apps..."
    sudo flatpak override --filesystem=xdg-config/gtk-3.0 2>/dev/null || true
    sudo flatpak override --filesystem=xdg-config/gtk-4.0 2>/dev/null || true
fi

COLOR_PART=""; case "${COLOR}" in light) COLOR_PART="-Light";; dark) COLOR_PART="-Dark";; esac
if [[ "${THEME_VARIANT}" == "sea" ]]; then
    GTK_THEME="Lavanda-Sea${COLOR_PART}"
else
    GTK_THEME="Lavanda${COLOR_PART}"
fi
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
cat << \'EOF\'
   ╔══════════════════════════════════════════════════════════╗
   ║   Lavanda (Purple-Native Elegance) - Fully Installed!   ║
   ╠══════════════════════════════════════════════════════════╣
   ║  GTK Theme:    Lavanda-Dark                             ║
   ║  Shell Theme:  Lavanda-Dark                             ║
   ║  Icon Theme:   Tela-purple-dark                         ║
   ║  Cursors:      Graphite-dark-cursors                    ║
   ║  Libadwaita:   Overridden with dark lavender theme      ║
   ║  Note:         Lavanda IS purple — no accent needed!    ║
   ╠══════════════════════════════════════════════════════════╣
   ║                                                          ║
   ║  Please log out and log back in to see all changes.     ║
   ║                                                          ║
   ╚══════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"
echo -e "${YELLOW}Log out and log back in to see all changes!${NC}"

```

## References

[1] vinceliuice, *Lavanda GTK Theme*, GitHub Repository, [https://github.com/vinceliuice/Lavanda-gtk-theme](https://github.com/vinceliuice/Lavanda-gtk-theme)

[2] vinceliuice, *Tela Icon Theme*, GitHub Repository, [https://github.com/vinceliuice/Tela-icon-theme](https://github.com/vinceliuice/Tela-icon-theme)

[3] vinceliuice, *Graphite Cursors*, GitHub Repository, [https://github.com/vinceliuice/Graphite-cursors](https://github.com/vinceliuice/Graphite-cursors)
