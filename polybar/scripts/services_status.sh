#!/usr/bin/env zsh

# set -eo pipefail

STATUS_CHECK_SCRIPT='
BEGIN {
  isRunning = 0
  timeAgo = 999
  status = UNKNOWN

  GREEN = "%{F#55aa55}"
  YELLOW = "%{F#ffb86c}"
  RED = "%{F#ff5555}"
  RESET = "%{F-}"  

  RUNNING = "\uf144"
  SUCCESS = "\uf058"
  WARNING = "\uf056"
  FAILURE = "\uf06a"
}

/^((\s|\t)+)Active:/ {
  if (match($0, /([0-9]+)h ago/, groups)) {
    timeAgo = groups[1]
  }
  if (match($0, /active \(running\)/)) {
    isRunning = 1
  }
}
/^((\s|\t)+)Process:/ {
  if (match($0, /\(code=exited, status=([0-9]+)\/(\w+)\)/, groups)) {
    status = groups[2]
  }
}

END {
  if(isRunning) {
    printf "%s%s%s", RESET, RUNNING, RESET 
  } else if(status == "SUCCESS") {
    if(timeAgo < 36) {
      printf "%s%s%s", GREEN, SUCCESS, RESET 
    } else {
      printf "%s%s%s", YELLOW, WARNING, RESET 
    }
  } else {
    printf "%s%s%s", RED, FAILURE, RESET 
  }
}
';

GET_STATUS_SCRIPT='
/Active:/ {
  if(match($0, /Active: /)) {
    pos = RSTART + RLENGTH
    print substr($0, pos)
  }
}
'

if [[ -z $1 ]]; then
  local_backup=$(systemctl status backup-snapshots | awk "${STATUS_CHECK_SCRIPT}")
  remote_backup=$(systemctl --user status duplicity | awk "${STATUS_CHECK_SCRIPT}")

  echo "${local_backup} ${remote_backup}"
elif [[ $1 == "notify" ]]; then
  local_backup=$(systemctl status backup-snapshots | awk "${GET_STATUS_SCRIPT}")
  remote_backup=$(systemctl --user status duplicity | awk "${GET_STATUS_SCRIPT}")
  
  dunstify "Local backup status" "${local_backup}"
  dunstify "Remote backup status" "${remote_backup}"
fi

