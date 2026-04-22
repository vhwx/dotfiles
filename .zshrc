# Path to oh-my-zsh installation
export ZSH="${HOME}/.oh-my-zsh"

# No theme — Starship handles the prompt
ZSH_THEME=""

# Plugins
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# Locale
export LANG=en_US.UTF-8

# Timezone
TZ='Europe/Oslo'
export TZ

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

# fzf key bindings and fuzzy completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Starship prompt
eval "$(starship init zsh)"
