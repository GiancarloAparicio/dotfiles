#-------------------------------------------------------------------
# Git Alias

alias gs='git status -sb'
alias gc='git commit -a'
alias gca='git commit --amend'

alias ga='git add .'

alias gr-soft='git reset --soft HEAD~1'
alias grs='gr-soft'

alias gr-mixed='git reset --mixed HEAD~1'
alias grm='gr-mixed'

alias gr-hard='git reset --hard HEAD~1'
alias grh='gr-hard'

alias g-restore='git restore'

alias git-data='git config --global -l'
alias git-name='git config --global user.name'
alias git-email='git config --global user.email'


#-------------------------------------------------------------------
# Functions Git

alias grm='grm-cached'
alias gi='gitignore'


#-------------------------------------------------------------------
# FZF-Git

alias g-tag='git-tag'
alias gt='g-tag'

alias g-branch='git-branch'
alias gb='g-branch'

alias g-diff='git-diff'
alias gd='git-diff'

alias g-diff-commits='git-diff-commits'
alias gdc='g-diff-commits'

alias g-log='git-log'
alias gl='g-log'

alias g-stash='git-stash'

alias g-remote='git-remote'

alias g-index='git-index'
