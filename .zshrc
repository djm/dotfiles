zmodload zsh/zprof

source "${HOME}/.zgen/zgen.zsh"

# if the init scipt doesn't exist
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    # plugins
    zgen oh-my-zsh plugins/rust
    zgen oh-my-zsh plugins/command-not-found
    zgen oh-my-zsh plugins/docker
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/heroku
    zgen oh-my-zsh plugins/history-substring-search
    zgen oh-my-zsh plugins/npm
    zgen oh-my-zsh plugins/macos
    zgen oh-my-zsh plugins/pyenv
    zgen oh-my-zsh plugins/pip
    zgen oh-my-zsh plugins/sudo

    # syntax highlighting
    zgen load zsh-users/zsh-syntax-highlighting

    # completions
    zgen load zsh-users/zsh-completions src

    # theme
    zgen load sindresorhus/pure

    # save all to init script
    zgen save
fi

source ~/.aliases
source ~/.path

# zsh-history-substring-search configuration
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

# GPG Setup
export GPG_TTY=$(tty)

export PATH="/usr/local/opt/postgresql@11/bin:$PATH"

# Enable Erlang/Elixir shell history
export ERL_AFLAGS="-kernel shell_history enabled"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
