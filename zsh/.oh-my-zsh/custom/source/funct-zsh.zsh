#-------------------------------------------------------------------
# Functions ZSH

htop(){

  if command -v  bpytop >/dev/null 2>&1; then
    bpytop 
  else 
    htop 
  fi

}

neo(){
  if command -v  macchina >/dev/null 2>&1; then
    macchina -S -K -U -C
  else 
    neofetch
  fi

}

toggle-app(){
  # Nombre de la aplicación a buscar
  APP_NAME="$1"

  # Obtener el ID de la ventana de la aplicación
  WINDOW_ID=$(xdotool search --name "$APP_NAME" )

  # Verificar si se obtuvo el ID de la ventana correctamente
  if [[ -z $WINDOW_ID ]]; then
    echo "No se pudo encontrar la ventana de $APP_NAME"
    eval "$2 &"
    exit 1
  fi

  echo $WINDOW_ID

  for id in $WINDOW_ID; do

    # Obtener el número de escritorio de la ventana
    DESKTOP=$(xdotool get_desktop_for_window $id 2>/dev/null)

    if [[ $DESKTOP = "$(xdotool get_desktop)" ]]; then

      echo "Ocultar"
      xdotool set_desktop_for_window $id 4
    else
      echo "Mostrar"
      xdotool set_desktop_for_window $id $(xdotool get_desktop)
    fi

  done

}


fdir(){
    if ! [ -x "$(command -v fd)" ]; then
        fd "$@"
    else
        find . -type d -name "$@"
    fi
}

draw(){
    fullFile="$(zenity --file-selection --title='Select a File')"
    filename=$(basename -- "$fullFile")
    file_without_extension="${filename%.*}"
    bash ~/.oh-my-zsh/custom/scripts/pdf2xopp.sh $fullFile $file_without_extension.xopp

    flatpak run com.github.xournalpp.xournalpp $file_without_extension.xopp
    flatpak run com.github.xournalpp.xournalpp -p "$file_without_extension.pdf"  $file_without_extension.xopp

}

