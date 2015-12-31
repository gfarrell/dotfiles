DIR=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

symlinks:
	@ln -nsf $(DIR)/zsh/zsh ~/.zsh
	@ln -sf $(DIR)/zsh/zshenv ~/.zshenv
	@ln -sf $(DIR)/zsh/zshrc ~/.zshrc
	@ln -nsf $(DIR)/vim/vim ~/.vim
	@ln -sf $(DIR)/vim/vimrc ~/.vimrc
	@ln -nsf $(DIR)/vim/plugin ~/.vim/plugin
	@ln -sf $(DIR)/tmux/tmux.conf ~/.tmux.conf
	@ln -sf $(DIR)/git/gitconfig ~/.gitconfig
	@ln -sf $(DIR)/git/gitignore_globals ~/.gitignore_globals
	@ln -sf $(DIR)/psql/psqlrc ~/.psqlrc
	@ln -sf $(DIR)/editorconfig ~/.editorconfig
	@ln -sf $(DIR)/eslintrc ~/.eslintrc

brew:
	command -v brew > /dev/null 2>&1 || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	@brew update
	@brew tap homebrew/bundle || echo ''
	@brew upgrade
	brew bundle

LATEST_NODE="5"
nvm:
	[ -d ~/.nvm ] || git clone git@github.com:creationix/nvm ~/.nvm
	cd ~/.nvm && git pull
	NVM_DIR=~/.nvm source ~/.nvm/nvm.sh && nvm install $(LATEST_NODE) && nvm alias default $(LATEST_NODE)

npm: nvm
	NVM_DIR=~/.nvm source ~/.nvm/nvm.sh && npm install npm --global --silent
	NVM_DIR=~/.nvm source ~/.nvm/nvm.sh && npm install serve --global --silent

tpm:
	[ -d ~/.tmux/plugins/tpm ] || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	cd ~/.tmux/plugins/tpm && git pull
