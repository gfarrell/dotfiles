# Gideon's Dotfiles

## Overview

This is designed to be installed using symlinks not by copying files into place.
It makes it easier to edit files and keep track of them. A `Makefile` governs the
creation of these symlinks, and you can install them using:

    make symlinks

The relevant configuration files are kept within folders in the main project
directory, with the exception of the `Brewfile`, which resides in the main
directory and is there to install all the software I use. You can do this by
running:

    make brew

The above command installs `homebrew`, taps the right taps, and then installs a
list of programmes and casks.

## TODO

- [ ] Create a cask and add it to the brewfile for the Haskell IDE Wrapper.
- [ ] Remove your vimrc configuration.
- [ ] Fix colours in the kitty configuration (black tmux bar).
- [ ] Review and clean up the osx defaults configuration.
- [ ] Prune iterm, task if no longer used.
- [ ] Cleanup ZSH configuration.
