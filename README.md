# ZorinOS / Ubuntu GNOME Theme Collection

> **Disclaimer:** This repository is a compilation of installation scripts for publicly available open-source themes. The scripts were created with the assistance of AI. The maintainer takes no responsibility for any changes made to your system. **Use at your own risk.** Please read the full [DISCLAIMER.md](DISCLAIMER.md) before proceeding.

A curated collection of **9 system-wide theme installation scripts** for ZorinOS 18 Pro, Ubuntu 24.04+, and other GNOME-based Linux distributions that use `apt` as their package manager. Every theme is pre-configured with **dark mode and a purple accent** out of the box.

Each theme includes a fully automated install script and comprehensive documentation. The scripts handle everything from dependency installation to applying the theme via `gsettings`, so you can transform your entire desktop with a single command.

## Compatibility

| Field | Value |
|---|---|
| **Target OS** | ZorinOS 18 Pro, Ubuntu 24.04+, Linux Mint 22+, Pop!_OS 24.04+ |
| **Desktop** | GNOME (42+) |
| **Package Manager** | apt (Debian/Ubuntu family) |
| **Tested Hardware** | Framework Laptop 13 (works on any hardware) |

## Theme Categories

### macOS Themes (`macos-themes/`)

Transform your Linux desktop into a macOS lookalike with full dark mode and purple accent support.

| Theme | Style | Script | Guide | Components |
|---|---|---|---|---|
| **WhiteSur** | macOS Big Sur / Monterey | [Install Script](macos-themes/whitesur-macos-theme-install.sh) | [Full Guide](macos-themes/WhiteSur_macOS_Theme_Guide.md) | GTK, Shell, GDM, Icons, Cursors, Wallpapers, Firefox |
| **Colloid** | Material Design (modern, clean) | [Install Script](macos-themes/colloid-material-theme-install.sh) | [Full Guide](macos-themes/Colloid_Material_Theme_Guide.md) | GTK, Shell, Icons, Cursors, Libadwaita |

### Windows Themes (`windows-themes/`)

Bring the Windows aesthetic to your Linux desktop with full system-wide theming.

| Theme | Style | Script | Guide | Components |
|---|---|---|---|---|
| **Fluent** | Windows 11 Fluent Design (by vinceliuice) | [Install Script](windows-themes/fluent-win11-theme-install.sh) | [Full Guide](windows-themes/fluent-win11-theme-guide.md) | GTK, Shell, Icons, Cursors, Libadwaita |
| **Win11** | Windows 11 (by yeyushengfan258) | [Install Script](windows-themes/win11-theme-install.sh) | [Full Guide](windows-themes/win11-theme-guide.md) | GTK, Shell, Icons, Cursors, Libadwaita |
| **We10X** | Windows 10 (by yeyushengfan258) | [Install Script](windows-themes/we10x-win10-theme-install.sh) | [Full Guide](windows-themes/we10x-win10-theme-guide.md) | GTK, Shell, Icons, Cursors, Libadwaita |

### Linux-Native Themes (`linux-native-themes/`)

Beautiful, purpose-built themes designed specifically for the GNOME desktop environment.

| Theme | Style | Script | Guide | Components |
|---|---|---|---|---|
| **Orchis** | Material Design (polished, modern) | [Install Script](linux-native-themes/orchis-theme-install.sh) | [Full Guide](linux-native-themes/orchis-theme-guide.md) | GTK, Shell, Icons (Tela), Cursors (Graphite), Libadwaita |
| **Graphite** | Minimalist dark | [Install Script](linux-native-themes/graphite-theme-install.sh) | [Full Guide](linux-native-themes/graphite-theme-guide.md) | GTK, Shell, GDM, Icons (Tela), Cursors (Graphite), Libadwaita |
| **Lavanda** | Purple-native elegance | [Install Script](linux-native-themes/lavanda-theme-install.sh) | [Full Guide](linux-native-themes/lavanda-theme-guide.md) | GTK, Shell, Icons (Tela), Cursors (Graphite), Libadwaita |
| **Catppuccin** | Soothing pastel dark (Mocha) | [Install Script](linux-native-themes/catppuccin-theme-install.sh) | [Full Guide](linux-native-themes/catppuccin-theme-guide.md) | GTK, Shell, Icons (Catppuccin), Cursors (Catppuccin), Libadwaita |

## Theme Switcher TUI

