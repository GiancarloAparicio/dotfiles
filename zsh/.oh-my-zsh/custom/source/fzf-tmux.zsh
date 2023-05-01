#-------------------------------------------------------------------
# FZF-TMUX

ftmux(){
    local sessions=$( tmux list-sessions 2> /dev/null | grep -v "(attached)" | grep -v "cmus:" | grep -v 'aux:' )
    local new_session=$1
    local is_last_session=$(echo $sessions | wc -l)
    local regexp_is_connection_ssh="^[a-zA-Z0-9\.\-]*@[a-zA-Z0-9\.\-]+$"

    # If there is no session and there is no parameter open tmux normally
    if [[ -z "${sessions}" && -z "${new_session}" ]]; then
        tmux
        return

    # If the parameter passed is a ssh session connect with tmux-cssh
    elif [[ $new_session =~ $regexp_is_connection_ssh  ]]; then
        bash $ZSH_CUSTOM/scripts/tmux-cssh.sh -sc $new_session

    # If a parameter was passed, create a new session
    elif [[ ! -z "${new_session}" ]]; then
        tmux new-session -s "$1"
        return

    # If there is only one session open, open it
    elif [[ "1" == "$is_last_session" ]];then
        local id_latest=$(echo $sessions | awk '{print $1}')
        id_latest=$(echo $id_latest | sed  "s/://g")

        tmux attach-session -t $id_latest
        return

    # If there are multiple sessions, use FZF to select one
    else
        local id_session=$( echo $sessions | _fzf-show --preview ' bash ~/.oh-my-zsh/custom/scripts/tmux_tree.sh $( echo {1} | sed "s/://g" ) ' | awk '{print $1}')
        [ -z "${id_session}" ] && return

        id_session=$(echo $id_session | sed  "s/://g")
        tmux attach-session -t $id_session
    fi
}
