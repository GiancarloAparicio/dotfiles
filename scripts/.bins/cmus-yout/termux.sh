#!/data/data/com.termux/files/usr/bin/bash

######################################################################
# @author      : Giancarlo Aparicio
# @file        : install
# @created     : jueves abr 01, 2021 21:51:25 -05
#
# @description : Instala cmus y ytmdl, luego descarga varios albunes de canciones
######################################################################

which cmus >/dev/null 2>&1 ||
    apt install -y cmus

which ytmdl >/dev/null 2>&1 ||
    pip3 install ytmdl

music=./playlist
list_music=$(ls $music)

for albun in $list_music; do
    ytmdl --format m4a --trim --title-as-name --ignore-errors --disable-file --list $albun
done
