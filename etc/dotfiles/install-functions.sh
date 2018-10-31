dotfiles_timestamp=`date +"%Y%m%d%H%M%S"`
DOTFILES_BASEDIR=`basename ${DOTFILES}`

function dotfiles_backup() {
  TARGET=$1

  # remove symlinks in advance, lest ln nest directory symlinks
  if [ -h ${TARGET} ]; then
    rm ${TARGET}
  fi

  # if the file/folder still exists, back it up
  if [ -e ${TARGET} ]; then
    BAK=${TARGET}.${dotfiles_timestamp}
    echo "backing up ${TARGET} to ${BAK}"
    mv ${TARGET} ${BAK}
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
  git submodule update --recursive --init
  popd
}

function dotfiles_install_conf_files() {
  pushd ${DOTFILES}

  for dotfile in $(find conf -maxdepth 1 -type f); do
    SOURCE=${DOTFILES_BASEDIR}/${dotfile}
    TARGET=${HOME}/.`basename ${dotfile}`

    dotfiles_backup_and_link ${SOURCE} ${TARGET}
  done

  for dotfile in $(find conf -maxdepth 1 -type l); do
    SOURCE=${DOTFILES_BASEDIR}/${dotfile}
    TARGET=${HOME}/.`basename ${dotfile}`

    dotfiles_backup_and_link ${SOURCE} ${TARGET}
  done

  for configdir in $(find conf/config -maxdepth 1 -mindepth 1 -type d); do
    SOURCE=../${DOTFILES_BASEDIR}/${configdir}
    TARGET=${HOME}/.config/`basename ${configdir}`

    mkdir -pv $(dirname ${TARGET})
    dotfiles_backup_and_link ${SOURCE} ${TARGET}
  done

  popd
}

function dotfiles_install_tmp_dir() {
  SOURCE=${DOTFILES_BASEDIR}/etc/tmp
  TARGET=${HOME}/.tmp

  dotfiles_backup_and_link ${SOURCE} ${TARGET}
}

function dotfiles_install_vim_dir() {
  SOURCE=${DOTFILES_BASEDIR}/vim
  TARGET=${HOME}/.vim

  dotfiles_backup_and_link ${SOURCE} ${TARGET}
}

function dotfiles_install_vim_fonts() {
  ${DOTFILES}/vim/bundle/fonts/install.sh
}

# integrate with bootstrap project, if present
# otherwise, take over the rc file for all supported shells (.bashrc, .zshrc, etc)
function dotfiles_install_shellrc() {
  # Find all supported/configurable shells
  for shell in $(echo 'bash sh zsh'); do
    # Take over the rc file for this shell
    dotfiles_backup_and_link ${DOTFILES_BASEDIR}/conf/dotfilesrc ${HOME}/.${shell}rc
  done

  # Activate dotfiles for this shell
  source ${HOME}/.${DOTFILES_SHELL}rc
}

function dotfiles_install() {
  pushd ~
  dotfiles_install_submodules
  dotfiles_install_conf_files
  dotfiles_install_tmp_dir
  dotfiles_install_vim_dir
  dotfiles_install_vim_fonts
  dotfiles_install_shellrc
  popd
}

# pull latest conf files from git and install
function dotfiles_update() {
  pushd ${DOTFILES}
  git pull && dotfiles_install
  popd
}
