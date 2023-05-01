#!/bin/bash

######################################################################
# @author      : Giancarlo Aparicio
# @created     : mar 07 feb 2023 21:04:05 -05
#
# @description : Script para poder controlar cmus desde la terminal
######################################################################

validate_exits_session_tmux() {
    exist_session_cmus=$(tmux list-sessions | grep "cmus")

    if [ -z "${exist_session_cmus}" ]; then
        zsh -c ". ~/.zshrc;	tmux new -s cmus -d 'cmus'"
        sleep 0.3
    fi

}

toggle_pause_play() {
    cmus_status=$(cmus-remote -C status | head -1 | awk '{ print $2 }')

    if [ "${cmus_status}" == 'playing' ]; then
        cmus-remote --pause

    elif [ "${cmus_status}" == 'paused' ]; then
        cmus-remote --play

    elif [ "${cmus_status}" == 'stopped' ]; then
        cmus-remote --play

    fi

}

help() {
    echo -e "Los comandos disponibles son:"
    echo -e "	* -s: Start/Pause music (Toggle)"
    echo -e "	* -n: Next music"
    echo -e "	* -p: Prev music"
}

while getopts "spn" flag; do
    case "${flag}" in
    s)
        validate_exits_session_tmux
        toggle_pause_play
        exit 0
        ;;
    p)
        cmus-remote --prev
        exit 0
        ;;
    n)
        cmus-remote --next

        exit 0
        ;;

    esac
done

help
