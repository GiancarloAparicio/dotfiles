#!/bin/bash

install() {
	echo "$@" | xargs -n 1 sudo apt install --fix-missing -y
}

#-------------------------------------------------------------------
# Install dependencies
install python3-venv python  golang sqlformat pdf2svg yamllint ruby-neovim universal-ctags ruby golang-go python3-html5lib python3 python3-pip nodejs npm neovim ctags ripgrep shfmt clang

if [ -x "$(command -v yarn)" ]; then
  npm install --global yarn
fi

if [ -x "$(command -v shfmt)" ]; then
  go install mvdan.cc/sh/v3/cmd/shfmt@latest
fi

if [ -x "$(command -v prettier)" ]; then
  yarn global add prettier @prettier/plugin-php 2>/dev/null
fi

if [ -x "$(command -v blade-formatter)" ]; then
  yarn global add blade-formatter 2>/dev/null
fi

pip3 install -r requirements.txt

# Install vim and neovim
cp .ctags ~/.ctags

bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) -y

