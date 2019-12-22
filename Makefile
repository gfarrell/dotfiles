# vim: set noexpandtab
DIR=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

init: osx symlinks brew nvm npm tpm

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
	ln -sf $(DIR)/karabiner ~/.config/karabiner
	ln -sf $(DIR)/jrnl/jrnl_config ~/.jrnl_config
	ln -sf $(DIR)/kitty ~/.config/kitty
	ln -sf $(DIR)/neovim ~/.config/nvim
	ln -sf $(DIR)/tmux ~/.tmux
	ln -sf $(DIR)/tmux/tmux.conf ~/.tmux.conf

brew:
	command -v brew > /dev/null 2>&1 || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	@brew update
	@brew tap homebrew/bundle || echo ''
	@brew upgrade
	brew bundle

osx:
	@sh $(DIR)/init/osx

LATEST_NODE="6"
nvm:
	[ -d ~/.nvm ] || git clone git@github.com:creationix/nvm.git ~/.nvm
	cd ~/.nvm && git pull
	NVM_DIR=~/.nvm source ~/.nvm/nvm.sh && nvm install $(LATEST_NODE) && nvm alias default $(LATEST_NODE)

npm: nvm
	NVM_DIR=~/.nvm source ~/.nvm/nvm.sh && npm install npm --global --silent
	NVM_DIR=~/.nvm source ~/.nvm/nvm.sh && npm install serve --global --silent
