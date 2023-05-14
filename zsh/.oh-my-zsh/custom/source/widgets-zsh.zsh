#-------------------------------------------------------------------
# Helpers
_get-path-resource() {
local resource=$(fd -c always -i -I -H --follow $1 -E $FZF_IGNORE | _fzf-show --prompt 'Resource> '| sed 's/ /\\ /g' | sed 's/(/\\(/g' | sed 's/)/\\)/g')
    [ -z "${resource}" ] && return

    LBUFFER="${LBUFFER} ${resource} "
    local ret=$?
    zle reset-prompt

    result=$(echo $ret )

    return ${result}
}


#-------------------------------------------------------------------
# Widgets
__get-path-file(){
    _get-path-resource '--type=f'
}

__get-path-dir(){
    _get-path-resource '--type=d'
}


__close-session(){
    exit 0
}

__to-dir(){
    local dir=$(fd -t d -c always --follow $1 -E $FZF_IGNORE | _fzf-show --prompt 'Directory> ')
    [ -z "${dir}" ] && return

    eval "cd ${dir}"
    zle accept-line
}

__to-file(){
    local file=$(fd -t f -c always --follow $1 -E $FZF_IGNORE | _fzf-show --prompt 'File> ')

    [ -z "${file}" ] && return

    eval "n ${file}"
    zle accept-line
}

function zvm_after_init() {
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

    zle     -N   __get-path-dir
    zle     -N   __get-path-file

    bindkey '^f' __get-path-file
    bindkey '^d' __get-path-dir

}

# The plugin will auto execute this zvm_after_lazy_keybindings function
function zvm_after_lazy_keybindings() {

  # Here we define the custom widget
  zvm_define_widget __to-dir
  zvm_define_widget __to-file
  zvm_define_widget __get-path-file
  zvm_define_widget __get-path-dir
  zvm_define_widget __close-session

  # vicmd (Normal mode), viins (Insert mode)
  # Alt   =  ^[  # Together ^[q
  # Ctrl  =  ^
  # Esc   =  ^[  #Only

 # # Ctrl + f
  zvm_bindkey vicmd '^f' __get-path-file
  zvm_bindkey viins '^f' __get-path-file

 # # Ctrl + d
  zvm_bindkey vicmd '^d' __get-path-dir
  zvm_bindkey viins '^d' __get-path-dir

  # Alt + q
  zvm_bindkey vicmd '^[q' __close-session
  zvm_bindkey viins '^[q' __close-session

  # Alt + c
  zvm_bindkey vicmd '^[c' __to-dir
  zvm_bindkey viins '^[c' __to-dir

}
