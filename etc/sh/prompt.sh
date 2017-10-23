# TODO - make Powerline activation optional
# TODO - smoothly fallback if Powerline is missing

# Figure out where Powerline is installed on this host
powerline_root_path='/tmp/.powerline_root'
if [ ! -e ${powerline_root_path} ]; then
  pip2 show powerline-status --disable-pip-version-check | grep Location | cut -f2 -d' ' > ${powerline_root_path}
fi
export POWERLINE_ROOT=$(cat ${powerline_root_path})

# Launch the powerline-daemon if it is not already running
pgrep -f powerline-daemon > /dev/null
if [ $? -eq 1 ]; then
  powerline-daemon -q
fi
