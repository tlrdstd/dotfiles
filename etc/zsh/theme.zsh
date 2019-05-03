# This file is sourced in etc/zsh/oh-my.zsh,
# just before specifying the current theme.

POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_first_and_last
#POWERLEVEL9K_MODE=nerdfont-complete
POWERLEVEL9K_HIDE_BRANCH_ICON=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs time command_execution_time)

# disable extraneous icons to make the prompt shorter
POWERLEVEL9K_HOME_ICON=
POWERLEVEL9K_HOME_SUB_ICON=
POWERLEVEL9K_FOLDER_ICON=
POWERLEVEL9K_ETC_ICON=
POWERLEVEL9K_VCS_GIT_GITHUB_ICON=
