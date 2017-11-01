# Global shell config variables
export EDITOR=vim

# Inject Homebrew into the PATH
export PATH=/usr/local/opt/coreutils/libexec/gnubin:${PATH}
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}

# Inject Linuxbrew into the PATH
export PATH=/home/linuxbrew/.linuxbrew/bin:~/.linuxbrew/bin:${PATH}
export PATH=/home/linuxbrew/.linuxbrew/sbin:~/.linuxbrew/sbin:${PATH}
export MANPATH=/home/linuxbrew/.linuxbrew/share/man:~/.linuxbrew/share/man:${MANPATH}
export INFOPATH=/home/linuxbrew/.linuxbrew/share/info:~/.linuxbrew/share/info:${INFOPATH}

# History management
export HISTFILE=~/.tmp/.histfile
export HISTSIZE=100000 # big shell command history
export HISTFILESIZE=100000 # big shell command history file
export HISTCONTROL=ignoredups:erasedups # avoid shell command history dups

# Enable X11
export DISPLAY=:0

# Figure out where Powerline is installed on this host
powerline_root_path='/tmp/.powerline_root'
if [[ (! -e ${powerline_root_path}) || (! -s ${powerline_root_path}) ]]; then
  pip3 show powerline-status --disable-pip-version-check | grep Location | cut -f2 -d' ' > ${powerline_root_path}
fi
export POWERLINE_ROOT=$(cat ${powerline_root_path})
