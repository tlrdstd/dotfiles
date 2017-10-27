#!/bin/bash

# install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew tap homebrew/dupes
brew tap homebrew/cask
brew tap caskroom/fonts

brew cask install xquartz
brew cask install font-fira-code

brew install ag
brew install bash
brew install binutils
brew install coreutils
brew install coreutils
brew install diffutils
brew install ed
brew install findutils
brew install gawk
brew install git
brew install gnu-indent
brew install gnu-sed
brew install gnu-sed
brew install gnu-tar
brew install gnu-tar
brew install gnu-which
brew install gnu-which
brew install gnutls
brew install gpatch
brew install gpg
brew install grep
brew install gzip
brew install gzip
brew install htop
brew install iterm2
brew install less
brew install m4
brew install make
brew install nano
brew install nmap
brew install perl
brew install python
brew install python3
brew install ruby
brew install screen
brew install tmux
brew install watch
brew install wdiff
brew install wget
brew install zsh

brew install vim --with-override-system-vi
brew install macvim --env-std --with-override-system-vim
brew link --overwrite macvim

brew update
brew upgrade
brew doctor

pip install powerline-status