Tired of running scripts every time you want to switch themes? Install the **[GNOME Theme Switcher](https://github.com/Naftaliro/gnome-theme-switcher)** — a terminal-based UI that lets you browse, install, and switch between all 9 themes (plus your own custom themes) with a single keypress.

```bash
# Install the theme switcher
curl -fsSL https://raw.githubusercontent.com/Naftaliro/gnome-theme-switcher/main/install.sh | bash

# Run it
gnome-theme-switcher
```

## Quick Start

1. Clone this repository:
   ```bash
   git clone https://github.com/Naftaliro/zorinos-gnome-themes.git
   cd zorinos-gnome-themes
   ```

2. Navigate to the theme you want and run the install script:
   ```bash
   cd macos-themes
   chmod +x whitesur-macos-theme-install.sh
   ./whitesur-macos-theme-install.sh
   ```

3. Log out and log back in to see all changes.

## One-Liner Install (via curl)

You can install any theme directly without cloning the repo. Just copy and paste the one-liner for the theme you want:

### macOS Themes

```bash
# WhiteSur (macOS Big Sur)
curl -fsSL https://raw.githubusercontent.com/Naftaliro/zorinos-gnome-themes/main/macos-themes/whitesur-macos-theme-install.sh | bash

# Colloid (Material Design)
curl -fsSL https://raw.githubusercontent.com/Naftaliro/zorinos-gnome-themes/main/macos-themes/colloid-material-theme-install.sh | bash
```

### Windows Themes

```bash
# Fluent (Windows 11 Fluent Design)
curl -fsSL https://raw.githubusercontent.com/Naftaliro/zorinos-gnome-themes/main/windows-themes/fluent-win11-theme-install.sh | bash

# Win11 (Windows 11 by yeyushengfan258)
curl -fsSL https://raw.githubusercontent.com/Naftaliro/zorinos-gnome-themes/main/windows-themes/win11-theme-install.sh | bash

# We10X (Windows 10)
curl -fsSL https://raw.githubusercontent.com/Naftaliro/zorinos-gnome-themes/main/windows-themes/we10x-win10-theme-install.sh | bash
```

### Linux-Native Themes

```bash
# Orchis (Material Design)
curl -fsSL https://raw.githubusercontent.com/Naftaliro/zorinos-gnome-themes/main/linux-native-themes/orchis-theme-install.sh | bash

# Graphite (Minimalist Dark)
curl -fsSL https://raw.githubusercontent.com/Naftaliro/zorinos-gnome-themes/main/linux-native-themes/graphite-theme-install.sh | bash

# Lavanda (Purple-Native Elegance)
curl -fsSL https://raw.githubusercontent.com/Naftaliro/zorinos-gnome-themes/main/linux-native-themes/lavanda-theme-install.sh | bash

# Catppuccin Mocha (Soothing Pastel Dark)
curl -fsSL https://raw.githubusercontent.com/Naftaliro/zorinos-gnome-themes/main/linux-native-themes/catppuccin-theme-install.sh | bash
```

## Disclaimer

This repository is a **compilation only**. All themes, icons, cursors, and wallpapers are the intellectual property of their respective authors. The Bash scripts and documentation were created with the assistance of **artificial intelligence (AI)**. The maintainer of this repository takes **no responsibility** for any issues, damages, or unintended changes to your system. You use everything here **entirely at your own risk**. Please review scripts before running them, especially those requiring `sudo`.

For the full legal disclaimer, see [DISCLAIMER.md](DISCLAIMER.md).

## License

The install scripts in this repository are released under the MIT License. The themes themselves are licensed under their respective licenses (GPL-3.0 or MIT) by their original authors.

## Credits

All themes in this collection are created by the open-source community. Primary theme authors include:

| Author | Themes | GitHub |
|---|---|---|
| **Vince Liuice** | WhiteSur, Colloid, Fluent, Orchis, Graphite, Lavanda, Tela Icons, Graphite Cursors | [vinceliuice](https://github.com/vinceliuice) |
| **yeyushengfan258** | Win11, We10X | [yeyushengfan258](https://github.com/yeyushengfan258) |
| **Fausto-Korpsvart** | Catppuccin GTK Theme | [Fausto-Korpsvart](https://github.com/Fausto-Korpsvart) |
| **Catppuccin** | Catppuccin Cursors | [catppuccin](https://github.com/catppuccin) |
