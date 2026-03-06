# ZorinOS / Ubuntu GNOME Theme Collection

A curated collection of **system-wide theme installation scripts** for ZorinOS 18 Pro, Ubuntu 24.04+, and other GNOME-based Linux distributions that use `apt` as their package manager.

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

You can also install any theme directly without cloning the repo. For example:

```bash
# macOS WhiteSur theme
curl -fsSL https://raw.githubusercontent.com/Naftaliro/zorinos-gnome-themes/main/macos-themes/whitesur-macos-theme-install.sh | bash

# Windows 11 Fluent theme
curl -fsSL https://raw.githubusercontent.com/Naftaliro/zorinos-gnome-themes/main/windows-themes/fluent-win11-theme-install.sh | bash

# Windows 11 (yeyushengfan258) theme
curl -fsSL https://raw.githubusercontent.com/Naftaliro/zorinos-gnome-themes/main/windows-themes/win11-theme-install.sh | bash

# Windows 10 We10X theme
curl -fsSL https://raw.githubusercontent.com/Naftaliro/zorinos-gnome-themes/main/windows-themes/we10x-win10-theme-install.sh | bash

# Colloid Material Design theme
curl -fsSL https://raw.githubusercontent.com/Naftaliro/zorinos-gnome-themes/main/macos-themes/colloid-material-theme-install.sh | bash
```

## License

The install scripts in this repository are released under the MIT License. The themes themselves are licensed under their respective licenses (GPL-3.0 or MIT) by their original authors.

## Credits

All themes in this collection are created by the open-source community. Primary theme authors include:

| Author | Themes | GitHub |
|---|---|---|
| **Vince Liuice** | WhiteSur, Colloid, Fluent | [vinceliuice](https://github.com/vinceliuice) |
| **yeyushengfan258** | Win11, We10X | [yeyushengfan258](https://github.com/yeyushengfan258) |
