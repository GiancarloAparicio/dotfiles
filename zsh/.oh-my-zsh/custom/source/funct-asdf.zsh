#-------------------------------------------------------------------
# Helpers

_get-plugins-installed-asdf(){

    local asdf_cached=$ZSH_CUSTOM/files/asdf-tmp.json

    if [ -z "$TMUX" ]; then
        echo $(asdf list | grep -v '^ ' |  _fzf-show --no-preview --prompt 'Version> ')

    else
        tmux display-popup -xC -yC -E  -h40% -w50% "~/.asdf/bin/asdf list | grep -v '^ ' |  $HOME/.fzf/bin/fzf --height 100% --border --no-preview  > $asdf_cached"
        echo $(cat $asdf_cached | xargs)
    fi
}

_get-version-to-plugin-installed(){
    local asdf_cached=$ZSH_CUSTOM/files/asdf-tmp.json
    local plugin=$1

    if [ -z "$TMUX" ]; then
        echo $(asdf list $plugin |  _fzf-show --no-preview  --prompt 'Version> ' )

    else
        tmux display-popup -xC -yC -E  -h40% -w50% "~/.asdf/bin/asdf list $plugin | $HOME/.fzf/bin/fzf -i --height 100% --border --no-preview | jq -R -n -c '[inputs|{\"latest_version_plugin\":.}] | add' > $asdf_cached"
        echo $(jq -r .latest_version_plugin $asdf_cached | xargs)

    fi
}

_set-scope-plugin-asdf(){
    local plugin=$( _get-plugins-installed-asdf )
    [[ -z "${plugin}" || $plugin == "null" ]] && return

    local version=$( _get-version-to-plugin-installed $plugin)
    [[ -z "${version}" || $version == "null" ]] && return

    local scope=$1
    scope=${scope:-global}

    eval "asdf $scope $plugin $version"

    if [ $scope != "global" ]; then
        eval "asdf global $plugin system"
    fi
}

_get-all-plugins-asdf(){
    local FILE=$ZSH_CUSTOM/files/asdf-all-plugins.txt
    local asdf_cached=$ZSH_CUSTOM/files/asdf-tmp.json

    if [[ -f "${FILE}" ]]; then

        if [ -z $TMUX ]; then
            echo $(cat $FILE | awk '{print $1}' | fzf -i --height 100% --border --no-preview )

        else
            tmux display-popup -xC -yC -E  -h40% -w50% \
                "cat $FILE | awk '{print \$1}' |\
                $HOME/.fzf/bin/fzf --height 100% --border -i --no-preview |\
                jq -R -n -c '[inputs|{\"plugin\":.}] |\
                add'  > $asdf_cached"

            echo $(jq -r .plugin $asdf_cached 2> /dev/null | xargs )
        fi

    else
        asdf plugin list all > $FILE
    fi

}

#-------------------------------------------------------------------
# ASDF functions

asdf-env(){

    current_folder=$(basename "$PWD")
    if ! [[ -d "$WORKON_HOME"/"$current_folder" ]]; then
        # if exist .tool-versions
        if ! [[ -f ".tool-versions" ]]; then

            _set-scope-plugin-asdf 'local'
        fi
        plugin=$(cat .tool-versions | awk '{print $1}' | _fzf-show --no-preview  --prompt 'Plugin> ')
        version=$(cat .tool-versions | awk '{print $2}' | _fzf-show --no-preview  --prompt 'Version> ')


        echo "Create new virtual env"
        path_plugin="$(asdf where $plugin $version)/bin/$plugin"
        path_work="$WORKON_HOME"/"$current_folder"
        mkdir -p $path_plugin
        mkdir -p $path_work

        virtualenv -p $path_plugin $path_work
    else

        source "$WORKON_HOME"/"$current_folder"/bin/activate
    fi

}

# Configuration version for current project
asdf-local(){
    _set-scope-plugin-asdf 'local'
    asdf-env
}

# Configuration version for all system
asdf-global(){
    _set-scope-plugin-asdf 'global'
}

# Configuration version for current shell
asdf-shell(){
    _set-scope-plugin-asdf 'shell'
    asdf-env
}

# Install version any plugin
asdf-install(){
    local asdf_cached=$ZSH_CUSTOM/files/asdf-tmp.json

    # Get plugin
    local plugin=$( _get-all-plugins-asdf )
    asdf plugin list | grep "$plugin" || asdf plugin add $plugin

    [[ -z "$plugin" || "$plugin" == "null" ]] && return

    # Save version
    if [ -z "$TMUX" ]; then
        local version=$(asdf list-all $plugin |  fzf -i --height 100% --border --tac --no-preview )

    else
        tmux display-popup -xC -yC -E  -h40% -w50% "~/.asdf/bin/asdf list-all $plugin |  $HOME/.fzf/bin/fzf -i --height 100% --border --tac --no-preview | jq -R -n -c '[inputs|{\"version_plugin\":.}] | add' > $asdf_cached"
        local version=$(jq -r .version_plugin $asdf_cached | xargs)

    fi

    # Get version
    [[ -z "$version" || "$version" == "null" ]] && return
    asdf install $plugin $version
    asdf reshim $plugin $version
}


