#!/usr/bin/python3

import sys
import os
import urllib.parse

lista = {
    "home": ["home", "https://www.google.com/maps/dir/home/%s", "Home"],
    "app": ["app", "https://flathub.org/apps/search/%s", "Flathub"],
    "b": ["b|bi|bing", "https://www.bing.com/search?q=%s", "Bing"],
    "p": ["p", "https://thepiratebay.org/search/%s", "Thepiratebay"],
    "u": ["u", "https://unsplash.com/es/s/fotos/%s", "Unsplash"],
    "g": ["g|go", "https://www.google.com/search?q=%s", "Google"],
    "d": ["d|dg", "https://duckduckgo.com/?q=%s", "Duckduckgo"],
    "l": ["l", "https://odysee.com/$/search?q=%s", "Odysee"],
    "map": ["g.m|gm", "https://www.google.com/maps?q=%s", "Maps"],
    "maps": ["g.m|gm", "https://www.google.com/maps?q=%s", "Maps"],
    "y": ["y|yt", "https://www.youtube.com/results?search_query=%s", "YouTube"],
    "w": [
        "w|wiki",
        "https://www.wikipedia.org/w/index.php?search=%s",
        "Wikipedia",
    ],
    "gs": ["gs", "https://scholar.google.com/scholar?q=%s", "Scholar"],
    "i": ["i", "https://www.google.com/search?q=%s&tbm=isch", "Images"],
    "ali": [
        "a|ae|ali|alie",
        "https://www.aliexpress.com/wholesale?SearchText=%s",
        "AliExpress",
    ],
    "az": ["az|amazon", "https://www.amazon.com/s/?field-keywords=%s", "Amazon"],
    "f": ["f|fav", "chrome://bookmarks/?q=%s", "Favoritos"],
    "=": ["=", "https://www.google.com/search?q=%3D+%s", "Calculate"],
    "git": ["gh|git", "https://github.com/search?q=$s", "Repo"],
    "ext": [
        "ext|exte|chr",
        "https://chrome.google.com/webstore/search/%s",
        "Extensiones",
    ],
    "t": [
        "t",
        "https://translate.google.com/?source=osdd&sl=es&tl=en&text=%s&op=translate",
        "Traductor",
    ],
    "ti": [
        "ti",
        "https://translate.google.com/?source=osdd&sl=en&tl=es&text=%s&op=translate",
        "Translate",
    ],
    "r": ["r", "https://www.reddit.com/search/?q=%s", "Reddit"],
    "st": ["st", "https://stackoverflow.com/search?q=%s", "Stackoverflow"],
    "im": ["im", "https://www.imdb.com/find?s=all&q=%s", "Imdb"],
    "pdf": ["pdf", "https://www.pdfdrive.com/search?q=%s", "PDF"],
    "rip": ["rip", "https://riptutorial.com/topic?q=%s&submit=Search", "RipTutorial"],
    "m": ["m", "https://music.youtube.com/search?q=%s&utm_source=opensearch", "Music"],
}

for item in lista:
    print(f"{lista[item][2]}: {item}")


if len(sys.argv) > 1:
    print("Exite por lo menos 1 parametro")
    key = sys.argv[1].lower().split()[0]

    if key in lista:
        print(f"Yes, key: '{key}' exists in dictionary")
    else:
        key = "g"
    query = sys.argv[1].lower().partition(" ")[2]
    query = urllib.parse.quote_plus(query)
    url = lista[key][1]
    url = url.replace("%s", query)

    os.system("killall -I rofi")
    os.system(f"xdg-open '{url}' ")
else:
    print(" echo 'Ningun parametro")
