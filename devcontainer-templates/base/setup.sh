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
git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all --no-bash --no-fish

# Configure .zshrc
cat >> ~/.zshrc << 'EOF'

# Locale & timezone
export LANG=en_US.UTF-8
export TZ=Europe/Oslo

# zsh plugins (no oh-my-zsh)
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# fzf key bindings and fuzzy completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# eza aliases (ls replacement with icons)
if [ -x "$(command -v eza)" ]; then
    alias ls="eza --icons"
    alias la="eza --long --all --group --header --group-directories-first --icons --time-style long-iso"
fi
alias tree="eza --tree"
alias cat="batcat"

# PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/dev/scripts"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Starship prompt
eval "$(starship init zsh)"
EOF
