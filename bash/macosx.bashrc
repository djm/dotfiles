#
# ~/.bash_profile
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export LC_CTYPE=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8
export LANG=en_GB.UTF-8
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/System//Library/Frameworks/Python.framework/Versions/2.7/bin:$(brew --prefix coreutils)/libexec/gnubin

export EDITOR=vim

# Aliases
alias ..='cd ..'
alias nano='vim'
alias clearpyc='find . -name "*.pyc" -exec rm -rf {} \;'
alias serve='python -m SimpleHTTPServer'
alias jsonify='python -mjson.tool'
alias tmux='TERM=xterm-256color tmux'
alias v='vagrant'
alias vup='vagrant up'
alias vssh='vagrant ssh'
alias vin='vagrant up && vagrant ssh'
alias vh='vagrant halt'
alias vd='vagrant destroy'
alias vr='vagrant reload'
alias vp='vagrant provision'

HISTSIZE=100000
export CLICOLOR=1

##################################################
# Fancy PWD display function
##################################################
# The home directory (HOME) is replaced with a ~
# The last pwdmaxlen characters of the PWD are displayed
# Leading partial directory names are striped off
# /home/me/stuff          -> ~/stuff               if USER=me
# /usr/share/big_dir_name -> ../share/big_dir_name if pwdmaxlen=20
##################################################
bash_prompt_command() {
    # How many characters of the $PWD should be kept
    local pwdmaxlen=25
    # Indicate that there has been dir truncation
    local trunc_symbol=".."
    local dir=${PWD##*/}
    pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
    NEW_PWD=${PWD/#$HOME/\~}
    local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
    if [ ${pwdoffset} -gt "0" ]
    then
        NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
        NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
    fi
}

bash_prompt() {
    case $TERM in
     xterm*|rxvt*)
         local TITLEBAR='\[\033]0;\h: \W\007\]'
          ;;
     *)
         local TITLEBAR=""
          ;;
    esac
    local NONE="\[\033[0m\]"    # unsets color to term's fg color

    # regular colors
    local K="\[\033[1;30m\]"    # black
    local R="\[\033[1;31m\]"    # red
    local G="\[\033[1;32m\]"    # green
    local Y="\[\033[1;33m\]"    # yellow
    local B="\[\033[1;34m\]"    # blue
    local M="\[\033[1;35m\]"    # magenta
    local C="\[\033[1;36m\]"    # cyan
    local W="\[\033[1;37m\]"    # white

    # emphasized (bolded) colors
    local EMK="\[\033[1;30m\]"
    local EMR="\[\033[1;31m\]"
    local EMG="\[\033[1;32m\]"
    local EMY="\[\033[1;33m\]"
    local EMB="\[\033[1;34m\]"
    local EMM="\[\033[1;35m\]"
    local EMC="\[\033[1;36m\]"
    local EMW="\[\033[1;37m\]"

    # background colors
    local BGK="\[\033[40m\]"
    local BGR="\[\033[41m\]"
    local BGG="\[\033[42m\]"
    local BGY="\[\033[43m\]"
    local BGB="\[\033[44m\]"
    local BGM="\[\033[45m\]"
    local BGC="\[\033[46m\]"
    local BGW="\[\033[47m\]"

    local UC=$W                 # user's color
    [ $UID -eq "0" ] && UC=$R   # root's color

    PS1="$TITLEBAR${W}[${EMG}\u${EMC}:${EMB}\${NEW_PWD}${W}]${UC}\\$ ${NONE}"
    # without colors: PS1="[\u@\h \${NEW_PWD}]\\$ "
    # extra backslash in front of \$ to make bash colorize the prompt
}

PROMPT_COMMAND=bash_prompt_command
bash_prompt
unset bash_prompt

# Bash completion for homebrew.
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

# Bash completion for git.
if [ -f ~/dotfiles/git/git-completion.bash ]; then
    . ~/dotfiles/git/git-completion.bash
fi

# Bash completion for git flow.
if [ -f ~/dotfiles/git/git-flow-completion.bash ]; then
    . ~/dotfiles/git/git-flow-completion.bash
fi

# To stop clang errors thanks to Xcode updates.
# https://langui.sh/2014/03/10/wunused-command-line-argument-hard-error-in-future-is-a-harsh-mistress/
export ARCHFLAGS="-Wno-error=unused-command-line-argument-hard-error-in-future"

# Python
VIRTUALENV_WRAPPER='/usr/local/bin/virtualenvwrapper.sh'
if [ -f $VIRTUALENV_WRAPPER ]
then
    source $VIRTUALENV_WRAPPER
fi

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

# Docker
export DOCKER_HOST=tcp://`boot2docker ip 2>/dev/null`:2375

# If nvm (node version manager) in installed, then use it.
[[ -s /Users/djm/.nvm/nvm.sh ]] && . /Users/djm/.nvm/nvm.sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