find-text(){
    if [ -x "$(command -v ag)" ]; then
        ag -f -i "$@"
    else
        grep "$@" **/*.* 2>/dev/null
    fi
}

pdf(){
    pattern=$1
    files=$2
    echo "pdf \$pattern $\files"

    if ! [ -x "$(command -v pdfgrep)" ]; then
        pdfgrep -i -R -P "$pattern" $files
    else
        find ./ -name "$(basename "$files")" -exec sh -c "pdftotext '{}' - | grep --with-filename --label='{}' --color '$pattern'" \;
    fi
}

ext(){
        setopt localoptions noautopushd
        if (( $# == 0 ))
        then
                cat >&2 <<'EOF'
Usage: extract [-option] [file ...]

Options:
    -r, --remove    Remove archive after unpacking.
EOF
        fi
        local remove_archive=1
        if [[ "$1" == "-r" ]] || [[ "$1" == "--remove" ]]
        then
                remove_archive=0
                shift
        fi
        local pwd="$PWD"
        while (( $# > 0 ))
        do
                if [[ ! -f "$1" ]]
                then
                        echo "extract: '$1' is not a valid file" >&2
                        shift
                        continue
                fi
                local success=0
                local extract_dir="${1:t:r}"
                local file="$1" full_path="${1:A}"
                case "${file:l}" in
                        (*.tar.gz|*.tgz) (( $+commands[pigz] )) && {
                                        pigz -dc "$file" | tar xv
                                } || tar zxvf "$file" ;;
                        (*.tar.bz2|*.tbz|*.tbz2) tar xvjf "$file" ;;
                        (*.tar.xz|*.txz) tar --xz --help &> /dev/null && tar --xz -xvf "$file" || xzcat "$file" | tar xvf - ;;
                        (*.tar.zma|*.tlz) tar --lzma --help &> /dev/null && tar --lzma -xvf "$file" || lzcat "$file" | tar xvf - ;;
                        (*.tar.zst|*.tzst) tar --zstd --help &> /dev/null && tar --zstd -xvf "$file" || zstdcat "$file" | tar xvf - ;;
                        (*.tar) tar xvf "$file" ;;
                        (*.tar.lz) (( $+commands[lzip] )) && tar xvf "$file" ;;
                        (*.tar.lz4) lz4 -c -d "$file" | tar xvf - ;;
                        (*.tar.lrz) (( $+commands[lrzuntar] )) && lrzuntar "$file" ;;
                        (*.gz) (( $+commands[pigz] )) && pigz -dk "$file" || gunzip -k "$file" ;;
                        (*.bz2) bunzip2 "$file" ;;
                        (*.xz) unxz "$file" ;;
                        (*.lrz) (( $+commands[lrunzip] )) && lrunzip "$file" ;;
                        (*.lz4) lz4 -d "$file" ;;
                        (*.lzma) unlzma "$file" ;;
                        (*.z) uncompress "$file" ;;
                        (*.zip|*.war|*.jar|*.ear|*.sublime-package|*.ipa|*.ipsw|*.xpi|*.apk|*.aar|*.whl) unzip "$file" -d "$extract_dir" ;;
                        (*.rar) unrar x -ad "$file" ;;
                        (*.rpm) command mkdir -p "$extract_dir" && builtin cd -q "$extract_dir" && rpm2cpio "$full_path" | cpio --quiet -id ;;
                        (*.7z) 7za x "$file" ;;
                        (*.deb) command mkdir -p "$extract_dir/control" "$extract_dir/data"
                                builtin cd -q "$extract_dir"
                                ar vx "$full_path" > /dev/null
                                builtin cd -q control
                                extract ../control.tar.*
                                builtin cd -q ../data
                                extract ../data.tar.*
                                builtin cd -q ..
                                command rm *.tar.* debian-binary ;;
                        (*.zst) unzstd "$file" ;;
                        (*.cab) cabextract -d "$extract_dir" "$file" ;;
                        (*.cpio) cpio -idmvF "$file" ;;
                        (*) echo "extract: '$file' cannot be extracted" >&2
                                success=1  ;;
                esac
                (( success = success > 0 ? success : $? ))
                (( success == 0 && remove_archive == 0 )) && rm "$full_path"
                shift
                builtin cd -q "$pwd"
        done
}


vif(){
    file=$1

    if [ -z "${file}" ]; then
        vifmrun $(pwd)
    else
        vifmrun $file
    fi
}

ssh-tunnel(){
    echo -e "${GREEN} Todo el trafico entrante por \$localPort se va a direccionar atraves del \$host1 hacia el \$host2:\$portHost2 ${ENDCOLOR}"
    echo -e "${GREEN} Mis solicitudes hacia el \$localPort se mapearan al \$host2:\$portHost2, se necesita la password del \$host1 ${ENDCOLOR}"

    read "localPort? Ingrese numero de puerto local (\$localPort):  "

    read "host2? Ingrese host2 remoto (\$host2):  "

    read "portHost2? Ingrese el puerto del host2 (\$portHost2):  "

    read "host1? Ingrese el host1 remoto que servira de puente (\$host1):  "

    read "user? Ingrese el usuario para conectarse al host1:  "

    read "portSSH? Ingrese el puerto ssh del host1 [Default 22]:  "
    portSSH=${portSSH:-22}

    echo -e "${CYAN} ssh -N -C -f -L $localPort:$host2:$portHost2 -p $portSSH $user@$host1 ${ENDCOLOR}"

    while true; do
        read "yn? Quieres continuar (y/n)?  "
        case $yn in
        [Yy]*)
            ssh -N -C -f -L $localPort:$host2:$portHost2 -p $portSSH $user@$host1
            break
            ;;
        [Nn]*)
            echo "not"
            return
            ;;
        *) echo "Responda yes o no." ;;
        esac
    done

}

ssh-reverse-tunnel(){
    echo -e "${GREEN} Todo el trafico entrante por \$host1:\$portHost1 se va a direccionar atraves de mi \$host al \$host2:\$portHost2 ${ENDCOLOR}"
    echo -e "${GREEN} Las solicitudes hacia \$host1:\$portHost1 se mapearan al \$host2:\$portHost2, se necesita la password del \$host1 ${ENDCOLOR}"


    read "host2? Ingrese el host2 remoto (\$host2):  "

    read "portHost2? Ingrese el puerto del host2 remoto (\$portHost2):  "

    read "host1? Ingrese host1 remoto (\$host1):  "

    read "portHost1? Ingrese el puerto del host1 (\$portHost1):  "

    read "user? Ingrese el usuario para conectarse al host1:  "

    read "portSSH? Ingrese el puerto ssh del host1 [Default 22]:  "

    portSSH=${portSSH:-22}

    echo -e "${CYAN} ssh -N -C -f -R $portHost1:$host2:$portHost2 -p $portSSH $user@$host1 ${ENDCOLOR}"

    while true; do
        read "yn? Quieres continuar (y/n)?  "
        case $yn in
            [Yy]*)
                ssh -N -C -f -R $portHost1:$host2:$portHost2 -p $portSSH $user@$host1
                break
                ;;
            [Nn]*)
                echo "not"
                return
                ;;
            *) echo "Responda yes o no." ;;
        esac
    done

}

ssh-copy-file(){

   local user_host=$@

    while getopts "hrl" flag
    do
        case "${flag}" in
            h)
                echo "Las opciones validas son:"
                echo "      * -h: Muestra el menu de ayuda "
                echo "      * -r: Copia archivos del servidor a local "
                echo "      * -l: Copia archivos de local a servidor"
                return
                ;;
            r)

                echo "Copia archivos del servidor a local "

                if (( ${#user_host} <= 2 )); then
                    read "user? Enter user:  "
                    read "host? Enter host:  "
                    read "file? Enter path to remote file:  "
                    read "ruta? Enter local path to save [default ./]:  "

                    connection="$user@$host:$file"
                fi
                echo "scp -P 22 -r $connection $ruta"
                scp -P 22 -r $connection $ruta
                return
                ;;
            l)
                echo "Copia archivos de local a servidor"

                if (( ${#user_host} <= 2 )); then
                    read "user? Enter user:  "
                    read "host? Enter host:  "
                    read "file? Enter path to local file:  "
                    read "ruta? Enter remote path to save [default ./]:  "

                    conection="$user@$host:$ruta"
                fi
                echo "scp -P 22 -r $file $conection"
                scp -P 22 -r $file $conection
                return
                ;;

        esac
    done

    echo "Las opciones validas son:"
    echo "      * -h: Muestra el menu de ayuda "
    echo "      * -r: Copia archivos del servidor a local "
    echo "      * -l: Copia archivos de local a servidor"

   # if ! [ -x "$(command -v rsync)" ]; then
   #     scp $@
   # else
   #     rsync --partial --progress --rsh=ssh $@
   # fi
}

ssh-configure-server(){
    echo "Copia su llave publica a un host para conectarse por ssh sin ingresar una contraseña"

    local user_host=$@

    if [ -z "${user_host}" ]; then
        read "user? Enter user:  "

        read "host? Enter host:  "

        if [ -z "${user}" ]; then
            user_host="$host"

        else
            user_host="$user@$host"
        fi

    fi

    read "port? Enter port [default 22]:  "
    port=${port:-22}

    read "key? Enter key.pub [default id_rsa.pub]:  "
    key=${key:-id_rsa.pub}

    cd ~/.ssh

    if ! [[ -f "$key" ]]; then
        ssh-keygen -f $key
    fi

    ssh-copy-id -i $key -p $port $user_host
}

my-mac(){
    IFACE=$1
    IFACE=${IFACE:-eth0}
    read MAC </sys/class/net/$IFACE/address
    echo $IFACE $MAC
}

my-ip(){

    ip -o route get to 8.8.8.8 | sed -n 's/.*src \([0-9.]\+\).*/\1/p'

}

