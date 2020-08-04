#!/bin/bash

# install linuxbrew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH

if which yum > /dev/null ; then
  sudo yum groupinstall 'Development Tools'
else
  sudo apt-get install build-essential
fi

# build modern gcc (and glibc) using the pre-installed gcc-4.4
# per https://github.com/Linuxbrew/brew/wiki/CentOS6
# TODO - skip this if installed to /home/linuxbrew
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

brew install ag
brew install bash
brew install openssl # must come before curl - https://github.com/Linuxbrew/brew/wiki/FAQ#why-does-curl-fail
brew install curl --with-gssapi --with-libssh2
brew install fzf
brew install git
brew install gtk+
brew install jq
brew install jdk
brew install ncdu
brew install node
brew install perl
brew install postgresql
brew install python
brew install python3
brew install ruby
brew install tmux
sed -i.bak 's/enable-gui=no/enable-gui/' ~/.linuxbrew/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/vim.rb
brew install vim --with-override-system-vi --with-client-server --with-lua --with-python3 --with-tcl --with-gettext --enable-gui
brew install zsh

# install nvm and node
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
nvm install v8.12.0

mkdir -pv ~/.local/share/fonts
for type in Bold Light Medium Regular Retina; do
  wget -O ~/.local/share/fonts/FiraCode-${type}.ttf \
  "https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-${type}.ttf?raw=true";
done
fc-cache --verbose -f ~/.local/share/fonts
