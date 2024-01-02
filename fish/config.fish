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

# catpuccin
# set -Ux FZF_DEFAULT_OPTS "\
# --color=spinner:#f5e0dc,hl:#f38ba8 \
# --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
# --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# rose-pine
set -Ux FZF_DEFAULT_OPTS "
--color=fg:#908caa,hl:#ea9a97
--color=fg+:#e0def4,hl+:#ea9a97
--color=border:#44415a,header:#3e8fb0,gutter:#232136
--color=spinner:#f6c177,info:#9ccfd8
--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"
