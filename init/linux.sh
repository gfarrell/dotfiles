#! /bin/bash

# -------------------------------------------------
# SETUP
# -------------------------------------------------
# Get the directory of this script
DIR="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )";
# Create utility functions
function section {
  echo "";
  echo "------";
  echo "| $1";
  echo "======";
  echo "";
}
function log {
  echo "[+] $1";
}
function warn {
  echo "[!] $1";
}
function err {
  echo "[E] $1"; exit -1;
}
function read_pkglist {
  awk '/^\s*[^#]/ { print }' "$DIR/$1.txt";
}
function lcount {
  echo "$1" | wc -l;
}

# -------------------------------------------------
# Modify system settings
# -------------------------------------------------
section "Modifying system settings";

# Disable tap-and-drag on the touchpad as it is very annoying.
# I have found that doing this with just xinput doesn't work, you also have to
# modify the gnome settings.
if [ `command -v gsettings` ]; then
  log "Disabling tap-and-drag on the touchpad";
  gsettings set org.gnome.desktop.peripherals.touchpad tap-and-drag false;
else
  warn 'Cannot find gsettings, if you still need to disable tap-and-drag on the touchpad you will need to find another way, perhaps with xinput?';
fi

# Wishlist (some of these need custom installation steps)
# - libinput-gestures

# -------------------------------------------------
# Install packages
# -------------------------------------------------
section "Installing software";

# First we need to add the sources we need
function add_apt_sources {
  log "Adding apt sources";
  # yarn
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
}

# Then we might need to clean up packages from the default installation
function pre_install_cleanup {
  log "Cleaning up before installation";
  # Interferes with yarn
  sudo apt -qq remove -y cmdtest
}

# Install applications using apt
function install_apt_packages {
  packages=$(read_pkglist "linux-packages");
  pkg_count=$(lcount "$packages");
  log "Installing ${pkg_count} packages via apt";
  sudo apt -qq update;
  sudo apt -qq install --dry-run -y $packages;
  log "Finished installing packages via apt";
}

add_apt_sources
pre_install_cleanup
install_apt_packages

function install_snaps {
  packages=$(read_pkglist "linux-snaps");
  pkg_count=$(count $packages);
  pkg_count=$(echo "$packages" | wc -l);
  log "Installing ${pkg_count} snaps via snapd";
  for pkg in $packages; do
    sudo snap install $pkg;
  done;
  log "Finished installing snaps";
}

install_snaps
