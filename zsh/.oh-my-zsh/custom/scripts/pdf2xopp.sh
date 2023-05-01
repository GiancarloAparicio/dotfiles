#!/bin/bash

######################################################################
# @author      : Giancarlo Aparicio
# @created     : mar 07 feb 2023 20:38:46 -05
#
# @description : Script to convert pdf to xopp
# @Status      : Cancelado, actualmente Zotero ofrece una mejor solución
######################################################################

if [ $# -lt 2 ]; then
	echo 'Usage: ./pdf2xopp.sh input.pdf output.xopp'
	exit 1
fi

if [ -w "$2" ]; then
	echo "File $2 exists. Overwrite? y/n"
	read ANSWER
	case $ANSWER in
	[nN]) exit 1 ;;
	esac
fi

{
	echo "<?xml version=\"1.0\" standalone=\"no\"?>
<xournal creator=\"Xournal++ 1.1.0+dev\" fileversion=\"4\">
<title>Xournal++ document - see https://github.com/xournalpp/xournalpp</title>"

	numPages=$(mutool info "$1" | grep Pages: | sed 's/[^0-9]*//')
	for ((i = 1; i <= $numPages; i++)); do
		extra=""
		if [[ $i -lt 2 ]]; then
			extra="domain=\"absolute\" filename=\"$1\""
		fi
		width=$(mutool info -M "$1" $i | grep "Mediaboxes" -A 2 | grep "\[" | cut -d'[' -f2 | cut -d' ' -f4)
		height=$(mutool info -M "$1" $i | grep "Mediaboxes" -A 2 | grep "\[" | cut -d'[' -f2 | cut -d' ' -f5)
		echo "<page width=\"$width\" height=\"$height\">
<background type=\"pdf\" $extra pageno=\"$i\"/>
<layer/>
</page>"
	done
	echo "</xournal>"
} | gzip -c >"$2"
