# ~/.bashrc
# Author: Darian Moody
# License: 2-clause BSD

# If not running interactively, don't do anything.
[[ $- != *i* ]] && return

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.exports can be used for global env vars.
for file in ~/.{path,bash_aliases,bash_functions,bash_prompt,cloud_credentials,exports}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
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

PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin
PATH=$PATH:~/bin
PATH=$PATH:/usr/local/go/bin
PATH=$PATH:/usr/local/terraform
export PATH=$PATH

# Python
VIRTUALENV_WRAPPER='/usr/local/bin/virtualenvwrapper.sh'
if [ -f $VIRTUALENV_WRAPPER ]
then
    source $VIRTUALENV_WRAPPER
fi

# Ruby & RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

RVM_DIR="$HOME/.rvm"
if [ -f $RVM_DIR ]
then
    export PATH="$PATH:$HOME/.rvm/bin"
fi


# Go
export GOPATH=$HOME/src/golang
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# Google App Engine SDK
APPENGINE_SDK='/usr/local/google_appengine/'
if [ -f $APPENGINE_SDK ]
then
    export PYTHONPATH="$APPENGINE_SDK:$PYTHONPATH"
fi

# Heroku Toolbelt
HEROKU_TOOLBELT='/usr/local/heroku/bin'
if [ -f $HEROKU_TOOLBELT ]
then
    export PATH="$HEROKU_TOOLBELT:$PATH"
fi

# Node
[[ -s /Users/djm/.nvm/nvm.sh ]] && . /Users/djm/.nvm/nvm.sh

# Java
export JAVA_HOME="/usr"

# PHP
alias composer="php /usr/local/bin/composer.phar"

# AWS Auto Scaling Tools
export AWS_AUTO_SCALING_HOME="/usr/local/AutoScaling-1.0.61.6"
export PATH=$PATH:$AWS_AUTO_SCALING_HOME/bin
export AWS_CREDENTIAL_FILE="$HOME/.aws-credential-file"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
