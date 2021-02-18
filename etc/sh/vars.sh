# determine which OS we're running on
case "$(uname -s)" in
    Linux*)   DOTFILES_OS=Linux;;
    Darwin*)  DOTFILES_OS=Mac;;
esac

# Global shell config variables
export EDITOR=vim
export TERM=xterm-256color

# Inject Homebrew into the PATH
if [ "${DOTFILES_OS}" = "Mac" ]; then
  export PATH=/usr/local/opt/coreutils/libexec/gnubin:${PATH}
  export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}
fi

# Disable Homebrew locale filtering (throws errors)
# https://github.com/Linuxbrew/brew/issues/568
export HOMEBREW_NO_ENV_FILTERING=1

# Inject Linuxbrew into the PATH
if [ "${DOTFILES_OS}" = "Linux" ]; then
  LINUXBREW_HOME=$(/home/linuxbrew/.linuxbrew/bin/brew --prefix)
  export PATH=$LINUXBREW_HOME/bin:${PATH}
  export PATH=$LINUXBREW_HOME/sbin:${PATH}
  export MANPATH=$LINUXBREW_HOME/share/man:${MANPATH}
  export INFOPATH=$LINUXBREW_HOME/share/info:${INFOPATH}
fi

# History management
export HISTFILE=~/.tmp/.histfile
export HISTSIZE=100000 # big shell command history
export HISTFILESIZE=100000 # big shell command history file
export HISTCONTROL=ignoredups:erasedups # avoid shell command history dups

# Enable X11
# export DISPLAY=:0
