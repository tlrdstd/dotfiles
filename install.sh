#!/usr/bin/env bash

DOTFILES=${DOTFILES-${HOME}/dotfiles}
DOTFILES_SHELL=$(basename $SHELL)
INSTALL_FUNCTIONS=${DOTFILES}/etc/dotfiles/install-functions.sh

if [ -e "${INSTALL_FUNCTIONS}" ]; then
  source ${INSTALL_FUNCTIONS}
else
  echo "${INSTALL_FUNCTIONS} was not found! Check your path and try again."
  exit 1
fi

dotfiles_install
