#!/bin/bash
# checkout https://github.com/polybar/polybar/issues/763#issuecomment-450940924
(
  # prevent race conditions with a (f)lock
  flock 200

  # kill current instances of polybar
  killall -q polybar

  # make sure they're all dead
  while pgrep -u $UID -x polybar > /dev/null; do sleep 0.2; done

  # get the screens
  outputs=$(xrandr --query | awk '/ connected/{ print $1 }')

  # we want the tray to be consistently displayed on primary display
  tray=$(xrandr --query | awk '/primary/{ print $1 }')

  # iterate over outputs and setup the bar on them
  for m in $outputs; do
    export MONITOR=$m
    if [[ $m == $tray ]]; then
      export TRAY_POSITION="right"
    else
      export TRAY_POSITION="none"
    fi

    polybar --reload top </dev/null >/var/tmp/polybar-$m.log 2>&1 &
    disown
  done

  # unlock
  flock -u 200
) 200>/var/tmp/polybar-launch.lock
