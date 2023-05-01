#!/bin/bash

install() {
        echo $@ | xargs -n 1 sudo apt install --fix-missing -y
}

sudo apt update && sudo apt upgrade -y

# Download, compile and install Alacritty
git clone --depth=1 https://github.com/jwilm/alacritty.git

cd alacritty

#-------------------------------------------------------------------
# Install dependencies
if [ ! -x "$(command -v rustc)" ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

install wl-clipboard cmake libfreetype6-dev python3 libfontconfig1-dev xclip cargo curl pkg-config libxcb-xfixes0-dev libxkbcommon-dev

#rustup override set stable
#rustup update stable

cargo build --release

#sudo tic -xe alacritty,alacritty-direct extra/alacritty.info

#infocmp alacritty

# Copy default config into home dir
mkdir -p $HOME/.config/alacritty/
cp ../alacritty.yml $HOME/.config/alacritty/alacritty.yml

# Create desktop file
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

sudo mkdir -p /usr/local/share/man/man1
gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null

cd ..
rm -r ./alacritty
