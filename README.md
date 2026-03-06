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

| Theme | Style | Components |
|---|---|---|
| **WhiteSur** | macOS Big Sur / Monterey | GTK, Shell, GDM, Icons, Cursors, Wallpapers, Firefox |
| **Colloid** | Material Design (modern, clean) | GTK, Shell, Icons, Cursors, Libadwaita |

### Windows Themes (`windows-themes/`)

Bring the Windows aesthetic to your Linux desktop with full system-wide theming.

| Theme | Style | Components |
|---|---|---|
| **Fluent** | Windows 11 Fluent Design | GTK, Shell, Icons, Cursors, Libadwaita |
| **We10X** | Windows 10 | GTK, Shell, Icons, Cursors |

## Quick Start

1. Clone this repository:
   ```bash
   git clone https://github.com/YOUR_USERNAME/zorinos-gnome-themes.git
   cd zorinos-gnome-themes
   ```

2. Navigate to the theme you want and run the install script:
   ```bash
   cd macos-themes
   chmod +x whitesur-macos-theme-install.sh
   ./whitesur-macos-theme-install.sh
   ```

3. Log out and log back in to see all changes.

## License

The install scripts in this repository are released under the MIT License. The themes themselves are licensed under their respective licenses (GPL-3.0 or MIT) by their original authors.

## Credits

All themes in this collection are created by the open-source community. Primary theme authors include **Vince Liuice** ([vinceliuice](https://github.com/vinceliuice)) and **Flavor (B00merang Project)** ([ArtBIT](https://github.com/ArtBIT)).
