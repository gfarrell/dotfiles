#!/usr/bin/env zsh

title=$(playerctl metadata --format "{{title}} - {{artist}}" 2>/dev/null)
case $(playerctl status) in
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
