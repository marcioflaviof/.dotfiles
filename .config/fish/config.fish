if status is-interactive
    # Commands to run in interactive sessions can go here
end

source ~/.asdf/asdf.fish

starship init fish | source


alias gs='git status'
alias ls="eza --icons"
alias bat="bat --style=auto"
alias icat="kitty +kitten icat"
alias g="git"
alias la="eza -la --icons"
alias gc="git checkout"
alias dc="docker compose"
alias r="rails"


export PATH=/home/mf/.local/bin:/home/mf/.asdf/shims:/home/mf/.asdf/bin:/home/mf/.local/bin:/usr/local/bin:/usr/bin:/var/lib/snapd/snap/bin:/usr/local/sbin:/usr/bin/core_perl:/snap/bin:/usr/sbin:/sbin:/home/mf/.local/share/bob/nvim-bin

export EDITOR="/home/mf/.local/share/bob/nvim-bin/nvim"
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH


zoxide init fish | source
