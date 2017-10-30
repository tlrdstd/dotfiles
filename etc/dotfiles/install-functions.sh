dotfiles_timestamp=`date +"%Y%m%d%H%M%S"`

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
  SOURCE=$1
  TARGET=$2

  dotfiles_backup ${TARGET}
  echo "linking ${SOURCE} to ${TARGET}"
  ln -sf ${SOURCE} ${TARGET}
}

function dotfiles_install_conf_files() {
  for dotfile in $(find ${DOTFILES}/conf -maxdepth 1 -type f); do
    SOURCE=${dotfile}
    TARGET=${HOME}/.`basename ${dotfile}`

    dotfiles_backup_and_link ${SOURCE} ${TARGET}
  done

  for dotfile in $(find ${DOTFILES}/conf -maxdepth 1 -type l); do
    SOURCE=${dotfile}
    TARGET=${HOME}/.`basename ${dotfile}`

    dotfiles_backup_and_link ${SOURCE} ${TARGET}
  done

  for configdir in $(find ${DOTFILES}/conf/config -maxdepth 1 -mindepth 1 -type d); do
    SOURCE=${configdir}
    TARGET=${HOME}/.config/`basename ${configdir}`

    mkdir -pv $(dirname ${TARGET})
    dotfiles_backup_and_link ${SOURCE} ${TARGET}
  done
}

function dotfiles_install_tmp_dir() {
  SOURCE=${DOTFILES}/etc/tmp
  TARGET=${HOME}/.tmp

  dotfiles_backup_and_link ${SOURCE} ${TARGET}
}

function dotfiles_install_vim_dir() {
  SOURCE=${DOTFILES}/vim
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
  for shell in $(grep bin /etc/shells | xargs -I % basename % | sort | uniq); do
    if [ -e ${DOTFILES}/etc/${shell} ]; then
      # Take over the rc file for this shell
      dotfiles_backup_and_link ${DOTFILES}/conf/dotfilesrc ${HOME}/.${shell}rc
    fi
  done

  # Activate dotfiles for this shell
  source ${HOME}/.${DOTFILES_SHELL}rc
}

function dotfiles_install() {
  pushd ~
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
