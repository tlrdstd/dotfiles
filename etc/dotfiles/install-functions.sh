dotfiles_timestamp=`date +"%Y%m%d%H%M%S"`
DOTFILES_BASEDIR=`basename ${DOTFILES}`

function dotfiles_backup() {
  TARGET=$1

  # remove symlinks in advance, lest ln nest directory symlinks
  if [ -h ${TARGET} ]; then
    rm ${TARGET}
  fi

  # if the file/folder still exists, deal with it
  if [ -e ${TARGET} ]; then
    if [ "${DOTFILES_BACKUP}" = "false" ]; then
      # backups are disabled - nuke the old version
      echo "Not backing up ${TARGET}"
      rm -rfv ${TARGET}
    else
      # backups are enabled - preserve those bits
      BAK=${TARGET}.${dotfiles_timestamp}
      echo "backing up ${TARGET} to ${BAK}"
      mv ${TARGET} ${BAK}
    fi
  fi
}

function dotfiles_backup_and_link() {
  RELATIVE_SOURCE=$1
  TARGET=$2

  DOTFILES_PARENT_DIR=`dirname ${DOTFILES}`
  ABSOLUTE_SOURCE=`readlink -f ${DOTFILES_PARENT_DIR}/${RELATIVE_SOURCE}`

  dotfiles_backup ${TARGET}
  echo "linking ${ABSOLUTE_SOURCE} to ${TARGET} as ${RELATIVE_SOURCE}"
  ln -sf ${RELATIVE_SOURCE} ${TARGET}
}

function dotfiles_install_submodules() {
  pushd ${DOTFILES}
  git submodule update --recursive --init --remote
  popd
}

function dotfiles_install_conf_files() {
  pushd ${DOTFILES}

  # symlink all dotfiles
  for dotfile in $(find homedir -maxdepth 1 -type f); do
    SOURCE=${DOTFILES_BASEDIR}/${dotfile}
    TARGET=${HOME}/.`basename ${dotfile}`

    dotfiles_backup_and_link ${SOURCE} ${TARGET}
  done

  # symlink all symlinks
  for dotfile in $(find homedir -maxdepth 1 -type l); do
    SOURCE=${DOTFILES_BASEDIR}/${dotfile}
    TARGET=${HOME}/.`basename ${dotfile}`

    dotfiles_backup_and_link ${SOURCE} ${TARGET}
  done

  # symlink all top-level directories that we control
  for dotfile in $(find homedir -maxdepth 1 -type d -not -path homedir/shared); do
    SOURCE=${DOTFILES_BASEDIR}/${dotfile}
    TARGET=${HOME}/.`basename ${dotfile}`

    dotfiles_backup_and_link ${SOURCE} ${TARGET}
  done

  # symlink the contents of all shared directories
  for shareddir in $(find homedir/shared -maxdepth 1 -mindepth 1 -type d); do
    for subdir in $(find ${shareddir} -maxdepth 1 -mindepth 1 -type d); do
      SOURCE=../${DOTFILES_BASEDIR}/${subdir}
      TARGET=${HOME}/.`basename ${shareddir}`/`basename ${subdir}`

      mkdir -pv $(dirname ${TARGET})
      dotfiles_backup_and_link ${SOURCE} ${TARGET}
    done
  done

  popd
}

function dotfiles_install_ssh_dir() {
  mkdir -pv ${HOME}/.ssh
  touch ${HOME}/.ssh/config
  chmod 0600 ${HOME}/.ssh/config
}

function dotfiles_install_powerline_fonts() {
  ${DOTFILES}/homedir/powerline/fonts/install.sh
}

# take over the rc file for all supported shells (.bashrc, .zshrc, etc)
function dotfiles_install_shellrc() {
  # Find all supported/configurable shells
  for shell in $(echo 'bash sh zsh'); do
    # Take over the rc file for this shell
    dotfiles_backup_and_link .dotfilesrc ${HOME}/.${shell}rc
  done

  # Activate dotfiles for this shell
  source ${HOME}/.${DOTFILES_SHELL}rc
}

function dotfiles_install() {
  pushd ~
  dotfiles_install_ssh_dir
  dotfiles_install_submodules
  dotfiles_install_conf_files
  dotfiles_install_powerline_fonts
  dotfiles_install_shellrc
  popd
}

# pull latest conf files from git and install
function dotfiles_update() {
  pushd ${DOTFILES}
  git pull && dotfiles_install
  popd
}
