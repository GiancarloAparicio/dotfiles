#-------------------------------------------------------------------
# FZF-ZSH

fkill(){
    pid=$1

    if [ -z "${pid}" ]; then
        local tmp="$HOME/proccess.tmp"
        if [ -z "$TMUX" ]; then
             ps -eo pid,%cpu,command --sort=-%cpu | _fzf-show --prompt "Proccess> " --no-preview --header-lines=1  | awk '{print $1}' > $tmp

        else
            tmux display-popup -xC -yC -E  -h40% -w50% "   ps -eo pid,%cpu,command --sort=-%cpu |  $HOME/.fzf/bin/fzf  --ansi -i --border --prompt 'Proccess> ' --no-preview --header-lines=1  | awk '{print \$1}' > $tmp"
        fi

        if [ -s "$tmp" ]; then
            for id in `cat $tmp` ; do
                sudo kill -9 "$id"
            done;
        fi

        rmn $tmp
 
    else
        sudo kill -9 "$pid"
    fi
}

fps(){
    pid=$1

    if [ -z "${pid}" ]; then
        local tmp=$(mktemp)

         ps -eo pid,%cpu,command --sort=-%cpu | head -n 1  > $tmp
        if [ -z "$TMUX" ]; then
             ps -eo pid,%cpu,command --sort=-%cpu | _fzf-show --prompt "Proccess> " --no-preview --header-lines=1  >> $tmp

        else
            tmux display-popup -xC -yC -E  -h40% -w50% " ps -eo pid,%cpu,command --sort=-%cpu | $HOME/.fzf/bin/fzf  --ansi -i --border --prompt 'Proccess> ' --no-preview --header-lines=1 >> $tmp"
        fi

        if [ -s "$tmp" ]; then
            cat "$tmp"
        fi

        rmn "$tmp"

    else
         ps -eo pid,%cpu,command --sort=-%cpu | grep $pid
    fi
}



rkill(){
     ps -eo pid,%cpu,command --sort=-%cpu | sed "1d" | rofi -dmenu -theme glue_pro_blue -p "Proccess" -i -width 80 | awk '{print $1}' | xargs -i kill -9 {}
}

fcd(){
    local dir=$1
    dir=${dir:-.}
    cd ${dir}

    dir=$( fd -c always --follow -t d -E "$FZF_IGNORE" | _fzf-show )

    [ -z "${dir}" ] && return

    cd ${dir}
}

fhistory(){
    local command_history=$( history | _fzf-show --no-preview  --reverse --bind 'ctrl-s:toggle-sort' --header 'Press CTRL-S to toggle sort' --no-preview | uniq | awk '{$1=""; print $0}')
    echo $command_history
    eval $command_history
}

