#!/bin/bash

######################################################################
# @author      : Giancarlo Aparicio
# @created     : mar 07 feb 2023 21:02:53 -05
#
# @description : Busca directorios en el sistema y abre la carpeta
######################################################################

file=$(~/.local/share/zinit/plugins/sharkdp---fd/fd/fd --follow -E '{**/node_modules,/vendor,.cache,src/vendor,**/*.org,**/*.com,**/honnef.co,**/cache,**/.vscode,**/tags,**/tags.*,**/.git,**/🧠 Cerebro digital}'  -t d | sort | rofi -drun-use-desktop-cache -show -dmenu -i -p "File" -markup-rows 5 -theme Arc-Dark)

if [ "$file" ]; then
    echo "Files: $file"
    nautilus "$file"
else
    exit 0
fi
