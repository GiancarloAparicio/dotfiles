#-------------------------------------------------------------------
# Functions npm && yarn

_npm_get_package(){

    local package=$1
    [[ -z "${package}" ]] && return

    local list_packages_cached=$ZSH_CUSTOM/files/npm-list-packages.txt

    if [[ -f "$list_packages_cached" ]]; then
        npm search $package --json > $list_packages_cached
    else
        touch $list_packages_cached
        echo -e "${RED} List loaded, try again ${ENDCOLOR}}"
        return
    fi

    local exists_package=$( cat $list_packages_cached | wc -l )
    [[ $exists_package == "3"  ]] && echo "Package $package not found " && return

    cat $list_packages_cached | \
        jq  -r '.[] | .name ' | \
        _fzf-show --preview " bash $ZSH_CUSTOM/scripts/npm-preview-package.sh {} "
}

_npm_get_version_package(){
    local package=$1
    [ -z "${package}" ] && return

    npm view $package versions --json | jq -r '.[]' | _fzf-show --no-preview --tac -m 1
}

npm-list(){

    local scope="search"
    while getopts gl flag
    do
        case "${flag}" in
            g) scope="list -g";;
            l) scope="list";;
        esac
    done

    eval "npm $scope --depth=0"
}

#-------------------------------------------------------------------
# Script para instalar los paquetes de npm de forma local, siempre y cuando los tengamos instalador en nuestro equipo host

npm-install(){

    while getopts d:p:g: flag
    do
        case "${flag}" in
            d) local scope="--save-dev";;   # Instalar paquete como dependencia de desarrollo
            p) local scope="--save-prod";;  # Instalar paquete como dependencia de producción
            g) local scope="-g";;         # Instalar paquete global
        esac
    done

    local package="${OPTARG}"

    if [ -z "${package}" ]; then
        package=$1
    fi

    local new_package=$(_npm_get_package $package)
    [ -z "${new_package}" ] && return

    eval "npm install $new_package $scope"

}
