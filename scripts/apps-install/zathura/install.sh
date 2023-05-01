#!/bin/bash

sudo apt install --fix-missing -y zathura

sudo apt autoremove -y

xdg-mime default zathura.desktop application/pdf

mkdir ~/.config/latexmk

cp -r -u -v latexmkrc ~/.config/latexmk/latexmkrc

echo "Modo interactivo"
echo "latexmk -pdf -pvc main.tex"
