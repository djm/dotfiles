#!/usr/bin/env python
# -*- coding: utf-8 -*-
import subprocess
import os

DOTFILES_DIR = os.path.expanduser('~/Source/dotfiles/')

SYMLINKS = (
    ('.aliases', '~/.aliases'),
    # Bash
    ('.bashrc', '~/.bashrc'),
    ('.bash_profile', '~/.bash_profile'),
    ('.bash_prompt', '~/.bash_prompt'),
    # Zsh
    ('.zshrc', '~/.zshrc'),
    # Shell bits
    ('.path', '~/.path'),
    ('.inputrc', '~/.inputrc'),
    ('.hushlogin', '~/.hushlogin'),
    # Ag - silver searcher.
    ('.agignore', '~/.agignore'),
    # Git
    ('.gitconfig', '~/.gitconfig'),
    ('.gitignore_', '~/.gitignore'),
    ('.git_commit_msg.txt', '~/.git_commit_msg.txt'),
    # Mercurial
    ('.hgext', '~/.hgext'),
    ('.hgrc', '~/.hgrc'),
    # Vim
    ('.vimrc', '~/.vimrc'),
    ('.vim', '~/.vim'),
    # Emacs
    ('.spacemacs', '~/.spacemacs'),
    # Python
    ('.config/flake8', '~/.config/flake8'),
)


POST_COMMANDS = (
    'vim +PluginInstall +qall',  # Install Vim packages via vundle.
)


def underline(title):
    """ Underlines a string """
    return "{0}\n{1}\n".format(title, len(title) * '=')


def install_dotfiles():
    print(underline('Creating symlinks'))
    for orig_loc, symlink in SYMLINKS:
        symlink = os.path.expanduser(symlink)
        symlink_dir = os.path.dirname(symlink)
        if not os.path.exists(symlink_dir):
            os.makedirs(symlink_dir)
        orig_loc = '{}{}'.format(DOTFILES_DIR, orig_loc)
        create_symlink(orig_loc, symlink)
        print ("")


def create_symlink(orig_loc, symlink):
    print('Symlink: {}'.format(symlink))
    if os.path.exists(symlink):
        print('✘ Failed: path exists.')
        return
    os.symlink(orig_loc, symlink)
    print ('✔ Created.')


def run_post_install_commands():
    print(underline('Running install commands'))
    for command in POST_COMMANDS:
        print('Running: {}'.format(command))
        subprocess.call(command, shell=True)
    return


if __name__ == "__main__":
    print('')
    install_dotfiles()
    run_post_install_commands()
    print('\nDone!')
