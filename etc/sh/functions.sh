# execute long-running command that should survive connection auto-timeout
function run() {
  nohup $* > nohup.${1}.$$.log 2>&1 &
}

# generate a random password that should satisfy most security reqs
function genpasswd() {
    date --iso-8601=ns | sha256sum | base64 | head -c 32 ; echo '_'
}
