#!/usr/bin/env zsh

title=$(playerctl metadata --format "{{trunc(title, 30)}} - {{trunc(artist, 30)}}" 2>/dev/null)
# time="$(playerctl position --format "{{duration(position)}}") / $(playerctl metadata --format "{{duration(mpris:length)}}")"
case $(playerctl status 2>&1) in
  Playing)
    echo "\uf04b ${title}"
    ;;
  Paused)
    echo "\uf04c ${title}"
    ;;
  *)
    echo ""
    ;;
esac
