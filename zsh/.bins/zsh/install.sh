#!/bin/bash

GREEN="\033[0;32m" # Green
CYAN="\033[0;36m"  # Cyan
ENDCOLOR="\033[0m" # Final de un color
OS=$(uname -o)

install() {
    if [[ "$@" =~ .*\..* ]]; then
        flatpak install flathub -y --noninteractive $@
    else
        echo $@ | xargs -n 1 sudo apt install -y
    fi
}

sudo apt update -y && sudo apt full-upgrade -y

#-------------------------------------------------------------------
# Install dependencies
install neofetch stow rsync apache2-utils entr rustc cargo zsh-autosuggestions  jq gitflow-avh git-flow neovim mupdf-tools nodejs calibre golang-go iproute2 xtrlock openssh-server openssh-client scrcpy fonts-noto-color-emoji ccze adb android-tools-adb android-tools-fastboot android-libadb xsel git-delta python3 python3-pip git lsof tree wget at re2c sox gh file libsox-fmt-all pdfgrep silversearcher-ag

go get github.com/yudai/gotty

pip3 install notify
pip3 install pydub
pip3 install pyftpdlib
pip3 install termgraph
pip3 install bpytop --upgrade


cargo install bottom 
cargo install tealdeer 
cargo install du-dust 
cargo install procs
cargo install zoxide 
cargo install skim
cargo install ouch 
cargo install sd
cargo install dufs


tldr --update

if [ ! -x "$(command -v zsh)" ]; then
	echo "Instalando zsh"
	install zsh
	sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	chsh -s $(which zsh)
	#chsh -s zsh
fi

which tldr >/dev/null 2>&1 ||
	npm install -g tldr

#-------------------------------------------------------------------
# Install ansible
(pip3 &>/dev/null install ansible &)

#------------------------------------------------------------------
# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

#-------------------------------------------------------------------
# Install plugins
if ! [ -x "$(command -v zinit)" ]; then
	ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone --depth=1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

mv $HOME/.zshrc $HOME/.zshrc.bak.$(date +%Y.%m.%d-%H:%M:%S)
cp .zshrc $HOME/.zshrc

#------------------------------------------------------------------
# Install gh cli
install_github_cli() {
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
	sudo apt update
	sudo apt install -y gh
}

#-------------------------------------------------------------------
# If , updating files
if [ $OS == "Android" ]; then
	PATH_SOURCE="$HOME/.oh-my-zsh/custom/source"

	sentences=(
		"s/xclip -selection c -o/termux-clipboard-get /g"
		"s/xclip -selection c/termux-clipboard-set /g"
		"s/_get-all-service \"| grep -v ' active ' \" /_get-all-service/g"
		"s/_get-all-service \"| grep ' active ' \" /_get-all-service/g"
		"s/xdg-open/termux-open /g"
		"s/ \/etc/ \$PREFIX\/etc/g"
		"s/search -V -Z -v /search /g"
	)

	for change in "${sentences[@]}"; do
		find $PATH_SOURCE -name *.zsh -exec sed -i "$change" {} \;
	done

	cp -r ./termux ~/.termux
	git config --global core.checkStat minimal

	echo -e "Change font? :  font"
	echo -e "Change color? :  color"

else
	sudo curl -L https://raw.githubusercontent.com/Bash-Projects/rclonesync-V2/master/rclonesync.py -o /usr/local/bin/rclonesync && sudo chmod +x /usr/local/bin/rclonesync
	rm ~/.oh-my-zsh/custom/source/termux.zsh
	install_github_cli
fi

# Valida si una variable contiene un substring
contains() {
	string="$1"
	substring="$2"
	if test "${string#*$substring}" != "$string"; then
		echo "true"
	else
		echo "false"
	fi
}

# Active fonts
sudo rm /etc/fonts/conf.d/70-no-bitmaps.conf
sudo ln -s /etc/fonts/conf.avail/70-yes-bitmaps.conf /etc/fonts/conf.d/70-yes-bitmaps.conf

# Configuration GitHub CLI
mkdir ~/.config/gh/
cp ./config.yml ~/.config/gh/
gh auth login
cd ~/.oh-my-zsh/custom/scripts
chmod +x *.sh
cd $HOME

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2

#-------------------------------------------------------------------
# Help if error
echo -e "${CYAN}Si el comando history es empty ejecutar:${ENDCOLOR}"
echo -e "${GREEN}chown $(hostname):$(whoami) ~/.zsh_history && chmod 660 ~/.zsh_history${ENDCOLOR}"

OS=$(uname -o)

curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash

if [[ "${OS}" == "Android" ]]; then
	cp -r .shortcuts ~/.shortcuts
	# Is termux
	echo '(&>/dev/null filebrowser -a 127.0.0.1 --noauth -p 8080  -r "$HOME/brain/🧠 Cerebro digital/300 - 🗄️ Resources/380 - 🗃️ Attachments" -c ~/.config/filebrowser -d ~/filebrowser.db &)' >~/.zprofile
else 
  install-apps() {
	  echo $@ | xargs -n 1 flatpak install flathub -y --noninteractive
  }

  install-apps com.sublimetext.three \
    com.github.coslyk.MoonPlayer \
    org.zealdocs.Zeal \
    org.gnome.Boxes \
    org.gnome.Gnote \
	com.github.jeromerobert.pdfarranger \
	com.sublimetext.three \
	md.obsidian.Obsidian \
	com.github.xournalpp.xournalpp \
	org.kde.okular \
	flathub org.zotero.Zotero \
	com.visualstudio.code \
	com.github.unrud.RemoteTouchpad \
	com.google.Chrome \
	org.telegram.desktop \
	com.github.tchx84.Flatseal \
	org.onlyoffice.desktopeditors \
	io.dbeaver.DBeaverCommunity \
	com.axosoft.GitKraken

  cp ./apps/* ~/.local/share/applications/
  mkdir -p /mnt/Drive 
  sudo chown $USER:$USER /mnt/Drive
  
  # Config RClone
  # rclone mount "Google Drive:" /mnt/Drive

fi

git config --global init.defaultBranch main
