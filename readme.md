# Gideon's Dotfiles

> Look upon my ~works~ dotfiles, ye Mighty, and despair!

These probably won't stand the test of time, but these dotfiles are for
setting up my personal environment on Linux and macOS machines. Since I
now use Linux as my daily driver and almost never touch macOS, I can't
guarantee everything will still work in the Apple ecosystem.

## Repository Structure

Each configuration group (which normally corresponds to a particular
service or application) is contained within a root-level folder. All the
configuration files for that group are contained therein.

There is a Makefile at the root of the repository which will create all
the necessary symlinks. This assumes that your system will obey the XDG
conventions for the most part. Applications I know do not will have
their configurations symlinked appropriately.

## Usage

Clone this repository into a suitable location (e.g. `~/dotfiles`):

    git clone https://github.com/gfarrell/dotfiles.git ~/dotfiles

Make symlinks:

    cd ~/dotfiles && make symlinks

## Repository Contents

[Firejail](https://firejail.wordpress.com/) (Linux only): used to
control the access of certain applications to parts of the filesystem. I
primarily use this to constrain Firefox's access as the web browser is a
major vulnerability in my system.

[Git](https://git-scm.com/): contains config and shortcuts for the git
version-control system.

[i3](i3wm.org/) (Linux only): I use `i3-gaps` as my window manager (for
X) on Linux.

init: DEPRECATED

iterm2: DEPRECATED

[jrnl](https://jrnl.sh/): CLI journal application which I use to
occasionally journal and record dreams.

[karabiner](https://karabiner-elements.pqrs.org/): keyboard-remapping
utility for macOS (for Linux I just set this in X11 conf).

[khal](https://github.com/pimutils/khal): CLI calendar application,
all calendar configuration is in here. Calendars are stored in
`~/calendars`.

[khard](https://github.com/scheibler/khard): CLI address book,
all address book configuration is in here. Contacts are stored in
`~/contacts`.

[kitty](https://sw.kovidgoyal.net/kitty/): this is my terminal emulator,
completely configurable using a single file.

[libinput-gestures](https://github.com/bulletmark/libinput-gestures): I
don't really use gestures anymore, so this is unused. DEPRECATING.

linux-scripts: various linux scripts go in here, including things which
liare more ke systemd services which run continuously (like backups),
liand things I run discretely.

[(neo)mutt](https://neomutt.org/): I use neomutt instead of mutt as my
mail client. Not *all* the configuration is yet in here as I need to
remove some private data from some of it, but it's mostly here (accounts
and signatures are gitignored but this is probably unnecessary).

[neovim](https://neovim.io/): 💖 I love (neo)vim 💖 -- my editor of
choice, contains all my configuration, including the currently used
version of vim-plug which is a plugin-loading system, and the settings
for CoC which is a semantically aware autocompleter.

[picom](https://github.com/yshui/picom): compositor for X11, my config
in here just does things like handles transparency and shadows on
windows.

[polybar](https://github.com/polybar/polybar): UI bar for X11 which is
compatible with i3. This has both a config file and a launch script to
manage the different processes, especially useful as autorandr needs to
launch the right polybar instances when I add or remove monitors.

[rofi](https://github.com/davatorium/rofi): launcher for X11
(not compatible with wayland), quite extensible, e.g. with my
[rofi-khard](https://github.com/gfarrell/rofi-khard) integration.

systemd: contains various systemd units and timers, e.g. for email /
calendar / contacts sync, backups, etc..

[task](https://taskwarrior.org/): CLI task management application,
contains basic config.

[tmux](https://github.com/tmux/tmux): terminal multiplexer config, I use
`tpm` for managing plugins. Now that I have a tiling window manager this
isn't used as much.

[tridactyl](https://github.com/tridactyl/tridactyl): VIM-like command
interface for Firefox. Really powerful. This config file is currently
not used though, as it would require giving tridactly-native filesystem
access. I need to write a firejail profile to allow this to happen
safely but I have not got around to it.

xorg: all my X11 config files -- these aren't really dotfiles but they
need to be copied to the `/etc/X11` directory. These are for input /
output settings like mapping caps-lock to escape. The only dotfile in
there is `xprofile`.

[zathura](https://pwmt.org/projects/zathura/): VIM-like document viewer,
has a simple config file.

zsh: various bits of shell and environment config. The two files in here
which are sourced *by* zsh itself are zshrc and zshenv, the rest are
sourced by my zshrc file.

Brewfile: this is a list of applications and utilities installed by
[homebrew](https://brew.sh) on macOS.

editorconfig: generic editor configuration supported by many editors.

eslintrc: not sure what this is doing here!
