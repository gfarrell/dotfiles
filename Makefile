DIR=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
SYS=$(shell uname -a | cut -d ' ' -f 1)
CONFIG_HOME := ~/.config
LOCAL_BIN := ~/.local/bin
SYS_BIN := /usr/local/bin
USER_SYSTEMD := $(CONFIG_HOME)/systemd/user
SYS_SYSTEMD := /etc/systemd/system

.PHONY: linux symlinks linux-scripts systemd user-systemd-all system-systemd-all

linux: symlinks systemd

symlinks:
	ln -nsf $(DIR)/zsh ~/.config/zsh
	ln -sf $(DIR)/zsh/zshenv ~/.zshenv
	ln -sf $(DIR)/git/gitconfig ~/.gitconfig
	ln -sf $(DIR)/git/gitignore_globals ~/.gitignore_globals
	ln -sf $(DIR)/psql/psqlrc ~/.psqlrc
	ln -sf $(DIR)/editorconfig ~/.editorconfig
	ln -sf $(DIR)/eslintrc ~/.eslintrc
	ln -sf $(DIR)/task/taskrc ~/.taskrc
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
	ln -nsf $(DIR)/helix ~/.config/helix
ifeq ($(SYS), Linux)
	ln -sf $(DIR)/libinput-gestures/libinput-gestures.conf ~/.config/libinput-gestures.conf
	ln -sf $(DIR)/xorg/xprofile ~/.xprofile
	ln -sf $(DIR)/xorg/xinitrc ~/.xinitrc
	ln -sf $(DIR)/xorg/XCompose ~/.XCompose
	ln -sf $(DIR)/xorg/Xresources ~/.Xresources
	ln -nsf $(DIR)/i3 ~/.config/i3
	ln -nsf $(DIR)/polybar ~/.config/polybar
	ln -nsf $(DIR)/rofi ~/.config/rofi
	ln -nsf $(DIR)/mutt ~/.config/mutt
	ln -nsf $(DIR)/picom ~/.config/picom
	ln -nsf ${DIR}/firejail ~/.config/firejail
	ln -nsf ${DIR}/fontconfig ~/.config/fontconfig
	ln -nsf $(DIR)/ranger ~/.config/ranger
	ln -nsf $(DIR)/aerc ~/.config/aerc
	ln -nsf $(DIR)/vdirsyncer ~/.config/vdirsyncer
	ln -nsf $(DIR)/dunst ~/.config/dunst
endif

$(USER_SYSTEMD):
	mkdir -p $@

$(USER_SYSTEMD)/%: $(USER_SYSTEMD) $(DIR)/systemd/$(*)
	ln -nsf $(DIR)/systemd/$(*) $(CONFIG_HOME)/systemd/user/$(*)
	systemctl --user daemon-reload
	systemctl --user enable $(*)

$(SYS_SYSTEMD):
	mkdir -p $@

$(SYS_SYSTEMD)/%: $(SYS_SYSTEMD) $(DIR)/systemd/$(*)
	sudo cp $(DIR)/systemd/$(*).{service,timer} /etc/systemd/system/
	sudo systemctl enable $(*).service $(*).timer
	sudo systemctl add-wants timers.target $(*).timer
	sudo systemctl daemon-reload
	sudo systemctl start timers.target

$(LOCAL_BIN):
	mkdir -p $@

$(LOCAL_BIN)/%: $(LOCAL_BIN) $(DIR)/linux-scripts/user/$(*)
	ln -nsf $(DIR)/linux-scripts/user/$(*) $(LOCAL_BIN)/$(*)

$(SYS_BIN):
	sudo mkdir -p $@

$(SYS_BIN)/%: $(SYS_BIN) $(DIR)/linux-scripts/sys/$(*)
	sudo ln -nsf $(DIR)/linux-scripts/sys/$(*) $(SYS_BIN)/$(*)

linux-scripts:  $(LOCAL_BIN)/move-i3-workspace.sh \
		$(LOCAL_BIN)/run-backup \
		$(LOCAL_BIN)/restore-files \
		$(LOCAL_BIN)/nextcloud-sync \
		$(LOCAL_BIN)/email-sync \
		$(SYS_BIN)/take-snapshot \
		$(SYS_BIN)/mount-backup-drive

user-systemd-all: linux-scripts \
		  $(USER_SYSTEMD)/mbsync.service $(USER_SYSTEMD)/mbsync.timer \
		  $(USER_SYSTEMD)/vdirsyncer.service $(USER_SYSTEMD)/vdirsyncer.timer \
		  $(USER_SYSTEMD)/nextcloud-sync.service $(USER_SYSTEMD)/nextcloud-sync.timer \
		  $(USER_SYSTEMD)/duplicity.service $(USER_SYSTEMD)/duplicity.timer \
		  $(USER_SYSTEMD)/redshift-gtk.service \
		  $(USER_SYSTEMD)/dropbox.service \
		  $(USER_SYSTEMD)/playerctld.service \
		  $(USER_SYSTEMD)/ssh-agent.service \
		  $(USER_SYSTEMD)/keepassxc.service \
		  $(USER_SYSTEMD)/mullvad-vpn.service \
		  $(USER_SYSTEMD)/iwgtk-indicator.service \
		  $(USER_SYSTEMD)/x11-autostart.target
	systemctl --user add-wants x11-autostart.target redshift-gtk.service
	systemctl --user add-wants x11-autostart.target keepassxc.service
	systemctl --user add-wants x11-autostart.target mullvad-vpn.service
	systemctl --user add-wants x11-autostart.target iwgtk-indicator.service
	systemctl --user start mbsync.timer vdirsyncer.timer nextcloud-sync.timer duplicity.timer playerctld.service ssh-agent.service

system-systemd-all: linux-scripts $(SYS_SYSTEMD)/freshclam $(SYS_SYSTEMD)/backup-snapshots

systemd: user-systemd-all system-systemd-all
