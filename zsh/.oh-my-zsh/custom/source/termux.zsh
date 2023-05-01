# Alias termux
alias color="$HOME/.termux/colors.sh"
alias font="$HOME/.termux/fonts.sh"
alias debian='proot-distro login --termux-home --fix-low-ports debian'


# Backup & restore
termux-backup(){
    OS=$(uname -o)
    date=$(date '+%Y-%m-%d')

    if [[ "${OS}" == "Android" ]]; then
        # Is termux
        termux-setup-storage;
        cd $HOME/..
        mkdir -p /storage/E09C-0DE6/backups/$date

        tar -hzcf - --ignore-failed-read -C /data/data/com.termux/files ./home ./usr  | gzip | split -b 1500M - /storage/E09C-0DE6/backups/$date/termux_backup.tar.gz.
    else
        # Is not termux
        ssh -p 8022 root@127.0.0.1  "mkdir -p /storage/E09C-0DE6/backups/$date"
        ssh -p 8022 root@127.0.0.1 'tar -hzcf - --ignore-failed-read -C /data/data/com.termux/files ./home ./usr  | gzip' > termux_bakup_$date.tar.gz
    fi
}

termux-restore(){
    OS=$(uname -o)

    if [[ "${OS}" == "Android" ]]; then
        # Is termux
        termux-setup-storage
        cd $HOME/..

        tar -zxf /storage/E09C-0DE6/termux-backup.tar.gz -C /data/data/com.termux/files --recursive-unlink --preserve-permissions
    else
        # Is not termux
        ssh -p 8022 root@127.0.0.1  "mkdir -p /storage/E09C-0DE6/backups/"
    fi
}

export PATH=$PATH:$HOME/.local/bin

# Functions

distro() {
	cached=$DIR_CACHED/distro.txt

	if [ -z "$TMUX" ]; then

		ls $PREFIX/var/lib/proot-distro/installed-rootfs | fzf --height 100% --ansi --border --no-preview >$cached
	else
		tmux display-popup -xC -yC -E -h40% -w50% "ls $PREFIX/var/lib/proot-distro/installed-rootfs |   $HOME/.fzf/bin/fzf --height 100%  --ansi --border --no-preview  > $cached"
	fi

	local distro=$(cat $cached)

	[ -z "${distro}" ] && return

	proot-distro login --termux-home --fix-low-ports $distro
}

run-debian() {
   proot-distro login --termux-home --fix-low-ports debian -- eval \$@
}


distro-backup(){
	cached=$DIR_CACHED/distro.txt

	if [ -z "$TMUX" ]; then
		ls $PREFIX/var/lib/proot-distro/installed-rootfs | fzf --height 100% --ansi --border --no-preview >$cached
	else
		tmux display-popup -xC -yC -E -h40% -w50% "ls $PREFIX/var/lib/proot-distro/installed-rootfs |  $HOME/.fzf/bin/fzf --height 100%  --ansi --border --no-preview  > $cached"
	fi

	local distro=$(cat $cached)

	[ -z "${distro}" ] && return

	proot-distro backup $distro --output /sdcard/distro.backup.tar.xz
}
