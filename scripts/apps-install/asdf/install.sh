#!/bin/bash

sudo apt install -y curl wget gnupg2

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --depth 1

echo "Copy and paste to .zshrc"
echo "source $HOME/.asdf/asdf.sh"
echo "source $HOME/.asdf/completions/asdf.bash"
