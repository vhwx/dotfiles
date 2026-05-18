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
- Zsh plugins (`zsh-autosuggestions`, `zsh-syntax-highlighting`) are cloned to `~/.zsh/` and sourced directly — no oh-my-zsh. The `.zshrc` uses a multi-path fallback loop so it also works if plugins are installed system-wide via `apt`.
- The `bat` binary is `batcat` on Ubuntu <24.04. The `.zshrc` handles both gracefully; do not hardcode either name.
- `eza` replaced the deprecated `exa`; do not reintroduce `exa`.
- The `zshrc()` function in `install.sh` groups all ZSH-related setup (plugin cloning, Starship install, config copying). New ZSH-related setup belongs there.
- Timezone is always **Europe/Oslo**.
- `devcontainer-templates/base/.zshrc` and `devcontainer-templates/base/starship.toml` are copies of the root-level canonical files. Keep them in sync when either is changed.