nvim-ssh(){

    local user_host=$@

    if [ -z "${user_host}" ]; then
        read "user? Enter user:  "
        read "host? Enter host:  "
        read "project? Enter path to project:  "
        user_host="$user@$host:$project"
    fi

    vim scp://$user_host

}

ssl-self-signed(){

    local directory=' /etc/ssl/'

    if [[ ! -d "$directory" ]]; then
        mkdir -p $directory/{private,certs}
    fi

    echo -e "${CYAN}Ingrese nombre del host: ${ENDCOLOR}"
    read host_name

    [ -z "${host_name}" ] && return

    openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout /etc/ssl/private/$host_name.key -out /etc/ssl/certs/$host_name.pem
}

sd(){
    oldWord=$1
    newWord=$2
    files=$3

    # if command 'sd' exists, use it
    if command -v sd &> /dev/null
    then
        sd $oldWord $newWord $files
    else

        find $(pwd) -name "${files}" -exec sed -i "s/$oldWord/$newWord/g" {} \;
    fi

}



temp-note(){
ext=$1

ext=${ext:-md}
file="$(mktemp)"
nvim -u ~/.config/nvim/minimal.init.vim "$file.$ext"
}

pid(){
    echo $( ps -eo pid,%cpu,command --sort=-%cpu | _fzf-show --prompt 'PID> ' --no-preview --header-lines=1  | awk '{print $1}')
}

