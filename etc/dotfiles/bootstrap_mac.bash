#!/bin/bash

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew analytics off

brew tap homebrew/cask
brew tap homebrew/cask-fonts

# X11 client...that I never use anymore
brew install --cask xquartz

# do not launch xterm on X11 startup
defaults write org.macosforge.xquartz.X11 app_to_run /usr/bin/true

# preferred development font
brew install --cask font-fira-code

# spotlight replacement for search/workflow improvement
brew install --cask alfred

# window management via keyboard shortcuts
brew install --cask rectangle

# window management that restores windows depending on what monitor(s) are connected
brew install --cask stay

# convenient calculator, usable from Alfred
brew install --cask numi

brew install ag
brew install bash
brew install binutils
brew install coreutils
brew install diffutils
brew install ed
brew install findutils
brew install fzf
brew install gawk
brew install git
brew install gnu-indent
brew install gnu-sed
brew install gnu-tar
brew install gnu-which
brew install gnutls
brew install gpatch
brew install gpg
brew install grep
brew install gzip
brew install htop
brew install iterm2
brew install jq
brew install keepassx
brew install less
brew install m4
brew install make
brew install nano
brew install nmap
brew install node
brew install openjdk
brew install perl
brew install postgresql
brew install python
brew install python3
brew install ruby
brew install screen
brew install sequel-pro
brew install tmux
brew install watch
brew install wdiff
brew install wget
brew install yarn
brew install zsh

brew install vim

brew update
brew upgrade
brew doctor

# enable key-repeating in VSCode
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

# Install the Amazon tap (one time use)
brew tap amazon/amazon ssh://git.amazon.com/pkg/HomebrewAmazon
brew update
brew install mwinit

# setup coc.nvim plugin
pushd $HOME/.vim/pack/plugins/start/coc
yarn install
popd

# tell Finder to show dotfiles. Agh.
defaults write com.apple.finder AppleShowAllFiles YES
