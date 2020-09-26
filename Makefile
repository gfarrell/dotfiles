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
	ln -sf $(DIR)/jrnl/jrnl_config ~/.jrnl_config
	ln -nsf $(DIR)/kitty ~/.config/kitty
	ln -nsf $(DIR)/neovim ~/.config/nvim
	ln -nsf $(DIR)/tmux ~/.tmux
	ln -sf $(DIR)/tmux/tmux.conf ~/.tmux.conf
ifeq ($(SYS), Linux)
	ln -sf $(DIR)/libinput-gestures/libinput-gestures.conf ~/.config/libinput-gestures.conf
	ln -sf $(DIR)/xorg/xprofile ~/.xprofile
	ln -nsf $(DIR)/i3 ~/.config/i3
	ln -nsf $(DIR)/polybar ~/.config/polybar
	ln -nsf $(DIR)/rofi ~/.config/rofi
	ln -nsf $(DIR)/mutt ~/.config/mutt
	ln -nsf $(DIR)/picom ~/.config/picom
endif

linux-scripts:
	mkdir -p ~/.local/bin
	ln -nsf $(DIR)/linux-scripts/run-backup ~/.local/bin/run-backup

systemd: linux-scripts
	ln -nsf $(DIR)/systemd/geoclue2.service ~/.config/systemd/user/geoclue2.service
	ln -nsf $(DIR)/systemd/geoclue2.timer ~/.config/systemd/user/geoclue2.timer
	ln -nsf $(DIR)/systemd/mbsync.service ~/.config/systemd/user/mbsync.service
	ln -nsf $(DIR)/systemd/mbsync.timer ~/.config/systemd/user/mbsync.timer
	ln -nsf $(DIR)/systemd/vdirsyncer.service ~/.config/systemd/user/vdirsyncer.service
	ln -nsf $(DIR)/systemd/vdirsyncer.timer ~/.config/systemd/user/vdirsyncer.timer
	ln -nsf $(DIR)/systemd/duplicity.service ~/.config/systemd/user/duplicity.service
	ln -nsf $(DIR)/systemd/duplicity.timer ~/.config/systemd/user/duplicity.timer
	systemctl --user daemon-reload
	systemctl --user enable mbsync.timer vdirsyncer.timer duplicity.timer geoclue2.timer
	systemctl --user start mbsync.timer vdirsyncer.timer duplicity.timer geoclue2.timer

brew:
	command -v brew > /dev/null 2>&1 || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew update
	brew tap homebrew/bundle || echo ''
	brew upgrade
	brew bundle -v

apt:
	sh $(DIR)/init/linux.sh
