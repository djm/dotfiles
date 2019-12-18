source ~/Source/dotfiles/antigen.zsh

antigen use oh-my-zsh

antigen bundle aws
antigen bundle brew
antigen bundle cargo
antigen bundle command-not-found
antigen bundle docker
antigen bundle git
antigen bundle heroku
antigen bundle history-substring-search
antigen bundle npm
antigen bundle nvm
antigen bundle osx
antigen bundle pyenv
antigen bundle python
antigen bundle pip
antigen bundle history-substring-search

antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

# Syntax-highlighting must be last
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply

source ~/.aliases
source ~/.path

# zsh-history-substring-search configuration
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

# nvm setup
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# GPG Setup
export GPG_TTY=$(tty)
