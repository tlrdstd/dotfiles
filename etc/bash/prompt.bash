# Activate git-completion prompt helper
source $DOTFILES/etc/git/git-completion.${DOTFILES_SHELL}

# Set a custom terminal window title
function host_title() {
  echo -ne "\E]0;$LOGNAME@$HOSTNAME:${PWD/$HOME/~}\a"
}
export PROMPT_COMMAND=host_title
