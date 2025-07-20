bindkey -e

# Path configuration
export PATH="$HOME/.volta/bin:$HOME/yunga:$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH:/usr/bin:/usr/sbin"
export ZDOTDIR="$HOME/.config/zsh"
export TERM="xterm-256color"
export COLORTERM="truecolor"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export PATH="/home/chshrct/dodocli:$PATH"

# Source sensitive environment variables from external file
if [ -f "$ZDOTDIR/.zsh.env" ]; then
  source "$ZDOTDIR/.zsh.env"
elif [ -f "$HOME/.config/zsh/.zsh.env" ]; then
  source "$HOME/.config/zsh/.zsh.env"
fi

# ------------------------------------------------------------------------------
# Plugin Management with Antidote
# ------------------------------------------------------------------------------

# Clone Antidote if it is not already installed
if [ ! -d "$ZDOTDIR/.antidote" ]; then
    git clone --depth=1 https://github.com/mattmc3/antidote.git "$ZDOTDIR/.antidote"
fi

# Source Antidote
source "$ZDOTDIR/.antidote/antidote.zsh"

# Load plugins from .zsh_plugins.txt
antidote load "$ZDOTDIR/.zsh_plugins.txt"

# ------------------------------------------------------------------------------
# End of Plugin Management
# ------------------------------------------------------------------------------

# Locale settings
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS HIST_SAVE_NO_DUPS HIST_REDUCE_BLANKS
setopt HIST_VERIFY INC_APPEND_HISTORY SHARE_HISTORY EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST

# Shell options
setopt AUTO_CD INTERACTIVE_COMMENTS NO_CASE_GLOB EXTENDED_GLOB
setopt AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT
setopt CORRECT NO_BEEP MULTIOS PROMPT_SUBST

# Completion setup
autoload -Uz compinit
local zcompdump_path="${ZDOTDIR:-$HOME}/.zcompdump"
if [[ ! -f "$zcompdump_path" || "${ZDOTDIR:-$HOME}/.zshrc" -nt "$zcompdump_path" ]]; then
  compinit
else
  compinit -C
fi
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# fzf configuration
if command -v fzf &> /dev/null; then
  # Load fzf's key bindings for standard hotkeys.
  source /usr/share/fzf/key-bindings.zsh

  # fzf-tab plugin handles keybindings and completions.
  # The following options configure fzf's appearance and preview.
  
  # Define preview command
  fzf_preview_cmd='
    if [[ -d {} ]]; then
      command -v eza &> /dev/null && eza --color=always -la --tree --level=2 --group-directories-first --icons --git {} || ls -la --color=always {}
    elif [[ -f {} ]]; then
      command -v bat &> /dev/null && bat --color=always --style=numbers,changes {} || cat {}
    else
      echo ""
    fi
  '

  # FZF options
  # kanagawa-paper-ink theme colors
  # export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --cycle --preview=\"$fzf_preview_cmd\" --preview-window=right:60%:wrap --color=bg:-1,bg+:#2A2A37,fg:-1,fg+:#DCD7BA,hl:#938AA9,hl+:#c4746e --color=header:#b6927b,info:#658594,pointer:#7AA89F --color=marker:#7AA89F,prompt:#c4746e,spinner:#8ea49e"
  export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --cycle --preview=\"$fzf_preview_cmd\" --preview-window=right:60%:wrap --color=bg:-1,bg+:#2A2A37,fg:-1,fg+:#DCD7BA,hl:#957FB8,hl+:#FF5D62 --color=header:#FFA066,info:#658594,pointer:#7AA89F --color=marker:#7AA89F,prompt:#E46876,spinner:#7E9CD8"
  export FZF_CTRL_R_OPTS="--preview-window=hidden"
fi

# Default editor
export EDITOR='nvim'
export VISUAL='nvim'

# Tool initialization
# starship prompt
command -v starship &> /dev/null && eval "$(starship init zsh)"

# zoxide for directory navigation
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
  alias cd='z'
  alias cdi='zi'
  alias zl='zoxide query -l'
  alias zr='zoxide query -i'
  alias za='zoxide add'
fi

# sesh for session management
if command -v sesh &> /dev/null; then
  alias ss='sesh connect $(sesh list | fzf)'
  alias sl='sesh list'
fi

# Modern replacements for standard tools
# eza (ls replacement)
if command -v eza &> /dev/null; then
  alias ls='eza --group-directories-first --icons'
  alias la='eza -a --group-directories-first --icons'
  alias ll='eza -la --group-directories-first --icons --git'
  alias lt='eza --tree --level=2 --group-directories-first --icons'
  alias llt='eza -la --tree --level=2 --group-directories-first --icons --git'
else
  alias ll='ls -la'
  alias la='ls -a'
  alias l='ls -l'
fi

# bat (cat replacement)
if command -v bat &> /dev/null; then
  export BAT_THEME="kanagawa-dragon"
  export BAT_STYLE="numbers,changes,header"
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  alias cat='bat --paging=never'
  alias catp='bat --plain'
  alias cath='bat --plain --color=always | head -n'
fi

# fd (find replacement)
if command -v fd &> /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
  export FZF_ALT_C_COMMAND='fd --type d --strip-cwd-prefix --hidden --follow --exclude .git'
  alias fdf='fd --type f'
  alias fdd='fd --type d'
fi

# ripgrep (grep replacement)
if command -v rg &> /dev/null; then
  alias rgi='rg -i'
  alias rgh='rg --hidden'
fi

# Common aliases
# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# System
alias df='df -h'
alias du='du -h'
alias free='free -m'
alias ports='netstat -tulanp'

# Convenience
alias update='pacman -Syu && paru -Syu'
alias zshreload='source ~/.config/zsh/.zshrc'
alias zshconfig='${EDITOR:-nvim} ~/.config/zsh/.zshrc'
alias update-plugins='antidote update'

# Add keys to ssh-agent
if [ -n "$SSH_AUTH_SOCK" ]; then
    ssh-add ~/.ssh/arch 2>/dev/null
fi

if uwsm check may-start; then
    exec uwsm start hyprland.desktop
fi
