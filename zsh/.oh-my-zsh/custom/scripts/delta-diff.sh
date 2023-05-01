#!/bin/bash

######################################################################
# @author      : Giancarlo Aparicio
# @created     : mar 07 feb 2023 20:34:26 -05
#
# @description : Compara 2 archivos y muestra las diferencias, se emplea cuando los alias no se pueden usar por temas de SHELL
######################################################################

delta --dark --line-numbers --navigate --tabs 4 --syntax-theme 'Monokai Extended' \
	--file-style='brightyellow' --minus-style='syntax #750000' \
	--minus-emph-style='syntax #c71a1a' --plus-style='syntax #01573f' \
	--plus-emph-style='syntax #198c6c' "$@"
