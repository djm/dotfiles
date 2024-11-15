zmodload zsh/zprof

source "${HOME}/.zplug/init.zsh"

# plugins
zplug zsh-users/zsh-autosuggestions
zplug zsh-users/zsh-syntax-highlighting
zplug zsh-users/zsh-completions
zplug zsh-users/zsh-history-substring-search

# theme
zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 

autoload -Uz compinit

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
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# Direnv setup
eval "$(direnv hook zsh)"
export DIRENV_LOG_FORMAT=

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
