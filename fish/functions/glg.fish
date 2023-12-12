# git log
function glg
  git lg \
  | fzf --ansi \
        --preview "git show --color=always (echo {} \
                                            | awk '{print \$2}') \
                                            | delta"
end
