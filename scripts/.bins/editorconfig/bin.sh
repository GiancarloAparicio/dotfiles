#!/bin/bash

RED="\033[0;31m"          # Red
CYAN="\033[0;36m"         # Cyan
ENDCOLOR="\033[0m"        # Final de un color


#-------------------------------------------------------------------
# Functions
runEditorConfigGenerator() {
    sudo cp ~/editorconfig/templates/$1.editorconfig ./.editorconfig 2>/dev/null
}


#-------------------------------------------------------------------
# Execute

command=$1

command=${command:-common}

runEditorConfigGenerator $command  &&
    (

        echo -e "${CYAN}Editorconfig Generator: $command ${ENDCOLOR}"

    )||(

        listOptions="$(sudo ls ~/editorconfig/templates/ | grep .editorconfig | cut -d '.' -f 1)"

        echo -e "${RED}The allowed parameters are:${ENDCOLOR}"

        for option in $listOptions; do
            echo -e "${CYAN}   *$option${ENDCOLOR}"
        done

    )

