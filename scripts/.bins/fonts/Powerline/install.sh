#!/bin/bash

sudo apt install powerline fonts-powerline -y

sudo git clone https://github.com/powerline/powerline.git ~/powerline

sudo cp -r ~/powerline/powerline/config_files ~/.config/powerline

if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]
then
	source /usr/share/powerline/bindings/bash/powerline.sh
fi

sudo rm -r ~/powerline

