#-------------------------------------------------------------------
# Helpers
#
_include () {
    [[ -f "$1" ]] && source "$1"
}

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everythi else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to chae your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

ZSH_THEME="agnoster"

#ZSH_THEME="powerlevel10k/powerlevel10k"

#POWERLEVEL9K_MODE="awesome-patched"

# Set list of themes to pick from when loadi at random
# Setti this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looki in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the followi line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the followi line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchaeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the followi line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the followi line to automatically update without prompti.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the followi line to chae how often to auto-update (in days).
export UPDATE_ZSH_DAYS=30

# Uncomment the followi line if pasti URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the followi line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the followi line to disable auto-setti terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the followi line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Uncomment the followi line to display red dots whilst waiti for completion.
#COMPLETION_WAITI_DOTS="true"

# Uncomment the followi line if you want to disable marki untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the followi line if you want to chae the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format usi the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=~/.oh-my-zsh/custom

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(
    gitignore
    docker
    docker-compose
    git
    jsontools
    encode64
    systemadmin
    systemd
    fzf
)

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
export HISTSIZE=2000
export SAVEHIST=2000
export HISTFILE=~/.zsh_history

_include $ZSH/oh-my-zsh.sh
alias debian='proot-distro login --termux-home --fix-low-ports debian'

for file in $HOME/.oh-my-zsh/custom/source/**/*.zsh; do
    _include $file
done

#-------------------------------------------------------------------
# Asdf
OS=$(uname -o)

if [[ ! "$OS" == "Android" ]]; then
    # Is not termux
    _include $HOME/.asdf/asdf.sh
    #_include $HOME/.asdf/completions/asdf.bash

fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

if [[ ! -d "~/.local/share/zinit/plugins" ]]; then

    #-------------------------------------------------------------------
    # Plugins
    zinit ice depth=1; zinit light romkatv/powerlevel10k
    zinit light Aloxaf/fzf-tab
    zinit wait lucid atload'_zsh_autosuggest_start' light-mode for \
        zsh-users/zsh-autosuggestions
    zinit load zsh-users/zsh-syntax-highlighting
    zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode



    #-------------------------------------------------------------------
    # Install apps
    # tealdeer

    zinit ice as"program" from"gh-r" mv"tealdeer* -> tldr" pick"tldr/tldr" dl'https://github.com/dbrgn/tealdeer/releases/latest/download/completions_zsh -> _tldr;' completions sbin"tldr" dbrgn/tealdeer
    zinit ice as"program" from"gh-r" mv"duf* -> df" pick"df/df" bpick"*(.zip|tar.gz)" sbin muesli/duf

    # ripgrep
    zinit ice as"program" from"gh-r" mv"ripgrep* -> rg" pick"rg/rg"
    zinit light BurntSushi/ripgrep

    # exa
    zinit ice as"program" from"gh-r" mv"exa* -> exa"
    zinit light ogham/exa

    # bat
    zinit ice as"program" from"gh-r" mv"bat* -> bat" pick"bat/bat"
    zinit light sharkdp/bat

    # fd
    zinit ice as"program" from"gh-r" mv"fd* -> fd" pick"fd/fd"
    zinit light sharkdp/fd

    # lsd
    zinit ice as"program" from"gh-r" mv"lsd* -> lsd" pick"lsd/lsd"
    zinit light Peltoche/lsd

    # delta
    zinit ice as"program" from"gh-r" mv"delta* -> delta" pick"delta/delta"
    zinit light dandavison/delta
fi

setopt APPEND_HISTORY # Don't erase history
setopt EXTENDED_HISTORY # Add additional data to history like timestamp
setopt INC_APPEND_HISTORY # Add immediately
setopt HIST_FIND_NO_DUPS # Don't show duplicates in search
setopt HIST_IGNORE_SPACE # Don't preserve spaces. You may want to turn it off
setopt NO_HIST_BEEP # Don't beep
setopt SHARE_HISTORY # Share history between session/terminals

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || _include ~/.p10k.zsh
 [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
enable-fzf-tab

eval "$(zoxide init bash)"
