# execute long-running command that should survive connection auto-timeout
function run() {
  nohup $* > nohup.${1}.$$.log 2>&1 &
}