ports(){
    sudo echo ""
    sudo lsof -i -f -P | _fzf-show --prompt 'Ports> ' --no-preview --header-lines=1
}

# https://github.com/tibabit/vim-templates DOCUMENTATION
_replace_flags_in_template(){
    local fullfile=$1
    local filename=$(basename -- "$fullfile")

    local FLAGS=(
            "{{NAME}}           | echo $NAME "
            "{{GIT_NAME}}       | git config --global user.name "
            "{{EMAIL}}          | echo $EMAIL "
            "{{GIT_EMAIL}}      | git config --global user.email "
            "{{HOSTNAME}}       | hostname "

            "{{DAY}}            | date '+%a' "
            "{{DAY_FULL}}       | date '+%A' "
            "{{DATE}}           | date +%d "
            "{{MONTH}}          | date +%m "
            "{{MONTH_SHORT}}    | date '+%b' "
            "{{MONTH_FULL}}     | date '+%B' "
            "{{YEAR}}           | date +%y "
            "{{TODAY}}          | date +%d/%m/%Y "
            "{{TIME}}           | date +%T "
            "{{TIME_12}}        | date +%l:%M:%S "
            "{{TIMESTAMP}}      | date "

            "{{FILE}}           | echo ${filename%%.*}"
            "{{FILEE}}          | echo $filename "
            "{{FILEF}}          | echo '$(pwd)/$fullfile' "
            "{{FILER}}          | echo $fullfile "
            "{{FILED}}          | echo '$(pwd)' "
            "{{FILEP}}          | echo '$(pwd | xargs basename)' "
            "{{FILERD}}         | echo '$(dirname $fullfile)'"
            "{{CLASS}}          | echo $(echo ${filename%%.*} | sed 's/.*/\L&/; s/[a-z]*/\u&/g' )"
            "{{SNAKE_CLASS}}    | echo $(echo ${filename%%.*} | sed -r 's/([A-Z])/_\L\1/g' | sed 's/^_//' )"
            "{{CAMEL_CLASS}}    | echo $(echo ${filename%%.*} | tr '__' '_' |  sed 's/_\([a-z]\)/\U\1/g;s/^\([a-z]\)/\U\1/g' )"
            "{{FILENE}}         | echo ${filename##*.}"
        )

        for flag in "${FLAGS[@]}"; do
            local replace_aux=$( echo $flag | cut -d '|' -f 2- )
            local current_flag=$( echo $flag | cut -d '|' -f -1 | sed 's/ *$//g' )
            local replace_flag=$(eval $replace_aux)

            (&>/dev/null sd $current_flag $replace_flag $fullfile )
        done
}

_create_file_if_exist_template(){
    local fullfile=$1
    local filename=$(basename -- "$fullfile")
    local extension="${filename#*.}"
    local all_template=$( ls ~/.oh-my-zsh/custom/files/templates | grep .template | rev | cut -f 2- -d '.' | rev )


    for template in $(echo $all_template); do

        # If exist template copy and replace flags
        if [[ $extension == $template ]]; then
            (&>/dev/null  eval "cp ~/.oh-my-zsh/custom/files/templates/$template.template ./$fullfile" &)
            _replace_flags_in_template $fullfile
            return
        fi
    done

    # If not exist template then only create new file
    touch $1
}

ad(){
    local regExpIsDir="\/$"
    for resource in $@ ; do
        if [[  $resource =~ $regExpIsDir  ]]; then
            mkdir -p $resource

        else
            mkdir -p $(dirname $resource)
            _create_file_if_exist_template $resource
        fi
    done
}

