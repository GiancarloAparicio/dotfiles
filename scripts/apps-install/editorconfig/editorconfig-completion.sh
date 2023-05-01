#!/bin/bash

_editorconfig_completions(){
    COMPREPLY=($(compgen -W "$(sudo ls ~/editorconfig/templates/ | grep .editorconfig | cut -d '.' -f 1)" -- "${COMP_WORDS[1]}"))
}


complete -F _editorconfig_completions editorconfig

