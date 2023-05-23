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
fpath=(~/.config/zsh/completion $fpath)
# Activate zsh completions engine
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

complete -C '/apollo/env/AmazonAwsCli/bin/aws_completer' aws

# enable fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# enable env_parallel so I can run shell functions in parallel
. `which env_parallel.zsh`