# Uninstall version any plugin
asdf-uninstall(){
    local asdf_cached=$ZSH_CUSTOM/files/asdf-tmp.json

    local plugin=$( _get-plugins-installed-asdf )
    [[ -z "$plugin" || "$plugin" == "null" ]] && return

    # Save version
    if [ -z "$TMUX" ]; then
        local version=$(asdf list-all $plugin |  fzf -i --height 100% --border --tac --no-preview )

    else

        tmux display-popup -xC -yC -E  -h40% -w50% "~/.asdf/bin/asdf list $plugin |  $HOME/.fzf/bin/fzf -i --height 100% --border --tac --no-preview | jq -R -n -c '[inputs|{\"version_plugin\":.}] | add' > $asdf_cached"
        local version=$(jq -r .version_plugin $asdf_cached | xargs)

    fi

    # Get version
    [[ -z "$version" || "$version" == "null" ]] && return

    while true; do
        read "yn? Do you want to uninstall version: $plugin:$version (y/n)?  "
        case $yn in
        [Yy]*)
            echo "Uninstall: $plugin:$version"
            asdf uninstall $plugin $version
            break
            ;;
        [Nn]*)
            echo "Not remove plugin"
            return
            ;;
        *) echo "Please answer yes o no." ;;
        esac
    done

}

# Remove plugin
asdf-remove(){
    local plugin=$(_get-plugins-installed-asdf)

    [[ -z "$plugin" || "$plugin" == "null" ]] && return

    while true; do
        read "yn? Do you want to remove plugin: $plugin (y/n)?  "
        case $yn in
        [Yy]*)
            echo "Remove: $plugin"
            asdf plugin remove $plugin

            break
            ;;
        [Nn]*)
            echo "Not remove plugin"
            return
            ;;
        *) echo "Please answer yes o no." ;;
        esac
    done
}

# Add new plugin
asdf-add(){
    # if not argument
    if [[ -z "$1" ]]; then
        local plugin=$(_get-all-plugins-asdf)
    else
        local plugin=$1
    fi

    local list_all_plugins=$ZSH_CUSTOM/files/asdf-all-plugins.txt

    [[ -z "$plugin" || "$plugin" == "null" ]] && return

    echo "Install: $plugin"

    asdf plugin add $plugin       # Install plugin

    (&>/dev/null asdf plugin list all > $list_all_plugins &)  # Refresh cached file to asdf list
}

# List all installed plugins
asdf-list(){
    local plugin=$( _get-plugins-installed-asdf )
    [[ -z "$plugin" || "$plugin" == "null" ]] && return

    echo "${CYAN}$plugin${ENDCOLOR}"
    echo "$( asdf list $plugin )"
}

compile(){
    local full_file="$1"
    local reg_exp="(.+)\.(.+)"

    [ -z "${full_file}" ] && echo "Not file, try again" && return

    # Si no cumple con la regexp entonces:
    if [[ ! $full_file =~ $reg_exp  ]]; then

        local shebang=$(head -1 $full_file | sed 's/..//' )

        if [ -z "${shebang}" ]; then
            echo -e "File invalid"
            return
        fi

        eval "$shebang $full_file"
        return
   fi

    local basename_file=${match[1]}
    local extension_file=${match[2]}

    if [[ -f ".tool-versions" ]]; then
        asdf-env
    fi

    case $extension_file in

        "s")
            as $full_file -o $basename_file.o
            ld $basename_file.o -o $basename_file
            eval "./$basename_file"
            rmn -f $basename_file $basename_file.o
            ;;

        "asm")
            as $full_file -o $basename_file.o
            ld $basename_file.o -o $basename_file
            eval "./$basename_file"
            rmn -f $basename_file $basename_file.o
            ;;

        "c")
            gcc -o $basename_file  $full_file
            eval "./$basename_file"
            rmn $basename_file
            ;;

        "cpp")
            g++ -o $basename_file  $full_file
            eval "./$basename_file"
            rmn $basename_file
            ;;

        "go")
            go run $full_file
            #go build -ldflags "-s -w" $full_file
            #upx $basename_file
            ;;

        "java")
            javac $full_file
            java $basename_file
            rmn "$basename_file.class"
            ;;

        "sh")
            bash $full_file
            ;;

        "zsh")
            zsh $full_file
            ;;

        "py")
            python3 $full_file
            ;;

        "js")
            node $full_file
            ;;

        "rb")
            ruby $full_file
            ;;

        "php")
            php $full_file
            ;;

        *)
            echo -e "Unknown file extension"
            echo -e $full_file
            echo -e $basename_file
            echo -e $extension_file
            ;;
    esac

}
