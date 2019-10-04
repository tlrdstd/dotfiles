# ls --color configuration
if [ -f $HOME/.dircolors ]; then
  eval `dircolors $HOME/.dircolors`
fi

# prevent Ctrl-Q from mapping to `stty start`
# allows <C-Q> to map to <C-V> in Vim
stty start undef

# enable nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
