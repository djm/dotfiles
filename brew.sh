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

# Install Bash 4. Then switch to it.
brew install bash
brew tap homebrew/versions
brew install bash-completion2

# Switch to using brew-installed bash as default shell
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

# Install `wget` with IRI support.
brew install wget --with-iri

# Install more recent versions of some macOS tools.
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen

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
brew install heroku

# Install Casks
brew install Caskroom/cask/hipchat
brew install Caskroom/cask/macdown
brew install Caskroom/cask/keepassx
brew install Caskroom/versions/slack-beta

# Install some fonts
brew tap caskroom/fonts
brew cask install font-inconsolata

brew cleanup
