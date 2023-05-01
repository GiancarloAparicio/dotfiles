#-------------------------------------------------------------------
# Configuration fzf-tab
#

FZF_TAB_GROUP_COLORS=(
    $'\033[94m' $'\033[32m' $'\033[33m' $'\033[35m' $'\033[31m' $'\033[38;5;27m' $'\033[36m' \
    $'\033[38;5;100m' $'\033[38;5;98m' $'\033[91m' $'\033[38;5;80m' $'\033[92m' \
    $'\033[38;5;214m' $'\033[38;5;165m' $'\033[38;5;124m' $'\033[38;5;120m'
)

zstyle ':fzf-tab:*' group-colors $FZF_TAB_GROUP_COLORS

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false

# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'

# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# preview directory's content
zstyle ':fzf-tab:complete:cd:*'  fzf-preview 'tree -C $realpath'

# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

zstyle ':fzf-tab:complete:*' fzf-preview '
    if [[ $group = "[FILE]" || $group = "[file]" ]]; then

        local resource=$(file $realpath | awk "{print \$2}")
        if [[ $resource = "directory" ]]; then
            tree -C $realpath

        else
            $HOME/.local/share/zinit/plugins/sharkdp---bat/bat/bat --style=numbers --color=always $realpath
        fi
    else
        echo ""
    fi
'

zstyle ':fzf-tab:complete:*' popup-pad 50 20
zstyle ':fzf-tab:complete:cd:*' popup-pad 50 20
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
