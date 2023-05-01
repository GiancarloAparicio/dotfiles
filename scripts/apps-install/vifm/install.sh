#!/bin/bash

######################################################################
# @author      : Giancarlo Aparicio
# @file        : install
# @created     : domingo abr 04, 2021 10:31:45 -05
#
# @description : Description
######################################################################

which vifm >/dev/null 2>&1 ||
    apt install -y vifm

which ffmpegthumbnailer >/dev/null 2>&1 ||
    apt install -y ffmpegthumbnailer

which imagemagick >/dev/null 2>&1 || which display >/dev/null 2>&1 ||
    apt install imagemagick

which pdftotext >/dev/null 2>&1 || which pdftoppm >/dev/null 2>&1 ||
    apt install -y poppler-utils

which ueberzug >/dev/null 2>&1 || (
    apt install -y libjpeg8-dev zlib1g-dev python-dev python3-dev
    pip3 install ueberzug
)

mkdir -p $HOME/.config/vifm/scripts/
cp -r ./scripts/* $HOME/.config/vifm/scripts/

echo -e "${GREEN} Agregar $HOME/.config/vifm/scripts a su $PATH ${ENDCOLOR}}"
