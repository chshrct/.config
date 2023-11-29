if status is-interactive
    # Commands to run in interactive sessions can go here
end

# ls alliases
alias ls="exa --icons"
alias la="exa --icons --all"
alias ll="exa --icons --all --long"
alias lt="exa --icons -all -T"

# z jump
zoxide init fish | source

# interface
starship init fish | source

# editor
set -gx EDITOR nvim

# catppuccin theme

# fzf
set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \

--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
