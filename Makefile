DIR=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
SYS=$(shell uname -a | cut -d ' ' -f 1)
CONFIG_HOME := ~/.config
LOCAL_BIN := ~/.local/bin
SYS_BIN := /usr/local/bin
USER_SYSTEMD := $(CONFIG_HOME)/systemd/user

.PHONY: linux symlinks linux-scripts systemd

linux: symlinks systemd

symlinks:
	ln -nsf $(DIR)/zsh/zsh ~/.zsh
	ln -sf $(DIR)/zsh/zshenv ~/.zshenv
	ln -sf $(DIR)/zsh/zshrc ~/.zshrc
	ln -sf $(DIR)/git/gitconfig ~/.gitconfig
	ln -sf $(DIR)/git/gitignore_globals ~/.gitignore_globals
	ln -sf $(DIR)/psql/psqlrc ~/.psqlrc
	ln -sf $(DIR)/editorconfig ~/.editorconfig
	ln -sf $(DIR)/eslintrc ~/.eslintrc
	ln -sf $(DIR)/task/taskrc ~/.taskrc
	ln -nsf $(DIR)/karabiner ~/.config/karabiner
	ln -nsf $(DIR)/jrnl ~/.config/jrnl
	ln -nsf $(DIR)/kitty ~/.config/kitty
        ln -nsf $(DIR)/alacritty ~/.config/alacritty
	ln -nsf $(DIR)/neovim ~/.config/nvim
	ln -nsf $(DIR)/tmux ~/.tmux
	ln -nsf $(DIR)/tmux/tmux.conf ~/.tmux.conf
	ln -nsf $(DIR)/khard ~/.config/khard
	ln -nsf $(DIR)/khal ~/.config/khal
	ln -nsf $(DIR)/haskell/ghci.conf ~/.ghc/ghci.conf
	ln -nsf $(DIR)/emacs ~/.emacs.d
ifeq ($(SYS), Linux)
	ln -sf $(DIR)/libinput-gestures/libinput-gestures.conf ~/.config/libinput-gestures.conf
	ln -sf $(DIR)/xorg/xprofile ~/.xprofile
	ln -sf $(DIR)/xorg/xinitrc ~/.xinitrc
	ln -nsf $(DIR)/i3 ~/.config/i3
	ln -nsf $(DIR)/polybar ~/.config/polybar
	ln -nsf $(DIR)/rofi ~/.config/rofi
	ln -nsf $(DIR)/mutt ~/.config/mutt
	ln -nsf $(DIR)/picom ~/.config/picom
	ln -nsf ${DIR}/firejail ~/.config/firejail
endif

$(USER_SYSTEMD):
	mkdir -p $@

$(USER_SYSTEMD)/%: $(USER_SYSTEMD) $(DIR)/systemd/$(*)
	ln -nsf $(DIR)/systemd/$(*) $(CONFIG_HOME)/systemd/user/$(*)

$(LOCAL_BIN):
	mkdir -p $@

$(LOCAL_BIN)/%: $(LOCAL_BIN) $(DIR)/linux-scripts/user/$(*)
	ln -nsf $(DIR)/linux-scripts/user/$(*) $(LOCAL_BIN)/$(*)

$(SYS_BIN):
	sudo mkdir -p $@

$(SYS_BIN)/%: $(SYS_BIN) $(DIR)/linux-scripts/sys/$(*)
	sudo ln -nsf $(DIR)/linux-scripts/sys/$(*) $(SYS_BIN)/$(*)

linux-scripts: $(LOCAL_BIN)/run-backup $(LOCAL_BIN)/restore-files $(LOCAL_BIN)/nextcloud-sync $(LOCAL_BIN)/new-screen-setup $(SYS_BIN)/take-snapshot $(SYS_BIN)/mount-backup-drive

# x11-autostart target is started by i3 automatically -- replaces the
# xdg-autostart applications from the FreeDesktop specification.
$(USER_SYSTEMD)/x11-autostart.target.wants/%: linux-scripts $(USER_SYSTEMD) $(USER_SYSTEMD)/x11-autostart.target
	systemctl --user add-wants x11-autostart.target $(DIR)/systemd/$(*)

# systemd user services are linked into the USER_SYSTEMD directory via systemctl
$(USER_SYSTEMD)/%: $(USER_SYSTEMD) $(DIR)/systemd/$(*)
	systemctl --user enable $(DIR)/systemd/$(*)

systemd: linux-scripts $(USER_SYSTEMD)/geoclue2.service $(USER_SYSTEMD)/geoclue2.timer $(USER_SYSTEMD)/mbsync.service $(USER_SYSTEMD)/mbsync.timer $(USER_SYSTEMD)/vdirsyncer.service $(USER_SYSTEMD)/vdirsyncer.timer $(USER_SYSTEMD)/nextcloud-sync.service $(USER_SYSTEMD)/nextcloud-sync.timer $(USER_SYSTEMD)/duplicity.service $(USER_SYSTEMD)/duplicity.timer $(USER_SYSTEMD)/redshift-gtk.service $(USER_SYSTEMD)/playerctld.service $(USER_SYSTEMD)/ssh-agent.service $(USER_SYSTEMD)/dropbox.service $(USER_SYSTEMD)/keepassxc.service $(USER_SYSTEMD)/mullvad-vpn.service $(USER_SYSTEMD)/iwgtk-indicator.service $(USER_SYSTEMD)/x11-autostart.target
	systemctl --user daemon-reload
	systemctl --user add-wants x11-autostart.target dropbox.service
	systemctl --user add-wants x11-autostart.target redshift-gtk.service
	systemctl --user add-wants x11-autostart.target keepassxc.service
	systemctl --user add-wants x11-autostart.target mullvad-vpn.service
	systemctl --user add-wants x11-autostart.target iwgtk-indicator.service
	systemctl --user enable mbsync.timer vdirsyncer.timer nextcloud-sync.timer duplicity.timer geoclue2.timer playerctld.service ssh-agent.service
	systemctl --user start mbsync.timer vdirsyncer.timer nextcloud-sync.timer duplicity.timer geoclue2.timer playerctld.service ssh-agent.service
	sudo systemctl enable $(DIR)/systemd/backup-snapshots.service $(DIR)/systemd/backup-snapshots.timer
	sudo systemctl enable $(DIR)/systemd/freshclam.service $(DIR)/systemd/freshclam.timer
	sudo systemctl add-wants timers.target freshclam.timer
	sudo systemctl add-wants timers.target backup-snapshots.timer
	sudo systemctl start timers.target
