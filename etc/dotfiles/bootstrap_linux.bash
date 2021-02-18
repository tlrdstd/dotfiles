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

brew install ack
brew install ag
brew install bash
brew install openssl # must come before curl - https://github.com/Linuxbrew/brew/wiki/FAQ#why-does-curl-fail
brew install curl --with-gssapi --with-libssh2
brew install fzf
brew install git
brew install gron
# brew install gtk+
brew install htop
brew install jq
brew install ncdu
brew install node
brew install openjdk@11
brew link --force openjdk@11
brew install perl
brew install postgresql
brew install python
brew install python3
brew install ruby
brew install tmux
# sed -i.bak 's/enable-gui=no/enable-gui/' ~/.linuxbrew/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/vim.rb
brew install vim --with-override-system-vi --with-client-server --with-lua --with-python3 --with-tcl --with-gettext # --enable-gui
brew install zsh

# brew install xauth
# https://w.amazon.com/index.php/CloudDeveloperDesktop/UserGuide/GUI
# sudo yum install xrdp x11rdp xorgxrdp
# eclim - WIP - depends on dotfiles_install
# sudo yum install xorg-x11-server-Xvfb
# pushd /workplace/distyler
# wget http://mirrors.syringanetworks.net/eclipse/technology/epp/downloads/release/2019-06/R/eclipse-java-2019-06-R-linux-gtk-x86_64.tar.gz
# tar -xfz eclipse-java-2019-06-R-linux-gtk-x86_64.tar.gz
# wget https://github.com/ervandew/eclim/releases/download/2.8.0/eclim_2.8.0.bin && chmod +x eclim_2.8.0.bin
# mkdir ~/.vim/bundle/eclim
# # not sure about these plugins - want java and ruby
# ./eclim_2.8.0.bin --yes --eclipse=/workplace/distyler/eclipse --vimfiles=~/.vim/bundle/eclim --plugins=jdt,ruby
# popd

# install nvm and node
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
nvm install v8.12.0

mkdir -pv ~/.local/share/fonts
for type in Bold Light Medium Regular Retina; do
  wget -O ~/.local/share/fonts/FiraCode-${type}.ttf \
  "https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-${type}.ttf?raw=true";
done
fc-cache --verbose -f ~/.local/share/fonts
