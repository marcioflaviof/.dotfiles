if status is-interactive
  # Commands to run in interactive sessions can go here
  starship init fish | source

  alias g="git"
  alias gs='git status '
  alias ga='git add '
  alias gb='git branch '
  alias gc='git commit'
  alias gd='git diff'
  alias gco='git checkout'

  alias ls="eza --icons"
  alias bat="bat --style=auto"
  alias la="eza -la --icons"
  alias dc="docker compose"
  alias r="rails"

  alias ber="bundle exec rails "
  alias be="bundle exec "

  bind ctrl-t 'tmux-sessionizer'

  set -gx EDITOR "nvim"

  set -gx PATH $HOME/.local/scripts \
    $HOME/.local/bin \
    $HOME/.local/share/bob/nvim-bin \
    /usr/local/bin \
    /usr/bin \
    /usr/local/sbin \
    /usr/sbin \
    /sbin \
    /usr/bin/core_perl \
    /var/lib/snapd/snap/bin \
    /snap/bin \
    $PATH


  zoxide init fish | source

  ~/.local/bin/mise activate fish | source

  direnv hook fish | source
end
