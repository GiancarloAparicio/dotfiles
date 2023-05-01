#!/bin/bash

GREEN="\033[0;32m" # Green
RED="\033[0;31m"   # Red
CYAN="\033[0;36m"  # Cyan
ENDCOLOR="\033[0m" # Final de un color

OS=$(uname -o)
REPO=$(pwd)

sudo apt update && sudo apt upgrade -y

install() {
  echo "$@" | xargs -n 1 sudo apt install -y
}

install libncurses5-dev libncursesw5-dev autoconf automake pkg-config libevent-dev tmux perl golang golang-go

bash ./compile.sh

pip install --user tmuxp


if ! [ -x "$(command -v smug)" ]; then
	git clone https://github.com/ivaaaan/smug.git ~/.smug
	cd ~/.smug
	go install
	cd
	rm -r -f ~/.smug
fi

#-------------------------------------------------------------------
# Tmux

DIR_TMUX=~/.tmux

# If exist directory then
if [[ -d "$DIR_TMUX" ]]; then
	git -C $DIR_TMUX pull
else
	git clone https://github.com/gpakosz/.tmux.git $DIR_TMUX
	cd $HOME
	ln -s -f ~/.tmux/.tmux.conf
fi

#-------------------------------------------------------------------
# Tmp

DIR_TMP=~/.tmux/plugins/tpm

# If exist directory then
if [[ -d "$DIR_TMP" ]]; then
	git -C $DIR_TMP pull
else
	mkdir -p ~/.tmux/plugins
	git clone https://github.com/tmux-plugins/tpm $DIR_TMP
fi

#-------------------------------------------------------------------
# Smug
mkdir -p ~/.config/smug
cd $REPO
cp ./smug/default.yml ~/.config/smug/default.yml
cp .tmux.conf.local ~/.tmux.conf.local

tmux source ~/.tmux.conf

echo -e "${GREEN}tmux${ENDCOLOR}"
echo -e "${GREEN}PREFIX + I: Installs new plugins from GitHub or any other git repository${ENDCOLOR}"
echo -e "${GREEN}PREFIX + u: Updates plugin(s)${ENDCOLOR}"
echo -e "${GREEN}PREFIX + alt + u: Uninstall plugin(s)${ENDCOLOR}"
