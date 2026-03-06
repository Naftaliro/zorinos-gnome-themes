# ZorinOS / Ubuntu GNOME Theme Collection

> A collection of automated installation scripts for popular GNOME themes, pre-configured for a dark mode + purple accent setup.

This repository provides a set of **9 one-liner installation scripts** for popular system-wide GNOME themes. It is designed for ZorinOS 18 Pro, Ubuntu 24.04+, and other `apt`-based Linux distributions. The scripts handle everything from installing dependencies to applying the theme, making it easy to transform your desktop with a single command.

---

### ⚠️ **Important Disclaimers**

*   **No Affiliation:** This is an unofficial, community-driven project. It is **not affiliated with, endorsed by, or sponsored by** ZorinOS, GNOME, or any of the theme authors.
*   **Use at Your Own Risk:** These scripts modify system settings and run with `sudo` privileges. You assume all responsibility for any changes to your system. Please review the scripts before running.
*   **AI-Assisted:** The scripts and documentation were created with the assistance of AI and are provided "as is" without warranty.

> For full details, please read the **[DISCLAIMER.md](DISCLAIMER.md)** file.

---

## Theme Switcher TUI

Tired of running scripts? Install the **[GNOME Theme Switcher](https://github.com/Naftaliro/gnome-theme-switcher)** — a terminal-based UI that lets you browse, install, and switch between all 9 themes (plus your own custom themes) with a single keypress.

```bash
# Install the theme switcher
curl -fsSL https://raw.githubusercontent.com/Naftaliro/gnome-theme-switcher/main/install.sh | bash

# Run it
gnome-theme-switcher
```

## Theme Collection (9 Themes)

All themes are installed from their official upstream repositories at runtime. The install scripts in this repo are MIT licensed, but the themes themselves are governed by their original licenses (GPL-3.0, GPL-2.0, or MIT).

| # | Theme | Category | Upstream License | One-Liner Install |
|---|---|---|---|---|
| 1 | **WhiteSur** | macOS | MIT / GPL-3.0 | `curl -fsSL .../whitesur-macos-theme-install.sh \| bash` |
| 2 | **Colloid** | macOS | GPL-3.0 | `curl -fsSL .../colloid-material-theme-install.sh \| bash` |
| 3 | **Fluent** | Windows | GPL-3.0 | `curl -fsSL .../fluent-win11-theme-install.sh \| bash` |
| 4 | **Win11** | Windows | GPL-3.0 | `curl -fsSL .../win11-theme-install.sh \| bash` |
| 5 | **We10X** | Windows | GPL-3.0 | `curl -fsSL .../we10x-win10-theme-install.sh \| bash` |
| 6 | **Orchis** | Linux-Native | GPL-3.0 | `curl -fsSL .../orchis-theme-install.sh \| bash` |
| 7 | **Graphite** | Linux-Native | GPL-3.0 | `curl -fsSL .../graphite-theme-install.sh \| bash` |
| 8 | **Lavanda** | Linux-Native | GPL-3.0 | `curl -fsSL .../lavanda-theme-install.sh \| bash` |
| 9 | **Catppuccin** | Linux-Native | GPL-3.0 / GPL-2.0 | `curl -fsSL .../catppuccin-theme-install.sh \| bash` |

> **Note:** The full `curl` URLs can be found in the `guides/` directory for each theme.

## Compatibility

| Field | Value |
|---|---|
| **Target OS** | ZorinOS 18 Pro, Ubuntu 24.04+, Linux Mint 22+, Pop!_OS 24.04+ |
| **Desktop** | GNOME (42-46) |
| **Package Manager** | `apt` (Debian/Ubuntu family) |

> **Warning:** GNOME Shell themes can break between major versions. These scripts are tested on GNOME 45/46. Visual glitches may occur on other versions.

## How It Works

The scripts in this repository do **not** contain any theme files. They are automated installers that perform the following steps:

1.  Install required dependencies (e.g., `git`, `sassc`, `gnome-tweaks`).
2.  Clone the official upstream theme repository from GitHub.
3.  Run the theme’s own `install.sh` script with pre-configured flags (e.g., for dark mode, purple accent, GDM theme).
4.  Apply the theme by setting the appropriate `gsettings` keys.

## Credits and Licensing

This repository is licensed under the **MIT License**. See [LICENSE](LICENSE) for details.

The themes themselves are the work of the open-source community and are governed by their respective licenses.

| Author | Themes | GitHub | License |
|---|---|---|---|
| **Vince Liuice** | WhiteSur, Colloid, Fluent, Orchis, Graphite, Lavanda, Tela Icons | [vinceliuice](https://github.com/vinceliuice) | GPL-3.0 / MIT |
| **yeyushengfan258** | Win11, We10X | [yeyushengfan258](https://github.com/yeyushengfan258) | GPL-3.0 |
| **Fausto-Korpsvart** | Catppuccin GTK Theme | [Fausto-Korpsvart](https://github.com/Fausto-Korpsvart) | GPL-3.0 |
| **Catppuccin** | Catppuccin Cursors | [catppuccin](https://github.com/catppuccin) | GPL-2.0 |

