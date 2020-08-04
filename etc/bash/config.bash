# History management
shopt -s histappend # append to history file, don't overwrite it

# Bash auto-completes SSH config entries
complete -W "$(echo `grep -i '^host ' ~/.ssh/config | awk '{print $2 " " $3}' | uniq | sort`)" ssh

# enable fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
