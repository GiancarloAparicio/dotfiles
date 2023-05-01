#!/usr/bin/python3

import subprocess
import pyperclip
import re
import os

output = subprocess.getoutput(
    """
echo "
Add snippet
Get snippet
Add TODO
Sync notes" | tail -n +2 | rofi -drun-use-desktop-cache -show -dmenu -i -p "Select" -markup-rows 5 -theme Arc-Dark
"""
)


def find_text(file, regexp):

    # Open file as file object and read to string
    file = open(f"{file}", "r")

    # Read file object to string
    text = file.read()

    # Close file object
    file.close()

    # Regex pattern
    pattern = re.compile(
        regexp,
        re.MULTILINE,
    )

    matchs = pattern.finditer(text)

    return matchs


def get_snippet():
    filename = subprocess.getoutput(
        "ls -l ~/.config/nvim/UltiSnips | tail -n +2 | awk '{print $(NF)}' | rofi -drun-use-desktop-cache -show -dmenu -i -p \"File\" -markup-rows 5 -theme Arc-Dark"
    )

    home = os.path.expanduser("~")
    file = f"{home}/.config/nvim/UltiSnips/{filename}"
    regexp = '^snippet (.*?) "(.*?)".*?\n((?:.|\n)*?)\nendsnippet$'
    matchs = find_text(file, regexp)

    filetemp = subprocess.getoutput("mktemp")
    dict = {}

    f = open(filetemp, "a")
    for data in matchs:
        f.write(f"{data.group(1)}: {data.group(2)}\n")
        dict[f"{data.group(1)}"] = data.group(3)
    f.close()

    snippet = subprocess.getoutput(
        "cat {} | tail -n +2 | rofi -drun-use-desktop-cache -show -dmenu -i -p \"Select\" -markup-rows 5 -theme  Arc-Dark | sed 's/:.*//g' ".format(
            filetemp
        )
    )

    pyperclip.copy(dict[snippet])


def add_snippet():
    print("add snippet")
    return "copy"


def sync_notes():
    print("sync notes")
    return "copy"


def add_todo():
    print("add todo")
    return "copy"


def run_magic_services(option):

    if option == "Get snippet":
        get_snippet()
    elif option == "Add snippet":
        add_snippet()
    elif option == "Sync notes":
        sync_notes()
    elif option == "Add TODO":
        add_todo()


run_magic_services(output)
