# Activate git-completion prompt helper
source $DOTFILES/etc/git/git-completion.${DOTFILES_SHELL}

# Set a custom terminal window title
function host_title() {
  echo -ne "\E]0;$LOGNAME@$HOSTNAME:${PWD/$HOME/~}\a"
}
export PROMPT_COMMAND=host_title

# Activate the Powerline shell prompt
# TODO - make Powerline activation optional
# TODO - smoothly fallback if Powerline is missing
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
source ${POWERLINE_ROOT}/powerline/bindings/bash/powerline.sh

# Figure out where Powerline is installed on this host
powerline_root_path='/tmp/.powerline_root'
if [ ! -e ${powerline_root_path} ]; then
  pip3 show powerline-status --disable-pip-version-check | grep Location | cut -f2 -d' ' > ${powerline_root_path}
fi
export POWERLINE_ROOT=$(cat ${powerline_root_path})

# Launch the powerline-daemon if it is not already running
pgrep -f powerline-daemon > /dev/null
if [ $? -eq 1 ]; then
  powerline-daemon -q
fi
