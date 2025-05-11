# Path configuration
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$HOME/.local/share/fnm:$PATH:/usr/bin:/usr/sbin"
export ZSH="$HOME/.oh-my-zsh"
export TERM="xterm-256color"
export COLORTERM="truecolor"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"


# Oh My Zsh configuration
ZSH_THEME="robbyrussell"
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 14

# Oh My Zsh plugins
plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-completions
  extract
  fzf
)

# Plugin installation and management
install_plugin() {
  local plugin_name="$1"
  local git_url="$2"
  local plugin_dir="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/$plugin_name"
  
  # Install if missing or force reinstall
  if [ ! -d "$plugin_dir" ] || [ "$3" = "force" ]; then
    [ -d "$plugin_dir" ] && rm -rf "$plugin_dir" # Remove if forcing reinstall
    echo "Installing $plugin_name..."
    git clone "$git_url" "$plugin_dir"
    return $?
  fi
  return 0
}

ensure_plugins_installed() {
  local missing_plugins=false
  
  # Plugin definitions
  local plugin_list=(
    "zsh-autosuggestions|https://github.com/zsh-users/zsh-autosuggestions"
    "zsh-syntax-highlighting|https://github.com/zsh-users/zsh-syntax-highlighting" 
    "zsh-completions|https://github.com/zsh-users/zsh-completions"
  )
  
  # Check and install missing plugins
  for plugin_info in "${plugin_list[@]}"; do
    local plugin_name="${plugin_info%%|*}"
    local plugin_url="${plugin_info##*|}"
    local plugin_dir="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/$plugin_name"
    
    if [ ! -d "$plugin_dir" ]; then
      missing_plugins=true
      install_plugin "$plugin_name" "$plugin_url"
    fi
  done
  
  return $missing_plugins
}

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

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
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

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

# fnm for Node.js version management
command -v fnm &> /dev/null && eval "$(fnm env --use-on-cd --shell zsh)"

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

# fzf configuration
if command -v fzf &> /dev/null; then
  # Load fzf if not loaded by plugin
  ! typeset -f fzf-history-widget > /dev/null && [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
  
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
alias update='pacman -Syu && yay -Syu'
alias zshreload='source ~/.zshrc'
alias zshconfig='${EDITOR:-nvim} ~/.zshrc'
alias updateomz='omz update && update_custom_plugins'
alias fixplugins='ensure_plugins_installed'

# Custom functions
# Process management
killp() {
  local pid=$(ps aux | grep "$1" | grep -v grep | awk '{print $2}')
  if [ -n "$pid" ]; then
    echo "Killing processes: $pid"
    echo "$pid" | xargs kill -9
  else
    echo "No process matching '$1' found"
  fi
}

# Git utilities
gdiff() {
  command -v git &> /dev/null || { echo "git is not installed"; return 1; }
  command -v fzf &> /dev/null || { echo "fzf is not installed"; return 1; }
  
  git rev-parse --is-inside-work-tree &> /dev/null || { echo "Not in a git repository"; return 1; }
  
  git diff --name-only | fzf --preview 'git diff --color=always {}'
}

# Plugin updates
update_custom_plugins() {
  echo "Updating custom plugins..."
  
  local plugins=(
    "zsh-autosuggestions|https://github.com/zsh-users/zsh-autosuggestions"
    "zsh-syntax-highlighting|https://github.com/zsh-users/zsh-syntax-highlighting"
    "zsh-completions|https://github.com/zsh-users/zsh-completions"
  )
  
  for plugin_info in "${plugins[@]}"; do
    local plugin_name="${plugin_info%%|*}"
    local plugin_url="${plugin_info##*|}"
    local plugin_dir="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/$plugin_name"
    
    if [ -d "$plugin_dir" ]; then
      echo "Updating $plugin_name..."
      (cd "$plugin_dir" && git pull)
    else
      echo "Plugin '$plugin_name' is missing. Installing..."
      install_plugin "$plugin_name" "$plugin_url"
    fi
  done
  
  echo "Custom plugins update completed."
}
# Add keys to ssh-agent
if [ -n "$SSH_AUTH_SOCK" ]; then
    ssh-add ~/.ssh/arch 2>/dev/null  
fi

if uwsm check may-start; then
    exec uwsm start hyprland.desktop
fi


if [ -f ~/.env.local ]; then
  source ~/.config/.env.local
fi
