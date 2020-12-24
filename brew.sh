#!/usr/bin/env bash

# Install tools using Homebrew.

brew update
brew upgrade

# Install GNU core utilities (those that come with macOS are outdated).
# Add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
brew install moreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils

# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

# Install `wget` with IRI support.
brew install wget --with-iri

# Install more recent versions of some macOS tools.
brew install vim --override-system-vi

# Install some CTF tools; see https://github.com/ctfs/write-ups.
brew install nmap
brew install tcpflow
brew install tcpreplay
brew install tcptrace

# Install version control tools.
brew install git
brew install svn
brew install mercurial

# Install search tools
brew install ag
brew install ack

# Install directory tools
brew install tree

# Install 3rd party services
brew tap heroku/brew
brew install heroku

brew install pyenv
brew install direnv
brew install yarn
brew install forego

# Install AWS SAM CLI
brew tap aws/tap
brew install aws-sam-cli

brew cleanup
