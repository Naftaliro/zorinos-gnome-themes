# ZorinOS / Ubuntu GNOME Theme Collection

> A collection of automated installation scripts for popular GNOME themes, pre-configured for a dark mode + purple accent setup.

This repository provides a set of **9 installation scripts** for popular system-wide GNOME themes. It is designed for ZorinOS 18 Pro, Ubuntu 24.04+, and other `apt`-based Linux distributions. The scripts handle everything from installing dependencies to applying the theme, making it easy to transform your desktop.

---

### Important Disclaimers

**No Affiliation.** This is an unofficial, community-driven project. It is **not affiliated with, endorsed by, or sponsored by** ZorinOS, GNOME, Zorin Group, Canonical, Apple, Microsoft, or any of the upstream theme authors.

**Use at Your Own Risk.** These scripts modify system settings and run with `sudo` privileges. You assume all responsibility for any changes to your system. **Please review the scripts before running them.**

**AI-Assisted.** The scripts and documentation were created with the significant assistance of AI and are provided "as is" without warranty of any kind.

**Original Work.** The scripts in this repository are original automation wrappers. They do not contain any code copied or adapted from the upstream theme repositories. They merely invoke the upstream projects' own install scripts with pre-configured flags.

> For full details, please read the **[DISCLAIMER.md](DISCLAIMER.md)** and **[LICENSE](LICENSE)** files.

---

### Trademarks

"ZorinOS" is a trademark of Zorin Group. "GNOME" is a trademark of The GNOME Foundation. "macOS" and "Apple" are trademarks of Apple Inc. "Windows" and "Microsoft" are trademarks of Microsoft Corporation. "Ubuntu" is a trademark of Canonical Ltd. All other product names, logos, and brands are the property of their respective owners. These names are used in this repository solely to describe compatibility and visual inspiration, and their use does not imply any affiliation or endorsement.

---

## Theme Switcher TUI

