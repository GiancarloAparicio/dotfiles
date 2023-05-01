#-------------------------------------------------------------------
# Aliases apt

install(){
    if [[ "$@" =~ '.*\..*' ]]; then
        flatpak install flathub -y --noninteractive $@
    else
        echo $@ | xargs -n 1 sudo apt install -y
    fi
}


alias i='install'

search(){
    dependencia=$( apt search $@ | _fzf-show --no-preview | awk '{ print $2}')

    [ -z "${dependencia}" ] && return
    install $dependencia
}

remove(){
    sudo apt remove --purge $@
    sudo apt purge $@
    return
}

auto-clean(){

    sudo apt autoremove -y
    sudo apt autoclean -y

    # Run in background next commands to avoid wait
    sudo apt update -y &
    sudo apt upgrade -y &
    sudo apt dist-upgrade -y &
    sudo apt full-upgrade -y &
    sudo apt autoremove -y &
    sudo apt autoclean -y &
    sudo apt clean -y &

    [ -d /var/cache/apt/archives/partial ] && sudo rm -rf /var/cache/apt/archives/partial/*

    [ -x "$(command -v yarn)" ] && yarn cache clean
    [ -x "$(command -v npm)" ] && npm cache clean --force
    [ -x "$(command -v go)" ] &&  go clean --modcache
    [ -x "$(command -v docker)" ] && docker image prune -f
    [ -x "$(command -v flatpak)" ] && flatpak update -y
}

update(){
    sudo apt update -y
    sudo apt dist-upgrade -y
    auto-clean
}
