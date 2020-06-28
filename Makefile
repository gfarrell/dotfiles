DIR=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
SYS=$(shell uname -a | cut -d ' ' -f 1)

.PHONY: macos linux symlinks brew apt

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
endif

brew:
	command -v brew > /dev/null 2>&1 || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew update
	brew tap homebrew/bundle || echo ''
	brew upgrade
	brew bundle -v

apt:
	sh $(DIR)/init/linux.sh