Tired of running scripts one at a time? Install the **[GNOME Theme Switcher](https://github.com/Naftaliro/gnome-theme-switcher)** — a terminal-based UI that lets you browse, install, and switch between all 9 themes (plus your own custom themes) with a single keypress.

---

## Security Notice

These scripts download and execute code from upstream GitHub repositories. While the upstream projects are well-known and widely used, you should always **review scripts before running them**. The recommended approach is:

```bash
# Step 1: Download the script
curl -fsSL https://raw.githubusercontent.com/Naftaliro/zorinos-gnome-themes/v1.2.0/macos-themes/whitesur-macos-theme-install.sh -o whitesur-install.sh

# Step 2: Verify the checksum (compare against SHA256SUMS.txt in this repo)
sha256sum whitesur-install.sh

# Step 3: Review the script
less whitesur-install.sh

# Step 4: Run it
chmod +x whitesur-install.sh && ./whitesur-install.sh
```

SHA-256 checksums for all scripts are published in the **[SHA256SUMS.txt](SHA256SUMS.txt)** file and in each GitHub Release.

---

## Theme Collection (9 Themes)

All themes are installed from their official upstream repositories at runtime. The install scripts in this repo are MIT-licensed, but the themes themselves are governed by their original licenses (GPL-3.0, GPL-2.0, or MIT).

### macOS Themes

| # | Theme | Script | Guide |
|---|---|---|---|
| 1 | **WhiteSur** — macOS Big Sur (GTK, Shell, GDM, Icons, Cursors, Wallpapers, Firefox) | [whitesur-macos-theme-install.sh](macos-themes/whitesur-macos-theme-install.sh) | [Guide](macos-themes/whitesur-macos-theme-guide.md) |
| 2 | **Colloid** — Material Design (GTK, Shell, Icons, Cursors, Libadwaita) | [colloid-material-theme-install.sh](macos-themes/colloid-material-theme-install.sh) | [Guide](macos-themes/colloid-material-theme-guide.md) |

### Windows Themes

| # | Theme | Script | Guide |
|---|---|---|---|
| 3 | **Fluent** — Windows 11 Fluent Design (GTK, Shell, Icons, Cursors, Libadwaita) | [fluent-win11-theme-install.sh](windows-themes/fluent-win11-theme-install.sh) | [Guide](windows-themes/fluent-win11-theme-guide.md) |
| 4 | **Win11** — Windows 11 by yeyushengfan258 (GTK, Shell, Icons, Cursors, Libadwaita) | [win11-theme-install.sh](windows-themes/win11-theme-install.sh) | [Guide](windows-themes/win11-theme-guide.md) |
| 5 | **We10X** — Windows 10 by yeyushengfan258 (GTK, Shell, Icons, Cursors, Libadwaita) | [we10x-win10-theme-install.sh](windows-themes/we10x-win10-theme-install.sh) | [Guide](windows-themes/we10x-win10-theme-guide.md) |

### Linux-Native Themes

| # | Theme | Script | Guide |
|---|---|---|---|
| 6 | **Orchis** — Material Design (GTK, Shell, Tela Icons, Graphite Cursors) | [orchis-theme-install.sh](linux-native-themes/orchis-theme-install.sh) | [Guide](linux-native-themes/orchis-theme-guide.md) |
| 7 | **Graphite** — Minimalist Dark + GDM (GTK, Shell, GDM, Tela Icons, Graphite Cursors) | [graphite-theme-install.sh](linux-native-themes/graphite-theme-install.sh) | [Guide](linux-native-themes/graphite-theme-guide.md) |
| 8 | **Lavanda** — Purple-native elegance (GTK, Shell, Tela Icons, Graphite Cursors) | [lavanda-theme-install.sh](linux-native-themes/lavanda-theme-install.sh) | [Guide](linux-native-themes/lavanda-theme-guide.md) |
| 9 | **Catppuccin** — Soothing pastel dark Mocha (GTK, Shell, Catppuccin Icons + Cursors) | [catppuccin-theme-install.sh](linux-native-themes/catppuccin-theme-install.sh) | [Guide](linux-native-themes/catppuccin-theme-guide.md) |

---

## Quick Install (One-Liner)

For convenience, each script can also be run directly. **By using this method, you are trusting the code at the current HEAD of this repository and the upstream theme repos.** If you prefer a safer approach, use the download-inspect-run method described in the Security Notice above.

```bash
# Example: WhiteSur macOS theme
curl -fsSL https://raw.githubusercontent.com/Naftaliro/zorinos-gnome-themes/v1.2.0/macos-themes/whitesur-macos-theme-install.sh | bash
```

Replace the path with any script from the table above. All URLs use the pinned `v1.2.0` release tag for reproducibility.

---

## Compatibility

| Field | Value |
|---|---|
| **Target OS** | ZorinOS 18 Pro, Ubuntu 24.04+, Linux Mint 22+, Pop!_OS 24.04+ |
| **Desktop** | GNOME 42 through 46 |
| **Package Manager** | `apt` (Debian/Ubuntu family) |

> **Warning:** GNOME Shell themes can break between major GNOME versions. These scripts are tested on GNOME 45/46. Visual glitches may occur on other versions.

## How It Works

The scripts in this repository do **not** contain any theme files or upstream source code. They are original automation wrappers that perform the following steps:

1. Install required system dependencies (e.g., `git`, `sassc`, `gnome-tweaks`).
2. Clone the official upstream theme repository from GitHub.
3. Run the theme's own `install.sh` script with pre-configured flags (e.g., for dark mode, purple accent, GDM theme).
4. Apply the theme by setting the appropriate `gsettings` keys.

## Credits and Licensing

This repository is licensed under the **MIT License**. See [LICENSE](LICENSE) for details. The MIT license applies **only to the installation scripts and documentation in this repository**, not to the themes they install.

The themes themselves are the work of the open-source community and are governed by their respective licenses. All credit goes to the original authors.

| Author | Themes | GitHub | License |
|---|---|---|---|
| **Vince Liuice** | WhiteSur, Colloid, Fluent, Orchis, Graphite, Lavanda, Tela Icons, Graphite Cursors | [vinceliuice](https://github.com/vinceliuice) | GPL-3.0 / MIT |
| **yeyushengfan258** | Win11, We10X | [yeyushengfan258](https://github.com/yeyushengfan258) | GPL-3.0 |
| **Fausto-Korpsvart** | Catppuccin GTK Theme | [Fausto-Korpsvart](https://github.com/Fausto-Korpsvart) | GPL-3.0 |
| **Catppuccin** | Catppuccin Cursors | [catppuccin](https://github.com/catppuccin) | GPL-2.0 |
