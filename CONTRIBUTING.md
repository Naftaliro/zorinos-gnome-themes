# Contributing

Thank you for your interest in contributing to this project! Whether you want to add a new theme, fix a bug, or improve documentation, contributions are welcome.

## How to Contribute

### Adding a New Theme

1. **Fork** this repository and create a new branch.
2. Create your install script in the appropriate category directory:
   - `macos-themes/` for macOS-inspired themes
   - `windows-themes/` for Windows-inspired themes
   - `linux-native-themes/` for Linux-native themes
3. Create a matching documentation guide (Markdown) in the same directory.
4. Follow the conventions described below.
5. Open a **Pull Request** with a clear description of the theme.

### Script Conventions

All install scripts in this repository follow a consistent structure. Please match these conventions:

- **Shebang and SPDX header:**
  ```bash
  #!/usr/bin/env bash
  # SPDX-License-Identifier: MIT
  # SPDX-FileCopyrightText: <year> <your-name> <your-github-url>
  ```

- **Disclaimer block** referencing `DISCLAIMER.md` and `LICENSE`.

- **Originality notice** confirming the script is an original wrapper, not a copy of upstream code.

- **Upstream project URLs** with license tags in the header, e.g.:
  ```bash
  # Upstream projects invoked by this script:
  #   - Theme Name: https://github.com/author/repo (GPL-3.0)
  ```

- **Configuration section** at the top with editable variables (accent color, dark/light mode, etc.).

- **`set -euo pipefail`** for strict error handling.

- **`trap cleanup EXIT`** to clean up temporary files.

- **Pinned upstream versions** using `--branch <tag>` in `git clone` commands.

- **Color-coded output** using `info()`, `ok()`, `warn()`, `err()`, and `header()` helper functions.

### File Naming

- Scripts: `<theme-name>-theme-install.sh` (kebab-case)
- Guides: `<theme-name>-theme-guide.md` (kebab-case)

### Testing

Before submitting, please verify:

1. `bash -n your-script.sh` passes without errors.
2. [ShellCheck](https://www.shellcheck.net/) reports no errors (warnings are acceptable for intentional patterns).
3. The script installs and applies the theme correctly on a fresh Ubuntu/ZorinOS system.

### Updating THIRD_PARTY_NOTICES.md

If your theme introduces new upstream dependencies, add them to `THIRD_PARTY_NOTICES.md` with the author, repository URL, and license.

## Reporting Bugs

- Open a [GitHub Issue](https://github.com/Naftaliro/zorinos-gnome-themes/issues) with:
  - Your OS and GNOME version
  - The theme script you ran
  - The error output (copy-paste from terminal)
  - Steps to reproduce

## Code of Conduct

Be respectful and constructive. This is a hobby project maintained in spare time. Patience is appreciated.

## License

By contributing, you agree that your contributions will be licensed under the [MIT License](LICENSE).
