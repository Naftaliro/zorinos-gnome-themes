# zorinos gnome themes

install scripts for 9 gnome themes, all set up for dark mode with a purple accent. made for zorin os 18 pro, ubuntu 24.04+ and other `apt` based distros.

the scripts don't include any theme files. each one installs the dependencies, clones the theme from its official repo (pinned to a tag or commit), runs the theme's own installer with the right flags, and then sets everything with `gsettings`.

if you want to switch between them without running scripts by hand, use [gnome-theme-switcher](https://github.com/Naftaliro/gnome-theme-switcher).

## the themes

| # | theme | what you get | script |
|---|---|---|---|
| 1 | **WhiteSur** (macOS Big Sur) | gtk, shell, gdm, icons, cursors, wallpapers, firefox | [whitesur-macos-theme-install.sh](macos-themes/whitesur-macos-theme-install.sh) |
| 2 | **Colloid** (material) | gtk, shell, icons, cursors, libadwaita | [colloid-material-theme-install.sh](macos-themes/colloid-material-theme-install.sh) |
| 3 | **Fluent** (windows 11) | gtk, shell, icons, cursors, libadwaita | [fluent-win11-theme-install.sh](windows-themes/fluent-win11-theme-install.sh) |
| 4 | **Win11** | gtk, shell, icons, cursors, libadwaita | [win11-theme-install.sh](windows-themes/win11-theme-install.sh) |
| 5 | **We10X** (windows 10) | gtk, shell, icons, cursors, libadwaita | [we10x-win10-theme-install.sh](windows-themes/we10x-win10-theme-install.sh) |
| 6 | **Orchis** (material) | gtk, shell, tela icons, graphite cursors | [orchis-theme-install.sh](linux-native-themes/orchis-theme-install.sh) |
| 7 | **Graphite** (minimal dark) | gtk, shell, gdm, tela icons, graphite cursors | [graphite-theme-install.sh](linux-native-themes/graphite-theme-install.sh) |
| 8 | **Lavanda** (purple) | gtk, shell, tela icons, graphite cursors | [lavanda-theme-install.sh](linux-native-themes/lavanda-theme-install.sh) |
| 9 | **Catppuccin** (mocha) | gtk, shell, catppuccin icons + cursors | [catppuccin-theme-install.sh](linux-native-themes/catppuccin-theme-install.sh) |

## installing one

these run with `sudo` and change system settings, so read the script first. download it, check it against [SHA256SUMS.txt](SHA256SUMS.txt), read it, then run it:

```bash
curl -fsSL https://raw.githubusercontent.com/Naftaliro/zorinos-gnome-themes/v1.3.0/macos-themes/whitesur-macos-theme-install.sh -o whitesur-install.sh
sha256sum whitesur-install.sh
less whitesur-install.sh
chmod +x whitesur-install.sh && ./whitesur-install.sh
```

or if you trust it, one line:

```bash
curl -fsSL https://raw.githubusercontent.com/Naftaliro/zorinos-gnome-themes/v1.3.0/macos-themes/whitesur-macos-theme-install.sh | bash
```

swap the path for any script in the table. log out and back in afterwards so the shell and login screen pick it up.

want a different accent or no gdm theme? download the script and change the variables in the configuration section at the top before running it.

## compatibility

- zorin os 18 pro, ubuntu 24.04+, linux mint 22+, pop!_os 24.04+
- gnome 42 to 46 (tested on 45 and 46, shell themes can break on other versions)
- needs `apt`

## credits

all the actual themes are other people's work, go star them:

| author | themes | license |
|---|---|---|
| [vinceliuice](https://github.com/vinceliuice) | WhiteSur, Colloid, Fluent, Orchis, Graphite, Lavanda, Tela icons, Graphite cursors | GPL-3.0 / MIT |
| [yeyushengfan258](https://github.com/yeyushengfan258) | Win11, We10X | GPL-3.0 |
| [Fausto-Korpsvart](https://github.com/Fausto-Korpsvart) | Catppuccin GTK theme | GPL-3.0 |
| [catppuccin](https://github.com/catppuccin) | Catppuccin cursors | GPL-2.0 |

more detail in [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).

## license and stuff

the scripts are MIT ([LICENSE](LICENSE)). that only covers the scripts, the themes keep their own licenses.

this isn't affiliated with zorin group, gnome, canonical, apple, microsoft, or any of the theme authors. the names are only used to say what it works with and what it looks like. no warranty, use at your own risk, see [DISCLAIMER.md](DISCLAIMER.md).
