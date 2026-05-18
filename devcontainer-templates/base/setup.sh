#!/bin/bash
set -e

# eza
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list > /dev/null
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt-get update -qq
sudo apt-get install -y eza bat

# zsh plugins — installed to ~/.zsh/, sourced directly (no oh-my-zsh)
mkdir -p "$HOME/.zsh"
git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions "$HOME/.zsh/zsh-autosuggestions"
git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting "$HOME/.zsh/zsh-syntax-highlighting"

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
"$HOME/.fzf/install" --all --no-bash --no-fish

# Deploy configs (same canonical files used by Codespaces install.sh)
cp .devcontainer/.zshrc "$HOME/.zshrc"
mkdir -p "$HOME/.config"
cp .devcontainer/starship.toml "$HOME/.config/starship.toml"
