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

# Activate zsh completions engine
autoload -Uz compinit
compinit
fpath=(/usr/local/share/zsh-completions $fpath)
zstyle ':completion:*:*:git:*' script ${DOTFILES}/etc/git/git-completion.zsh
