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

# Launch the powerline-daemon if it is not already running
pgrep -f powerline-daemon > /dev/null
if [ $? -eq 1 ]; then
  powerline-daemon -q
fi
