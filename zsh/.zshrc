# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY INC_APPEND_HISTORY

# Options
setopt AUTO_CD CORRECT GLOB_COMPLETE_WORD

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# Aliases
alias vim="nvim"
alias ll="ls -lah"
alias gs="git status"
alias gd="git diff"
alias gl="git log --oneline --graph --decorate -20"
alias ..="cd .."
alias ...="cd ../.."

# Prompt
eval "$(starship init zsh)"

# Local overrides (machine-specific, gitignored)
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
