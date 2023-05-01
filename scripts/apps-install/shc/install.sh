#!/bin/bash

RED='\033[0;31m'   # Red
GREEN='\033[0;32m' # Green
ENDCOLOR='\033[0m' # Final de un color

OS=$(uname -o)

if [ "${OS}" == "Android" ]; then
    apt update && apt upgrade -y

    apt install coreutils gnupg -y

    which wget >/dev/null 2>&1 ||
        apt install wget -y

    # Make the sources.list.d directory
    DIRECTORIO="$PREFIX/etc/apt/sources.list.d"

    if [ ! -d "$DIRECTORIO" ]; then
        mkdir "$DIRECTORIO"
    fi

    # Write the needed source file
    file="$PREFIX/etc/apt/sources.list.d/rendiix.list"

    if [ ! -f "$file" ]; then
        echo "deb https://rendiix.github.io android-tools termux" >$PREFIX/etc/apt/sources.list.d/rendiix.list

        wget https://rendiix.github.io/rendiix.gpg -q --show-progress
        apt-key add rendiix.gpg
        apt update
    else
        echo -e "${GREEN}repo already installed\n ${ENDCOLOR}"
    fi

    # Validation installation
    if [ "$?" = 0 ]; then
        apt install shc -y
        echo -e "${GREEN}Done! shc successfully installed${ENDCOLOR}"
    else
        echo -e "${RED}Something wrong, please re run this script${ENDCOLOR}"
        exit 1
    fi
else
    which shc >/dev/null 2>&1 ||
        apt install shc -y

    echo -e "${GREEN}En caso de que la instalación produzca un error${ENDCOLOR}"
    echo -e "${GREEN}sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 23E7166788B63E1E${ENDCOLOR}"
fi
