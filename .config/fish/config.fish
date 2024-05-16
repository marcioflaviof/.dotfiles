if status is-interactive
    # Commands to run in interactive sessions can go here
end

source ~/.asdf/asdf.fish


starship init fish | source

# zoxide

if ! builtin functions --query __zoxide_cd_internal
    if builtin functions --query cd
        builtin functions --copy cd __zoxide_cd_internal
    else
        alias __zoxide_cd_internal='builtin cd'
    end
end

alias gs='git status'
alias ls="exa --icons"
alias bat="bat --style=auto"
alias icat="kitty +kitten icat"
alias g="git"
alias la="exa -la --icons"
alias gc="git checkout"
alias dc="docker compose"
alias r="rails"
alias cd="z"

export PATH=/home/mf/.local/bin:/home/mf/.asdf/shims:/home/mf/.asdf/bin:/home/mf/.local/bin:/usr/local/bin:/usr/bin:/var/lib/snapd/snap/bin:/usr/local/sbin:/usr/bin/core_perl:/snap/bin:/usr/sbin:/sbin:/home/mf/.local/share/bob/nvim-bin

export EDITOR="/usr/bin/nvim"
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH


# pnpm
set -gx PNPM_HOME "/home/mf/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

zoxide init fish | source
