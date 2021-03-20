#!/bin/zsh

set -e

#
# Gideon's Linux Init Script
#

# Goals: This script should be set up a new system to be exactly how I
# use my current system. The script must also be idempotent, so that
# it is possible to repeatedly run it on a system without altering the
# configuration or breaking it. The script must be distribution-aware.
#
# This does use zsh rather than bash, so might require it to be
# installed first. The reason for this is that I found some things just
# didn't work well in bash.

# Preamble: Help function {{{
function show_help {
  echo <<EOF
Usage: init-linux.sh [OPTIONS]

Initialises a linux system in a distribution-aware manner.

Options:
  -d (dry-run)      log the output without actually doing anything
  -q (quiet mode)   only log warnings and errors
  -h (help)         show this help message
EOF
}
# }}}
# Preamble: setup {{{
## Reset options index in case getopt has already been used in the shell
OPTIND=1
## Default mode is not a dry run
DRY_RUN=0
## Default mode is to log everything, LOGLEVEL=1 means only errors / warnings
LOG_LEVEL=0
## Get options
while getopts "hdq" opt; do
  case "$opt" in
    h)
      show_help
      exit 0
      ;;
    d)
      DRY_RUN=1
      ;;
    q)
      LOG_LEVEL=1
      ;;
  esac
done
## Get the directory of this script
DIR="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )";
# }}}
# Preamble: common functions {{{
## Logging functions
function log {
  if [[ $LOG_LEVEL = 0 ]]; then
    echo "[$(date +%Y-%m-%dT%H:%M:%S)] $1";
  fi
}

function warn {
  log "WARNING: $1";
}

function err {
  log "ERROR: $1";
  exit ${2:-1};
}

## File-reading functions
function read_pkglist {
  awk '/^\s*[^#]/ { print }' "$DIR/$1.txt";
}
function lcount {
  echo "$1" | wc -l;
}

## File-moving
function su_fcopy {
  source_dir="$DIR/$1"
  target_dir=$2
  if [[ ! -d "$source_dir" ]]; then
    err "No such directory $source_dir";
  else
    ff=$(ls -1 $source_dir)
    log "Copying $(lcount $ff) files from $source_dir -> $target_dir as root"
    if [[ ! -d "$target_dir" ]]; then
      log "Target $target_dir does not exist, creating it..."
      if [[ $DRY_RUN = 0 ]]; then
        sudo mkdir -p "$target_dir"
      else
        echo "> sudo mkdir -p \"$target_dir\""
      fi
    fi
    if [[ $DRY_RUN = 0 ]]; then
      sudo cp "$source_dir/*" "$target_dir/"
    else
      echo "> sudo cp \"$source_dir/*\" \"$target_dir/\""
    fi
  fi
}

# }}}
# Preamble: OS-detection, &c. {{{

## Variable setup
DISTRO='unknown';

## Errors
ERR_OS_UNKNOWN=101;
ERR_OS_NONLINUX=102;

## Detect the OS
if ! command -v uname >/dev/null; then
  err "Unable to detect system type without uname. Aborting." $ERR_OS_UNKNOWN;
fi

if [[ $(uname -o) != 'GNU/Linux' ]]; then
  err "This script only works on linux. Aborting." $ERR_OS_NONLINUX;
fi

if [[ $(cat /etc/os-release | awk 'BEGIN { FS="=" } /^NAME=/ { gsub("\"", ""); print $2 }') = 'Arch Linux' ]]; then
  log "Detected Archlinux!"
  DISTRO='archlinux'
fi

# }}}
# §1 Package installation {{{

if [[ $DISTRO == "archlinux" ]]; then
  # Update pacman and upgrade all packages
  if [[ $DRY_RUN = 0 ]]; then
    sudo pacman -Syu;
  else
    echo "> sudo pacman -Syu;"
  fi
  # Install yay (AUR helper)
  log "Installing yay"
  if [[ $DRY_RUN = 0 ]]; then
    YAYDIR="/tmp/linux-init-build-yay-$(date +%Y%m%d)"
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git "$YAYDIR"
    cd "$YAYDIR" && sudo mkpkg -si
    sudo rm -r "$YAYDIR"
  else
    echo "> YAYDIR=\"/tmp/linux-init-build-yay-$(date +%Y%m%d)\""
    echo "> sudo pacman -S --needed git base-devel"
    echo "> git clone https://aur.archlinux.org/yay.git \"$YAYDIR\""
    echo "> cd \"$YAYDIR\" && sudo mkpkg -si"
    echo "> sudo rm -r \"$YAYDIR\""
  fi
  # Install packages
  pacman_packages=$(read_pkglist "pacman-packages");
  pacman_pkg_count=$(lcount "$pacman_packages");
  aur_packages=$(read_pkglist "aur-packages");
  aur_pkg_count=$(lcount "$aur_packages");
  log "Installing ${pacman_pkg_count} packages via pacman and ${aur_pkg_count} from the AUR"
  if [[ $DRY_RUN = 0 ]]; then
    echo "$pacman_packages" | xargs sudo pacman -S
    echo "$aur_packages" | xargs yay -S
  else
    echo "> echo \"$pacman_packages\" | xargs sudo pacman -S"
    echo "> echo \"$aur_packages\" | xargs yay -S"
  fi
fi

# }}}
# §2 Move system configuration into place {{{

if [[ -d /etc/X11/xorg.conf.d/ ]]; then
  log "Moving X11 config"
  su_fcopy "x11-conf" "/etc/X11/xorg.conf.d"
else
  warn "/etc/X11/xorg.conf.d is not a directory, will not move X11 config"
fi

# TODO: display manager setup
# TODO: grub settings (do we want to do this?)

# }}}

# vim:foldmethod=marker
