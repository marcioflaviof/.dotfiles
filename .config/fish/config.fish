if status is-interactive
    # Commands to run in interactive sessions can go here
end

source ~/.asdf/asdf.fish

starship init fish | source

alias gs='git status'
alias ls="exa --icons"
alias bat="bat --style=auto"

export PATH=/home/mf/.local/bin:/home/mf/.asdf/shims:/home/mf/.asdf/bin:/home/mf/.local/bin:/usr/local/bin:/usr/bin:/var/lib/snapd/snap/bin:/usr/local/sbin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl

export STACK_DIR="$HOME/Documents/Stack"
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
