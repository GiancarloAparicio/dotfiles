#!/bin/bash

# curl -fsSL https://get.docker.com -o get-docker.sh
# sh get-docker.sh

install() {
    echo $@ | xargs -n 1 sudo apt install --fix-missing -y
}

sudo apt update && sudo apt upgrade -y

#-------------------------------------------------------------------
# Install dependencies
install python3 python3-pip python3-dev libffi-dev libssl-dev apt-transport-https ca-certificates curl gnupg lsb-release gnupg-agent software-properties-common

sudo add-apt-repository "deb [arch=$(dpkg --print-architecture | tr '[:upper:]' '[:lower:]')] https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]') $(lsb_release -cs | tr '[:upper:]' '[:lower:]') stable"

sudo apt update

sudo apt install -y docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker ${USER}
sudo chmod 666 /var/run/docker.sock

#-------------------------------------------------------------------
# Install Docker-compose
# sudo pip3 install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.5.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
