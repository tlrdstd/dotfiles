#!/bin/bash

# install linuxbrew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
sudo yum groupinstall 'Development Tools'

# build modern gcc (and glibc) using the pre-installed gcc-4.4
# per https://github.com/Linuxbrew/brew/wiki/CentOS6
if [[ "$(gcc -dumpversion)" == '4.4.6' ]]; then
  HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_BUILD_FROM_SOURCE=1 brew install gcc --without-glibc
  HOMEBREW_NO_AUTO_UPDATE=1 brew install glibc
  HOMEBREW_NO_AUTO_UPDATE=1 brew remove gcc
  HOMEBREW_NO_AUTO_UPDATE=1 brew install gcc
  # generate more locales after above awkward installation
  localedef -v -c -i en_US -f UTF-8 en_US.UTF-8
else
  brew install gcc
fi

brew install bash
brew install git
brew install perl
brew install python
brew install python3
brew install ruby
brew install tmux
brew install vim
brew install zsh

pip2 install --upgrade pip setuptools
pip3 install --upgrade pip setuptools wheel
pip3 install powerline-status
