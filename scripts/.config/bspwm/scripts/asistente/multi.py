#!/usr/bin/python3

import sys
import os

import urllib.parse

list = {
    "o": ["Convertir una imagen a texto con OCR", " ~/.local/bin/screen_ts"],
    "t": ["Convertir voz a texto", "~/.local/bin/voice_to_text"],
    "v": ["Convertir texto a voz", "killall tts; ~/.local/bin/tts"],
    "s": ["Traducir de ingles a español texto", "~/.local/bin/translate"],
    "u": [
        "Convertir texto del clipboard en MAYUSCULAS (UpperCase)",
        "echo $(xclip -selection c -o) |  tr '[:lower:]' '[:upper:]' | xclip -selection c ",
    ],
    "l": [
        "Convertir TEXTO del clipboard en minúsculas (LowerCase)",
        "echo $(xclip -selection c -o) |  tr '[:upper:]' '[:lower:]' | xclip -selection c ",
    ],
}


for item in list:
    print(f"{item} : {list[item][0]}")


if 1 < len(sys.argv):
    if sys.argv[1] == "restore":
        os.system("eval $(cat /tmp/multi)")
    else:
        key = sys.argv[1].split()[0].rstrip()
        command = list[key][1]
        os.system("pkill rofi")
        os.system(f"echo '{command}' > /tmp/multi")
        os.system(f"{command}")
