# ~/.bashrc
# Author: Darian Moody
# License: 2-clause BSD

# If not running interactively, don't do anything.
[[ $- != *i* ]] && return

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.exports can be used for global env vars.
for file in ~/.{path,bash_aliases,bash_functions,bash_prompt,cloud_credentials,exports}; do
	source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
    source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

####################

# Python
eval "$(pyenv init -)"

# Ruby & RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Google App Engine SDK
APPENGINE_SDK='/usr/local/google_appengine/'
if [ -f $APPENGINE_SDK ]
then
    export PYTHONPATH="$APPENGINE_SDK:$PYTHONPATH"
fi

# Node
[[ -s /Users/djm/.nvm/nvm.sh ]] && . /Users/djm/.nvm/nvm.sh

# Java
export JAVA_HOME="/usr"

# Rust
[[ -s $HOME/.cargo/env ]] && . $HOME/.cargo/env && export PATH="$HOME/.cargo/bin:$PATH"

# PHP
alias composer="php /usr/local/bin/composer.phar"

# AWS
export AWS_CREDENTIAL_FILE="$HOME/.aws-credential-file"

# direnv
eval "$(direnv hook bash)"

# Travis
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# gpg
export GPG_TTY=$(tty)
