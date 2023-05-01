#!/bin/bash -e

sudo apt update && sudo apt-get upgrade

curl -fsSL https://get.docker.com -o get-docker.sh

sudo sh get-docker.sh

sudo usermod -aG docker ${USER}

sudo su - ${USER}

udo apt -y install libffi-dev libssl-dev python3-dev python3 python3-pip

sudo pip3 install docker-compose
