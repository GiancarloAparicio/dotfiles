#-------------------------------------------------------------------
# ZSH
alias grep="grep --color"
alias compress="ouch compress"
alias decompress="ouch decompress"
alias flatpak-install="flatpak install flathub -y --noninteractive"
alias docker-compose="docker compose"
alias remoteMouse="flatpak run com.github.unrud.RemoteTouchpad"
alias tty-share="gotty -a 0.0.0.0 -p 9000 -w --enable-webgl --reconnect --config ~/.gotty tmux new -A -s gotty zsh"
alias zz="compile"
alias merge-playground="bash ~/.oh-my-zsh/custom/scripts/merge.sh"
alias tn="temp-note"
alias dc="docker compose"
alias dip="docker-ip"
alias dps='docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Ports}}\t{{.Names}}" '
alias dud='docker compose up -d'
alias d-ps='docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Ports}}\t{{.Names}}" '
alias dlogs="docker-logs"
alias d-logs="docker-logs"
alias d-logs="docker-logs"
alias dexec="docker-exec"
alias d-exec="docker-exec"
alias dstart="docker-start"
alias d-start="docker-start"
alias dstop="docker-stop"
alias d-stop="docker-stop"
alias drestart="docker-restart"
alias d-restart="docker-restart"
alias logs="docker compose logs 2>&1 | less -R"
alias dbackup="docker-volume-backup"
alias d-backup="docker-volume-backup"
alias dbackup-named="docker-volume-named-backup"
alias d-backup-named="docker-volume-named-backup"
alias dbackup-restore="docker-volume-backup-restore"
alias d-backup-restore="docker-volume-backup-restore"
alias dbackup-named-restore="docker-volume-named-backup-restore"
alias d-backup-named-restore="docker-volume-named-backup-restore"
alias b="cd ~/brain"

alias d-remove-container="docker-remove-container"
alias dr-container="docker-remove-container"
alias d-remove-image="docker-remove-container"
alias dr-image="docker-remove-image"

alias get-ip="my-ip"
alias get-mac="my-mac"
alias ft="find-text"
alias s="apt search"
alias reader="calibre-server --enable-local-write  --trusted-ips=127.0.0.1  ~/brain/🧠\ Cerebro\ digital/300\ -\ 🗄️\ Resources/380\ -\ 🗃️\ Attachments/Library"
alias coder="code-server $(pwd)"
alias share="filebrowser -a 0.0.0.0 --noauth -p 8888  -r '$(pwd)' -c ~/.config/filebrowser"
alias share-webdav="dufs -b 0.0.0.0 -p 8080"
alias catn="$(which cat)"
alias watch-filef="tail -n 50 -f"
alias wf="watch-filef"
alias cat="bat"
alias cp="cp -r -u -v"
alias a='asdf'
alias c='clear'
alias e='exit'
alias atomic='mkdir -p ./{"particles","atoms","molecules","organisms","templates","pages"}'
alias keyboard-config='dpkg-reconfigure keyboard-configuration'


#Editors
alias n='fnvim'
alias vimdiff='nvim -d'
alias ns='nvim-ssh'
alias nano='nano -E'
alias vf='vif'

# SSH
alias ssh-connect='ssh -C -o TCPKeepAlive=yes -o ServerAliveInterval=60'
alias sc='ssh-connect'

#-------------------------------------------------------------------
# Function ZSH
alias kp='kill-proccess'


#-------------------------------------------------------------------
# FZF-ZSH
alias ff='ffile'


#-------------------------------------------------------------------
# Nmap
alias android='adb shell am start -a android.settings.HARD_KEYBOARD_SETTINGS; scrcpy -f -t --window-borderless'
alias nmap-scan='sudo nmap -p- -sS  --min-rate 5000 --open -vvv -n -Pn '
alias nmap-ping=' sudo nmap -n -sP'

#-------------------------------------------------------------------
# Asdf
alias a-install='asdf-install'
alias a-uninstall='asdf-uninstall'
alias a-add='asdf-add'
alias a-remove='asdf-remove'

alias a-list='asdf-list'

alias a-global='asdf-global'
alias a-shell='asdf-shell'
alias a-local='asdf-local'
alias a-env='asdf-env'

#-------------------------------------------------------------------
# Servicios
alias s-all="_get-all-service"
alias s-start="service-start"
alias s-stop="service-stop"
alias s-disable="service-disable"
alias s-restart="service-restart"
alias s-enable="service-enable"
alias s-status="service-status"
