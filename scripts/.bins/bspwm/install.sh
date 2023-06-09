#!/bin/bash

CYAN="\033[0;36m"  # Cyan
RED="\033[0;31m"   # Red
ENDCOLOR="\033[0m" # Final de un color

repo="$(pwd)"
home="$(echo $HOME)"

#sudo apt update && sudo apt upgrade -y
pip3 install pyaudio
pip install SpeechRecognition
pip3 install edge-tts
pip3 install argostranslate
pip install brotab
pip3 install brotab
pip install justext
pip3 install justext
brotab install

install() {
    echo $@ | xargs -n 1 sudo apt install --fix-missing -y
}

#-------------------------------------------------------------------
# Install dependencies
install portaudio19-dev lxpolkit suckless-tools xdo network-manager tesseract-ocr imagemagick scrot tesseract-ocr-spa xsel xdg-open polybar flameshot redshift arc-theme papyrus-icon-theme breeze-cursor-theme compton rofi dunst python3-packaging python-xcbgen xdotool sxhkd feh clang python3 git build-essential vim neovim xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev libuv1-dev libuv1 cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libpulse-dev libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev  meson libxext-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-present-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev libxcb-glx0-dev bison flex libstartup-notification0-dev check autotools-dev libpango1.0-dev librsvg2-bin librsvg2-dev libglib2.0-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev

#-------------------------------------------------------------------
# Config bspwm and sxhkd
echo -e "${CYAN}Create bspwm${ENDCOLOR}"
pip3 install pyperclip

# Install bspwm
git clone --depth 1 https://github.com/baskerville/bspwm.git repo-bspwm
cd repo-bspwm
make
sudo make install
cd ..
sudo rm -r -f repo-bspwm

# Install sxhkd
git clone --depth 1 https://github.com/baskerville/sxhkd.git repo-sxhkd
cd repo-sxhkd
make
sudo make install
cd ..
sudo rm -r -f repo-sxhkd

# Install polybar
git clone --recursive https://github.com/polybar/polybar repo-polybar
cd repo-polybar
mkdir build
cd build
cmake ..
make -j$(nproc)
sudo make install
cd ../..
sudo rm -r -f repo-polybar

# Install picom
git clone --depth 1 https://github.com/ibhagwan/picom.git repo-picom
cd repo-picom
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install
cd ..
sudo rm -r -f repo-picom

sudo mkdir -p /opt/{wallpapers,simple,fonts}

#-------------------------------------------------------------------
# Install polybar themes
git clone --depth=1 https://github.com/adi1090x/polybar-themes.git ~/polybar-themes
cd ~/polybar-themes
chmod +x setup.sh
bash setup.sh
sudo rm -r -f ~/polybar-themes

#-------------------------------------------------------------------
# Install bsp-layout
TMP_DIR=$(mktemp -d /tmp/bsp-layout-install.XXXXX)

## Clone to local directory
if [[ ! "$1" == "local" ]]; then
    git clone https://github.com/phenax/bsp-layout.git $TMP_DIR
    cd $TMP_DIR
fi

sudo make install || exit 1

# Check for dependencies
for dep in bc bspc; do
    !(which $dep >/dev/null 2>&1) && echo "[Missing dependency] bsp-layout needs $dep installed"
done

echo "Elegir color:"
bash ~/.config/polybar/shapes/scripts/color-switch.sh
echo "Elegir diseño:"
bash ~/.config/polybar/shapes/scripts/style-switch.sh


exit 0
