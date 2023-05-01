#-------------------------------------------------------------------
# Functions Git

_is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

_get_current_branch(){
  echo $(git rev-parse --abbrev-ref HEAD)
}

_get_path_to_repo(){
    echo $(git rev-parse --show-toplevel)
}

merge(){
    if ! [ -x "$(command -v lazygit)" ]; then
        git mergetool
    else
        lazygit
    fi
}

pull() {
  _is_in_git_repo || return

  local remote=$1
  remote=${remote:-origin}
  git pull --rebase --verbose $remote "$(_get_current_branch)"
}

gitignore(){
    local gitignore=$(_gitignoreio_get_command_list | _fzf-show --preview " curl -sfL https://www.gitignore.io/api/{} | sed '1,3d' | sed '\$d' ")

    for template in $(echo $gitignore); do
        curl -sfL https://www.gitignore.io/api/$template | sed '1,3d' | sed '$d' >> .gitignore
    done

}

push() {
  _is_in_git_repo || return

  local remote=$1
  remote=${remote:-origin}

  pull $remote
  git push --follow-tags -u $remote "$(_get_current_branch)"
}

send() {
  _is_in_git_repo || return

  git add "$(_get_path_to_repo)"
  git commit || return

  local remote=$1
  remote=${remote:-origin}

  push $remote
}



se() {
  _is_in_git_repo || return

  git add "$(_get_path_to_repo)"
  git commit -m "$(date +%Y-%m-%d__%H_%M_%S)" || return

  local remote=$1
  remote=${remote:-origin}

  push $remote
}

clone(){

    # If not have parameters
    if [[ $# -eq 0 ]]; then

        local repo=$( gh repo list $(git-name) | awk '{ print $1 }' | sed "s/$(git-name)\///" | _fzf-show --preview "bash $ZSH_CUSTOM/scripts/preview-fzf-repo.sh {}")
        [ -z "$repo" ] && return

        git clone --depth=8 --no-single-branch git@github.com:$(git config --global user.name)/$repo.git ./$repo
        cd $repo

        return
    fi

    # If have only one parameter (Link to repository or Name to search)
    if [[ $# -eq 1 ]]; then

        local repository=$1
        local regExpRemote="^(git@|ssh:/|https:/|http:/)"

        # If link repository is ssh | http
        if [[ $repository =~ $regExpRemote  ]]; then
            git clone --depth=8 --no-single-branch $repository
            cd "$(basename "$repository" .git)"

            return
        else
            echo -e "URL invalid"
        fi
    fi


    # If have two parameters (User, Repository)
    if [[ $# -eq 2 ]]; then

        local user_default=$(git config --global user.name)
        local user=${1:-user_default}

        local repository=$2

        git clone --depth=8 --no-single-branch git@github.com:$user/$repository.git ./$repository

        cd $repository
        return
    fi


    # If have three parameters (User, Repository)
    # github.com, bitbucket.org, gitlab.com
    if [[ $# -eq 3 ]]; then
        local remote=$1
        local user=$2
        local repo=$3

        git clone --depth=8 git@$remote:$user/$repo.git ./$repo
        cd $repo
        return
    fi
}

grm-cached() {
    _is_in_git_repo || return
    local files=$1
    files=${files:-.}

    git rm -r --cached --dry-run $files
}

# Elimina archivos del index de seguimiento de git
git-index(){
    _is_in_git_repo || return

    local list_files=$(git ls-files | _fzf-show --header 'Select the files to remove from the stage with <Tab>' )
    [ -z "${list_files}" ] && return

    for file in $(echo $list_files); do
        echo "Unstage: $file"
        git reset $file
    done
}
