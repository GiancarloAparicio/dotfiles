# export MANPATH="/usr/local/man:$MANPATH"

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='lvim'
export TERM=xterm-256color


export NAME='Erick Giancarlo Ramos Aparicio'
export EMAIL='erickgiancarlo25@gmail.com'

# Disable ctrl + d to close terminal
set -o ignoreeof  

#-------------------------------------------------------------------
# Lang

#export LC_ALL=en_IN.UTF-8
#export LANG=en_IN.UTF-8


#-------------------------------------------------------------------
# Configuration NeoVim
export MYVIMRC='$HOME/.config/nvim/init.vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"


#-------------------------------------------------------------------
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#-------------------------------------------------------------------
# directory cached
diretory_cached=~/.aux.cached

if [[ ! -d "$diretory_cached" ]]; then
    mkdir $diretory_cached
fi

export DIR_CACHED=$diretory_cached
