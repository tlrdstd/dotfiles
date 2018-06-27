# ls --color configuration
if [ -f $HOME/.dircolors ]; then
  eval `dircolors $HOME/.dircolors`
fi

# prevent Ctrl-Q from mapping to `stty start`
# allows <C-Q> to map to <C-V> in Vim
stty start undef
