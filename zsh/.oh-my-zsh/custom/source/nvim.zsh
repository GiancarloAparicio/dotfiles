fnvim(){
    local jobs=$(jobs | grep nvim)
    local is_last_job=$(echo $jobs | wc -l)
    local file=$1

    # If there is not 1 wine session or a parameter was passed to it (file)
    if [[ -z "${jobs}" || ! -z "${file}" ]]; then
        if ! [[ -f "$file" ]]; then
            ad $file
        fi

        if [ -x "$(command -v lvim)" ]; then
          lvim $file
        else
          nvim -u '~/.config/nvim/init.vim' $file
        fi
        return

    # If no parameter (file) was passed and there is only 1 session in the background
    elif [[ "1" == "$is_last_job" ]];then
        local id_job="$jobs | awk '{print $1}'"
        local regExpJob="\[([1-9]+)\]" # Captura unique job ID

        if [[ $id_job =~ $regExpJob  ]]; then
            fg %${match[1]}
        fi
        return

    # If there are several sessions in the background open fzf to choose one
    else
        local id_job="$(echo $jobs | _fzf-show --prompt 'Sessions> ' | awk '{print $1 $2 $3}')"
        local regExpJob="\[([1-9]+)\](\+|-)?.+"  # Capture job ID

        if [[ $id_job =~ $regExpJob  ]]; then
            fg %${match[1]}
        fi
    fi
}

alias nn='nvim -u none'
