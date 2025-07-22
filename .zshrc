typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

typeset -g POWERLEVEL9K_FOREGROUND='#adadad'
typeset -g POWERLEVEL9K_BACKGROUND='#161616'

typeset -g POWERLEVEL9K_TIME_FOREGROUND='#cf6a4c'         # red
typeset -g POWERLEVEL9K_TIME_BACKGROUND='#1b1b1b'

typeset -g POWERLEVEL9K_CONTEXT_FOREGROUND='#71b9f8'     # cyan
typeset -g POWERLEVEL9K_CONTEXT_BACKGROUND='#1b1b1b'

typeset -g POWERLEVEL9K_DIR_FOREGROUND='#597bc5'         # blue
typeset -g POWERLEVEL9K_DIR_BACKGROUND='#1b1b1b'

typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND='#99ad6a'   # green
typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='#d8ad4c' # yellow
typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='#cf6a4c' # red

typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_FOREGROUND='#99ad6a'
typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_BACKGROUND='#1b1b1b'
typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_FOREGROUND='#cf6a4c'
typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_BACKGROUND='#1b1b1b'

eval "$(oh-my-posh init zsh)"

# Homebrew (Linuxbrew) check on Linux Mint
if [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Zinit setup
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Powerlevel10k
zinit ice depth=1
zinit light romkatv/powerlevel10k

# Additional Zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# OMZ snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Completion
autoload -Uz compinit && compinit
zinit cdreplay -q


# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History settings
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory hist_ignore_space \
       hist_ignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color=auto'
alias vim='nvim'
alias c='clear'

# Shell integrations
command -v fzf >/dev/null && eval "$(fzf --completion=zsh --key-bindings)"
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
