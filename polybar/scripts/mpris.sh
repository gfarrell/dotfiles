#!/usr/bin/env zsh

title=$(playerctl metadata --format "{{title}} - {{artist}}" 2>/dev/null)
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
