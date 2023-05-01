#!/bin/bash

GREEN="\033[0;32m" # Green
RED="\033[0;31m"   # Red
CYAN="\033[0;36m"  # Cyan
ENDCOLOR="\033[0m" # Final de un color
OS=$(uname -o)

if [ "${OS}" == "Android" ]; then
    which gh >/dev/null 2>&1 || (
        pkg install gh
    )
else
    which gh >/dev/null 2>&1 || (
        sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
        sudo apt-add-repository https://cli.github.com/packages
        sudo apt update
        sudo apt install gh
    )
fi

which ghs >/dev/null 2>&1 || (
    npm install -g gh-search-cli
)

TOKEN=./token.txt

if [[ ! -f "$TOKEN" ]]; then
    read -p "${CYAN} Enter to token: ${ENDCOLOR} " token
    echo $token >$TOKEN
fi

gh auth login --with-token <$TOKEN

ghs config --token=$(cat $TOKEN)

#-------------------------------------------------------------------
# Config
gh config set git_protocol ssh
gh config set editor nvim
