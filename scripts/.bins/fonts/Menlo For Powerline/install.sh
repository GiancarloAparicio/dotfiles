#!/bin/bash

sudo git clone https://github.com/abertsch/Menlo-for-Powerline.git ~/Menlo-for-Powerline

cd ~/Menlo-for-Powerline

sudo mv "Menlo for Powerline.ttf" /usr/share/fonts/

sudo fc-cache -vf /usr/share/fonts/

sudo rm -r ~/Menlo-for-Powerline



