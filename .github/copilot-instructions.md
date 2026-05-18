# Copilot Instructions

## Purpose

This repo provides a standardized Zsh environment for [GitHub Codespaces](https://github.com/features/codespaces). When set as a user's dotfiles repository, Codespaces automatically runs `install.sh` on container creation.

## Architecture

- **`install.sh`** — Entrypoint. Installs system packages via `apt`, clones Zsh plugins, downloads fonts, and copies config files into place. Written in POSIX `sh` (not bash). Targets Debian/Ubuntu (Codespaces default image).
- **`.zshrc`** → copied to `~/.zshrc`
- **`starship.toml`** → copied to `~/.config/starship.toml`
- **`push.sh`** → copied to `~/dev/scripts/push.sh` (utility script on `$PATH` in the Codespace)
- **`settings.json`** — VS Code extension recommendations (consumed by Codespaces, not a standard VS Code `settings.json`)

Config files are **copied**, not symlinked.

## Key Conventions

- `install.sh` uses `#!/bin/sh` — keep it POSIX-compatible; avoid bashisms.
- The binary for `bat` on Debian/Ubuntu is `batcat`, not `bat` — the `.zshrc` alias reflects this (`alias cat="batcat"`).
- `eza` replaced the deprecated `exa`; do not reintroduce `exa`.
- The `zshrc()` function in `install.sh` groups all ZSH-related setup (plugin cloning, Starship install, config copying). New ZSH-related setup belongs there.
- Timezone is always **Europe/Oslo**.
- `ZSH_THEME=""` in `.zshrc` is intentional — Starship handles the prompt entirely.
