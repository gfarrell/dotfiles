DIR=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
SYS=$(shell uname -a | cut -d ' ' -f 1)

.PHONY: macos linux symlinks brew apt linux-scripts systemd

macos: symlinks brew

linux: symlinks apt

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
	ln -nsf $(DIR)/i3 ~/.config/i3
	ln -nsf $(DIR)/polybar ~/.config/polybar
	ln -nsf $(DIR)/rofi ~/.config/rofi
	ln -nsf $(DIR)/mutt ~/.config/mutt
	ln -nsf $(DIR)/picom ~/.config/picom
	ln -nsf ${DIR}/firejail ~/.config/firejail
endif

linux-scripts:
	mkdir -p ~/.local/bin
	ln -nsf $(DIR)/linux-scripts/run-backup ~/.local/bin/run-backup
	ln -nsf $(DIR)/linux-scripts/restore-files ~/.local/bin/restore-files
	ln -nsf $(DIR)/linux-scripts/take-snapshot ~/.local/bin/take-snapshot
	ln -nsf $(DIR)/linux-scripts/nextcloud-sync ~/.local/bin/nextcloud-sync
	ln -nsf $(DIR)/linux-scripts/new-screen-setup ~/.local/bin/new-screen-setup

systemd: linux-scripts
	ln -nsf $(DIR)/systemd/geoclue2.service ~/.config/systemd/user/geoclue2.service
	ln -nsf $(DIR)/systemd/geoclue2.timer ~/.config/systemd/user/geoclue2.timer
	ln -nsf $(DIR)/systemd/mbsync.service ~/.config/systemd/user/mbsync.service
	ln -nsf $(DIR)/systemd/mbsync.timer ~/.config/systemd/user/mbsync.timer
	ln -nsf $(DIR)/systemd/vdirsyncer.service ~/.config/systemd/user/vdirsyncer.service
	ln -nsf $(DIR)/systemd/vdirsyncer.timer ~/.config/systemd/user/vdirsyncer.timer
	ln -nsf $(DIR)/systemd/nextcloud-sync.service ~/.config/systemd/user/nextcloud-sync.service
	ln -nsf $(DIR)/systemd/nextcloud-sync.timer ~/.config/systemd/user/nextcloud-sync.timer
	ln -nsf $(DIR)/systemd/duplicity.service ~/.config/systemd/user/duplicity.service
	ln -nsf $(DIR)/systemd/duplicity.timer ~/.config/systemd/user/duplicity.timer
	ln -nsf $(DIR)/systemd/redshift.service ~/.config/systemd/user/redshift.service
	ln -nsf $(DIR)/systemd/playerctld.service ~/.config/systemd/user/playerctld.service
	systemctl --user daemon-reload
	systemctl --user enable mbsync.timer vdirsyncer.timer nextcloud-sync.timer duplicity.timer geoclue2.timer playerctld.service
	systemctl --user start mbsync.timer vdirsyncer.timer nextcloud-sync.timer duplicity.timer geoclue2.timer playerctld.service

brew:
	command -v brew > /dev/null 2>&1 || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew update
	brew tap homebrew/bundle || echo ''
	brew upgrade
	brew bundle -v

apt:
	sh $(DIR)/init/linux.sh
