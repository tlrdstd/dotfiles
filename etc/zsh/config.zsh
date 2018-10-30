# append to history file, don't overwrite it
setopt appendhistory
# automatically cd to directories matching command names
setopt autocd
# treat #, -, and ^ as filename glob patterns
setopt extendedglob
# print an error if filename expansion fails, instead of leaving it as-is
setopt nomatch
# DIE, FOUL BELL
unsetopt beep

# use vim keybindings
bindkey -v

# enable Ctrl-R history search like emacs mode
bindkey '^R' history-incremental-search-backward

# make zsh vi bindings more like vim
# permit deleting backwards from insert point
bindkey "^?" backward-delete-char
# ctrl-w deletes previous word
bindkey "^W" backward-kill-word
# ctrl-h also deletes the previous char
bindkey "^H" backward-delete-char
# ctrl-u deletes an entire line
bindkey "^U" backward-kill-line

# Specify custom dotfiles ZSH completion path
fpath=(~/.tmp/completion $fpath)
# Activate zsh completions engine
autoload -Uz compinit
compinit
