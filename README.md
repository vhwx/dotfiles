# dotfiles

🚀 Dotfiles for a standardized Zsh environment in [GitHub Codespaces](https://github.com/features/codespaces).

## What it installs

| Tool | Purpose |
|------|---------|
| [Starship](https://starship.rs) | Fast, cross-shell prompt |
| [oh-my-zsh](https://ohmyz.sh) | Zsh plugin management |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | Fish-style command suggestions |
| [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | Syntax colouring in the shell |
| [eza](https://github.com/eza-community/eza) | Modern `ls` replacement with icons |
| [bat](https://github.com/sharkdp/bat) | `cat` with syntax highlighting |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder — Ctrl+R history search |
| [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/) | Azure tooling |
| [Hack Nerd Font](https://github.com/ryanoasis/nerd-fonts) | Font with icon glyphs for Starship |

Timezone is set to **Europe/Oslo**.

## Usage

Codespaces picks up this repo automatically when set as your dotfiles repository in [GitHub Settings → Codespaces](https://github.com/settings/codespaces). The entrypoint is `install.sh`.

## Files

| File | Purpose |
|------|---------|
| `install.sh` | Entrypoint — installs tools, copies configs |
| `.zshrc` | Zsh configuration |
| `starship.toml` | Starship prompt configuration |
| `settings.json` | VS Code extension recommendations |
| `push.sh` | Utility script copied to `~/dev/scripts/` |
