if status is-interactive
    # Commands to run in interactive sessions can go here
end

# ls alliases
alias la="eza --icons --all"
alias ll="eza --icons --all --long"
alias lt="eza --icons -all -T"

# z jump
zoxide init fish | source

# interface
starship init fish | source

# editor
set -gx EDITOR nvim

# fzf
set -Ux FZF_DEFAULT_OPTS "\
--color=spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
