#!/bin/bash

######################################################################
# @author      : Giancarlo Aparicio
# @created     : mar 07 feb 2023 20:36:10 -05
#
# @description : Script que te genera una lista de templates para ejecutar plataformas con Docker
# @Status      : Cancelado
######################################################################

BLUE="\033[0;34m"  # Blue
ENDCOLOR="\033[0m" # Final de un color

show_help() {
	echo -e "Menu de ayuda, los comandos disponibles son: \n"
	echo -e "     -h: Mostrar ayuda."
	echo -e "     -l: Mostrar lista de todos los templates disponibles."
	echo -e "     -t: Seleccionar un template y aplicarlo."

}

show_list() {
	echo -e "$BLUE $(ls -lrt ~/.oh-my-zsh/custom/files/docker | sed '1d' | awk '{print $NF}') $ENDCOLOR"
}

run_template() {
	template=$1

	cp -r -u -v ~/.oh-my-zsh/custom/files/docker/$template/* ./
}

while getopts "hlt:" flag; do
	case "${flag}" in
	h)
		show_help
		exit 0
		;;

	l)
		show_list
		exit 0
		;;

	t)
		template=${OPTARG}
		[ -z "${template}" ] && echo -e "Flag -t necesita el nombre de un template." && exit 1
		run_template $template
		exit 0
		;;

	esac
done

show_help