xcopy(){
    echo -n "$@" | xclip -selection c
}

xpaste(){
    xclip -selection c -o | rev | cut -c1- | rev
}

open () {
    xdg-open $@ > /dev/null 2>&1
}

yout-music(){
    local music=$@
    local regExpUrl="^(https:|http:)\/\/"
    local regExpFile=".txt$"

    if [[ $music =~ $regExpUrl  ]]; then
        ytmdl --format m4a --trim --title-as-name --ignore-errors --disable-file --url $music
        return
    fi

    if [[ $music =~ $regExpFile  ]]; then
        ytmdl --format m4a --trim --title-as-name --ignore-errors --disable-file --list $music
        return
    fi

    ytmdl --format m4a --trim --title-as-name --ignore-errors --disable-file $music
}

yout-video(){
    local video=$@
    local regExpUrl="^(https:|http:)\/\/"
    local regExpFile=".txt$"

    if [[ $video =~ $regExpUrl  ]]; then
        youtube-dl  --ignore-errors --url $video
        return
    fi

    if [[ $video =~ $regExpFile  ]]; then
        youtube-dl  --ignore-errors --disable-file --list $video
        return
    fi

    youtube-dl --ignore-errors --disable-file $video
}

rm(){
    read "answer? Delete files ?  "
    echo $answer
    reg_exp="^(y|Y|s|S)"

    if [[ $answer =~ $reg_exp  ]]; then
        rmn -r -f -v  $@
    fi
}

launch(){

    local cached=$DIR_CACHED/launch.txt

    if [ -z "$TMUX" ]; then
        echo "$PATH" | tr ":" "\n" | xargs -I{} -- find {} -maxdepth 1 -mindepth 1 -executable 2>/dev/null | sort -u | _fzf-show --prompt 'Apps> ' --no-preview > $cached

    else
        tmux display-popup -xC -yC -E  -h40% -w50% " echo $PATH | tr \":\" \"\n\" | xargs -I{} -- find {} -maxdepth 1 -mindepth 1 -executable 2>/dev/null | sort -u | $HOME/.fzf/bin/fzf --height 100% --border --no-preview > $cached"

    fi

    bash -c "eval \"$(cat $cached)\" &"
}

sysmon(){
    bash  $ZSH_CUSTOM/scripts/sysmon.sh
}


ll(){
    if ! [ -x "$(command -v lsd)" ]; then
        exa -l --group-directories-first -h --color=always $@
    else
        lsd -lh --group-dirs=first --color=always $@
    fi

}

la(){
    if ! [ -x "$(command -v lsd)" ]; then
        exa -a --group-directories-first  -h --color=always $@
    else
        lsd -a --group-dirs=first  --color=always $@
    fi
}

l(){
    if ! [ -x "$(command -v lsd)" ]; then
        exa --group-directories-first --color=always $@
    else
        lsd --group-dirs=first --color=always $@
    fi
}

lla(){
    if ! [ -x "$(command -v lsd)" ]; then
        exa --color=always -l -h $@
    else
        lsd -lha --group-dirs=first --color=always $@
    fi

}

ls(){
    if ! [ -x "$(command -v lsd)" ]; then
        exa --color=always $@
    else
        lsd --group-dirs=first --color=always $@
    fi
}

lsa(){
    if ! [ -x "$(command -v lsd)" ]; then
        exa --color=always -l -h -a $@
    else
        ls -lah $@
    fi
}

function mkt(){
	mkdir {nmap,content,exploits,scripts}
}

# Extract nmap information
function extractPorts(){
	ports="$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
	ip_address="$(cat $1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u | head -n 1)"
	echo -e "\n[*] Extracting information...\n" > extractPorts.tmp
	echo -e "\t[*] IP Address: $ip_address"  >> extractPorts.tmp
	echo -e "\t[*] Open ports: $ports\n"  >> extractPorts.tmp
	echo $ports | tr -d '\n' | xclip -sel clip
	echo -e "[*] Ports copied to clipboard\n"  >> extractPorts.tmp
	cat extractPorts.tmp; rm extractPorts.tmp
}

# Set 'man' colors
function man() {
    env \
    LESS_TERMCAP_mb=$'\e[01;31m' \
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    man "$@"
}


