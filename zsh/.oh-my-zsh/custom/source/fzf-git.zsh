#-------------------------------------------------------------------
# FZF-Git

#-------------------------------------------------------------------------------------------------------
_fzf-git-tag() {
  # Will return non-zero status if the current directory is not managed by git
  _is_in_git_repo || return

  git tag --sort -version:refname | _fzf-show --prompt 'Tag> ' --multi --preview-window right:70% --preview 'git show --color=always {} | bash $HOME/.oh-my-zsh/custom/scripts/delta-diff.sh'
}

git-tag(){
    local id_tag=$( _fzf-git-tag )
    [ -z "${id_tag}" ] && return

    git show "$id_tag"

}


#-------------------------------------------------------------------------------------------------------
_fzf-git-diff(){
  _is_in_git_repo || return
  print "$(git -c color.status=always status --short)" |
  _fzf-show --prompt 'Diff> '  -m --ansi --nth 2..,.. \
    --preview "git diff --color=always -- {-1} | bash \$HOME/.oh-my-zsh/custom/scripts/delta-diff.sh " | awk '{ $1=""; print $0 }' |  tr -d '"' | xargs
}

git-diff(){
    while getopts "c" flag
    do
        case "${flag}" in
            c)
                git-diff-commits
                return
                ;;
        esac
    done

    local resource=$( _fzf-git-diff )
    [ -z "${resource}" ] && return

    git diff "$resource"
}



#-------------------------------------------------------------------------------------------------------
_fzf-git-commit-id() {
    _is_in_git_repo || return

    local multi=$1
    multi=${multi:-10}

    local header=$2
    header=${header:-Press CTRL-S to toggle sort}

    local id_commit=$(git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
        _fzf-show  --prompt 'Commits> ' --ansi --no-sort --reverse --multi $multi --bind 'ctrl-s:toggle-sort' \
        --header $header \
        --preview 'git show --color=always $( bash $HOME/.oh-my-zsh/custom/scripts/git-log-filter-id.sh {} ) | bash $HOME/.oh-my-zsh/custom/scripts/delta-diff.sh' )

    echo "$id_commit" | awk '{ print $3 }'
}

git-diff-commits(){
    _is_in_git_repo || return

    local commits=$( _fzf-git-commit-id 2 'Select 1 or 2 commits with <Tab>:'  )
    [ -z "${commits}" ] && return

    git diff $(echo $commits | tr '\n' ' ')
}

git-log(){
    local id_commit=$( _fzf-git-commit-id )
    [ -z "${id_commit}" ] && return

    git show "$id_commit"

    echo "Commit: $id_commit"
}




#-------------------------------------------------------------------------------------------------------
_fzf-git-stash() {
  _is_in_git_repo || return
  git stash list | _fzf-show  --prompt 'Stash> ' --reverse -d: --preview 'git show --color=always {1}' | awk '{  print $1 }'  | sed 's/.$//'
}

# Stash solo afecta al staged y el working directory, por lo que no afectara a ningún archivo nuevo sin seguimiento.
git-stash(){
    local changes=$(git diff HEAD)

    # Si existe algún cambio entonces guardar Stage, Working directory y archivos sin seguimiento con stash
    if [ ! -z "${changes}" ]; then
        git stash save $1 --include-untracked
        return
    fi

    # Si NO existen stash disponibles terminar la ejecución
    [ -z "$(git stash list)" ] && return


    # Seleccionar un stash y traerlo al working directory
    local id_stash=$( _fzf-git-stash )
    [ -z "${id_stash}" ] && return

    git stash pop "$id_stash"
}


#-------------------------------------------------------------------------------------------------------
_fzf-git-branch() {
  _is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  _fzf-show --prompt 'Branch> ' --ansi --multi --tac --preview-window right:70% \
  --preview 'git log --color=always  --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)"  {-1}' | awk '{ print $NF }'
}

git-branch(){
    local new_branch=$1

    if [ -z "${new_branch}" ]; then
        local branch=$( _fzf-git-branch )
        [ -z "${branch}" ] && return

        # If string content the word 'remotes' then is a remote branch
        if [[ $branch == *"remotes"* ]]; then
            git switch --track "$branch"
        else
            git switch "$branch"
        fi

    else
        echo $new_branch
        # if branch exists, switch to it
        if git show-ref --verify --quiet "$new_branch"; then
            git switch "$new_branch"

        # if branch remote exusts, switch to it
        elif [[ $new_branch == *"remotes"* ]];  then
            git switch --track "$new_branch"
        else
            git switch -c "$new_branch"
        fi

    fi
}


#-------------------------------------------------------------------------------------------------------
_fzf-git-remote() {
  _is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  _fzf-show  --prompt 'Remote> ' --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" --remotes={1} | head -200' |
  cut -d$'\t' -f1
}

git-remote(){
    local remote=$( _fzf-git-remote )
    [ -z "${remote}" ] && return

    echo "$remote"
}