ffile(){
    local file
    file=$(fd -c always  -t f -i -I -L -H -E "$FZF_IGNORE" | fzf -m --reverse --preview '[[ $(file --mime {}) =~ binary ]] &&
	                         echo {} is a binary file ||
	                         ($HOME/.local/share/zinit/plugins/sharkdp---bat/bat/bat --style=numbers --color=always {} ||
	                          highlight -O ansi -l {} ||
	                          coderay {} ||
	                          rougify {} ||
                            cat {}) 2> /dev/null | head -500')

    local editor=$1
	  editor=${editor:-nvim}

    [ -z "${file}" ] && return

    eval "$editor $file"
}

fwifi(){
    local ssid=$(nmcli --color yes device wifi | grep -v '^  *\B--\B' | fzf --border --ansi --height=40% --reverse --cycle --no-preview --inline-info --header-lines=1 -m | sed 's/^ *\*//' | awk '{print $1}')

    if [ "x$ssid" != "x" ]; then
    	# check if the SSID has already a connection setup
    	local conn=$(nmcli con | grep "$ssid" | awk '{print $1}' | uniq)
    	if [ "x$conn" = "x$ssid" ]; then
    		echo "Please wait while switching to known network $ssid"
    		# if yes, bring up that connection
    		nmcli con up id "$conn"
    	else
    		echo "Please wait while connecting to new network $ssid"
    		# if not connect to it and ask for the password
    		nmcli device wifi connect "$ssid" -a
    	fi
    fi
}

#-------------------------------------------------------------------
# Services

sv-all(){
    if [ -x "$(command -v /usr/sbin/service)" ]; then
        get_services="ls -l /etc/init.d/* | awk '{print \$(NF)}' | grep '/etc/' | grep -v '/opt/' | cut -d'/' -f4 "

    elif [ -x "$(command -v /bin/systemctl)" ]; then
        get_services="systemctl --user list-unit-files | head -n -1 |  awk '{ print \$1 }'"
    else
        get_services="ls $PREFIX/var/service"
    fi

    eval $get_services
}

_get-all-service(){

    local all_service="$DIR_CACHED/service.all.cached"
    local current_service="$DIR_CACHED/service.cached"

    local get_services=$(sv-all | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2};?)?)?[mGK]//g")

    echo $get_services > $all_service

    if [ -z "$TMUX" ]; then
        cat $all_service | _fzf-show --no-preview  --prompt 'Daemon> ' > $current_service

    else
        tmux display-popup -xC -yC -E  -h40% -w50% " cat $all_service |  $HOME/.fzf/bin/fzf --prompt 'Daemon> ' --height 100% --border --no-preview > $current_service"
    fi

    echo -e $(cat $current_service )

}

service-status(){
    local service=$(_get-all-service )
    [ -z "${service}" ] && return

    if [ -x "$(command -v /usr/sbin/service)" ]; then
        sudo service $service status

    elif [ -x "$(command -v /bin/systemctl)" ]; then
        systemctl --user status $service

    else
        sv status $service
    fi

}

service-enable(){
    local service=$(_get-all-service )
    [ -z "${service}" ] && return

    if [ -x "$(command -v /usr/sbin/service)" ]; then
        sudo service $service enable

    elif [ -x "$(command -v /bin/systemctl)" ]; then
        systemctl --user enable $service

    else
        sv-enable $service
    fi


    echo -e "${GREEN} Enabled: $service ${ENDCOLOR}"
}

service-disable(){
    local service=$(_get-all-service )
    [ -z "${service}" ] && return

    if [ -x "$(command -v /usr/sbin/service)" ]; then
        sudo service $service disable

    elif [ -x "$(command -v /bin/systemctl)" ]; then
        systemctl --user disable $service

    else
        sv-disable $service
    fi



    echo -e "${RED} Disabled: $service ${ENDCOLOR}"
}

service-start(){
    local service=$(_get-all-service "| grep -v ' active ' " )

    [ -z "${service}" ] && return

    if [ -x "$(command -v /usr/sbin/service)" ]; then
        sudo service $service start

    elif [ -x "$(command -v /bin/systemctl)" ]; then
        systemctl --user start $service

    else
        sv up $service
    fi

    echo -e "${GREEN} Start: $service ${ENDCOLOR}"
}

service-stop(){
    local service=$(_get-all-service "| grep ' active ' " )
    [ -z "${service}" ] && return

    if [ -x "$(command -v /usr/sbin/service)" ]; then
        sudo service $service stop

    elif [ -x "$(command -v /bin/systemctl)" ]; then
        systemctl --user stop $service

    else
        sv down $service
    fi

    echo -e "${RED} Stop: $service ${ENDCOLOR}"
}

service-restart(){
    local service=$(_get-all-service)
    [ -z "${service}" ] && return

    if [ -x "$(command -v /usr/sbin/service)" ]; then
        sudo service $service restart

    elif [ -x "$(command -v /bin/systemctl)" ]; then
        systemctl --user restart $service

    else
        sv restart $service
    fi

    echo -e "${YELLOW} Restart: $service ${ENDCOLOR}"
}
