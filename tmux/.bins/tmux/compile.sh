#!/bin/bash

install() {
	echo $@ | xargs -n 1 sudo apt install -y
}

sudo apt update && sudo apt upgrade -y

#-------------------------------------------------------------------
# Install dependencies
install automake build-essential pkg-config libevent-dev libncurses5-dev byacc bison

git clone --depth=1 https://github.com/tmux/tmux.git /tmp/tmux
cd /tmp/tmux
sh autogen.sh
./configure && make
sudo make install
cd -
rm -fr /tmp/tmux
