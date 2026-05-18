# ~/.zshrc — Zsh config for GitHub Codespaces
# No oh-my-zsh. Starship handles the prompt.

# -- 1) PATH ------------------------------------------------------------------
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/bin:$PATH"
export PATH="$PATH:$HOME/dev/scripts"

# -- 2) History ---------------------------------------------------------------
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS SHARE_HISTORY INC_APPEND_HISTORY

# -- 3) Shell options ---------------------------------------------------------
setopt AUTO_CD
setopt NO_BEEP
setopt EXTENDED_GLOB

# -- 4) Completion ------------------------------------------------------------
autoload -Uz compinit
compinit -C >/dev/null 2>&1 || true

# -- 5) Prompt (Starship with a sane fallback) --------------------------------
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
else
  PS1="%F{%(#.red.green)}%n@%m%f:%F{blue}%~%f%(#.#.$) "
fi

# -- 6) Plugins ---------------------------------------------------------------
# zsh-autosuggestions — checks ~/.zsh/ (install.sh) then system apt paths
for _f in \
  "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" \
  /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
  /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh; do
  [[ -r "$_f" ]] && { source "$_f"; break; }
done; unset _f

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"

# zsh-syntax-highlighting — must be sourced last
for _f in \
  "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
  /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
  /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh; do
  [[ -r "$_f" ]] && { source "$_f"; break; }
done; unset _f

# -- 7) Optional tools --------------------------------------------------------
# fzf
[[ -f "$HOME/.fzf.zsh" ]] && source "$HOME/.fzf.zsh"
[[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[[ -f /usr/share/doc/fzf/examples/completion.zsh   ]] && source /usr/share/doc/fzf/examples/completion.zsh

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# -- 8) Environment -----------------------------------------------------------
export LANG=en_US.UTF-8
export TZ=Europe/Oslo

# -- 9) Aliases ---------------------------------------------------------------
# Git
alias gs='git status'
alias gp='git pull'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate -20'

# eza — modern ls replacement with icons (Hack Nerd Font required)
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first --color=auto --icons'
  alias ll='eza --long --all --group --group-directories-first --git --icons'
  alias la='eza --long --all --group --group-directories-first --icons'
  alias tree='eza --tree --group-directories-first'
else
  alias ls='ls --color=auto'
  alias ll='ls -lah --color=auto'
  alias la='ls -lah --color=auto'
fi

# bat / batcat — cat with syntax highlighting
# Ubuntu <24.04 ships the binary as 'batcat'; a ~/.local/bin/bat symlink is conventional.
if command -v bat >/dev/null 2>&1; then
  alias cat='bat --pager=never'
elif command -v batcat >/dev/null 2>&1; then
  alias bat='batcat'
  alias cat='batcat --pager=never'
fi

# Misc quality-of-life
alias ..='cd ..'
alias ...='cd ../..'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -pv'
alias df='df -h'
alias du='du -sh'
alias ports='ss -tulnp'
alias path='echo $PATH | tr ":" "\n"'

# -- 10) Shell widgets --------------------------------------------------------
autoload -Uz add-zsh-hook

# sudo: double-tap ESC to toggle sudo prefix on the current command
_sudo_command_line() {
  [[ -z "$BUFFER" ]] && zle up-history
  if [[ "$BUFFER" == sudo\ * ]]; then
    BUFFER="${BUFFER#sudo }"
  else
    BUFFER="sudo $BUFFER"
    (( CURSOR += 5 ))
  fi
}
zle -N _sudo_command_line
bindkey '\e\e' _sudo_command_line

# dirhistory: Alt+Left / Alt+Right to navigate directory history
typeset -ga DIRHISTORY_STACK=("$PWD")
typeset -gi DIRHISTORY_INDEX=1

_dirhistory_push() {
  if [[ "${DIRHISTORY_STACK[$DIRHISTORY_INDEX]}" != "$PWD" ]]; then
    DIRHISTORY_STACK=("${DIRHISTORY_STACK[1,$DIRHISTORY_INDEX]}" "$PWD")
    (( DIRHISTORY_INDEX = ${#DIRHISTORY_STACK} ))
  fi
}
add-zsh-hook chpwd _dirhistory_push

_dirhistory_back() {
  if (( DIRHISTORY_INDEX > 1 )); then
    (( DIRHISTORY_INDEX-- ))
    builtin cd -- "${DIRHISTORY_STACK[$DIRHISTORY_INDEX]}" 2>/dev/null
    zle reset-prompt
  fi
}
zle -N _dirhistory_back
bindkey '^[[1;3D' _dirhistory_back    # Alt+Left

_dirhistory_forward() {
  if (( DIRHISTORY_INDEX < ${#DIRHISTORY_STACK} )); then
    (( DIRHISTORY_INDEX++ ))
    builtin cd -- "${DIRHISTORY_STACK[$DIRHISTORY_INDEX]}" 2>/dev/null
    zle reset-prompt
  fi
}
zle -N _dirhistory_forward
bindkey '^[[1;3C' _dirhistory_forward  # Alt+Right

# -- 11) Key bindings ---------------------------------------------------------
bindkey -e                        # emacs key bindings (Ctrl-A, Ctrl-E, etc.)
bindkey "^[[1;5C" forward-word    # Ctrl+Right
bindkey "^[[1;5D" backward-word   # Ctrl+Left
bindkey "^[[3~"   delete-char     # Delete key
