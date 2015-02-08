git clone git@github.com:djm/dotfiles.git ~/dotfiles/

# Bash config
ln -s ~/dotfiles/bash/bashrc ~/.bashrc
ln -s ~/dotfiles/bash/bash_profile ~/.bash_profile
ln -s ~/dotfiles/bash/inputrc ~/.inputrc

# Git config
ln -s ~/dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/dotfiles/git/gitignore ~/.gitignore
git config --global core.excludesfile ~/.gitignore

# Mercurial config
ln -s ~/dotfiles/hg/hgext ~/.hgext
cp ~/dotfiles/hg/hgrc ~/.hgrc # Copy instead of link due to auth details.

# Vim Config
ln -s ~/dotfiles/vim/vimrc ~/.vimrc
ln -s ~/dotfiles/vim/vim/ ~/.vim

# Python Config
ln -s ~/dotfiles/python/flake8 ~/.config/flake8

# Source Bash
. ~/.bash_profile
