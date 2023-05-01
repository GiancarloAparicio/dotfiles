#!/bin/bash

GREEN="\033[0;32m" # Green
CYAN="\033[0;36m"  # Cyan
ENDCOLOR="\033[0m" # Final de un color
IP="$(ifconfig | grep 192.168)"

if ! [ -x "$(command -v ssh)" ]; then
    apt install -y openssh-server
fi

apt autoremove -y && apt autoclean -y

ssh-keygen -t ecdsa -m PEM

echo -e "${GREEN}Ingrese su contraseña para conectarse remotamente${ENDCOLOR}"
passwd
sshd

cp config ~/.ssh/config

echo -e "${GREEN}Para conectarte usa el siguiente script:${ENDCOLOR}"
echo -e "${CYAN}ssh -p 8022 $(whoami)@${IP:13:13}${ENDCOLOR}"

chmod 600 ~/.ssh/config
