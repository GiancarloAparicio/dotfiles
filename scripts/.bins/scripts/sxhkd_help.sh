#!/bin/bash

awk '/^([a-z]|@)/ && last {print "<small>",$0,"\t",last,"</small>"} {last=""} /^#/{last=$0}' ~/.config/sxhkd/* |
    column -t -s $'\t' |
    rofi -show -dmenu -i -p "Command" -markup-rows 7 -width 800 -lines 15 -yoffset 40 -theme glue_pro_blue
