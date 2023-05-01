#!/bin/bash

CURRENT_USER="/home/$(whoami)"

install() {

	if [ -x "$(command -v apt)" ]; then
		echo $@ | xargs -n 1 sudo apt install --fix-missing -y
		return
	elif [ -x "$(command -v pacman)" ]; then
		echo $@ | xargs -n 1 sudo pacman -S
	fi
}

sudo apt update && sudo apt upgrade -y

#-------------------------------------------------------------------
# Install dependencies
install python python3 python3-pip build-essential libevent-dev libncurses5-dev byacc bison ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen libunibilium-dev libunibilium4 ruby

pip install setuptools
pip install --upgrade pynvim
pip3 install setuptools
pip3 install --upgrade pynvim
pip2 install --user --upgrade neovim
pip3 install --user --upgrade neovim

gem install neovim
npm install -g neovim

git clone https://github.com/neovim/neovim --depth 1 $CURRENT_USER/neovim-compile

cd $CURRENT_USER/neovim-compile

git checkout master


#Remove old build dir and .deps dir
rm -rf build/
rm -rf .deps/
make distclean

# Build and install neovim
sudo make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=/usr/local/"
sudo make install

echo "export PATH=\"$CURRENT_USER/.local/nvim/bin:\$PATH\""

sudo rm -f -r $CURRENT_USER/neovim-compile
