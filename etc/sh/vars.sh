# determine which OS we're running on
case "$(uname -s)" in
    Linux*)   DOTFILES_OS=Linux;;
    Darwin*)  DOTFILES_OS=Mac;;
esac

# Global shell config variables
export EDITOR=vim

# Inject Homebrew into the PATH
if [ "${DOTFILES_OS}" = "Mac" ]; then
  export PATH=/usr/local/opt/coreutils/libexec/gnubin:${PATH}
  export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}
fi

# Inject Linuxbrew into the PATH
if [ "${DOTFILES_OS}" = "Linux" ]; then
  export PATH=/home/linuxbrew/.linuxbrew/bin:~/.linuxbrew/bin:${PATH}
  export PATH=/home/linuxbrew/.linuxbrew/sbin:~/.linuxbrew/sbin:${PATH}
  export MANPATH=/home/linuxbrew/.linuxbrew/share/man:~/.linuxbrew/share/man:${MANPATH}
  export INFOPATH=/home/linuxbrew/.linuxbrew/share/info:~/.linuxbrew/share/info:${INFOPATH}
fi

# History management
export HISTFILE=~/.tmp/.histfile
export HISTSIZE=100000 # big shell command history
export HISTFILESIZE=100000 # big shell command history file
export HISTCONTROL=ignoredups:erasedups # avoid shell command history dups

# Enable X11
export DISPLAY=:0
