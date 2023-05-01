# TMUX

INFO: The <kbd>$PREFIX</kbd> key refers to <kbd>ctrl</kbd> + <kbd>b</kbd> , <kbd>ctrl</kbd> + <kbd>a</kbd>

## Plugins TMP

By default the update of plugins with tpm is disabled, you must change the setting to true

```
tmux_conf_update_plugins_on_launch=false
tmux_conf_update_plugins_on_reload=false
 
```

## Find word

|   Shortcut  |       Description      |
|:-----------:|:----------------------:|
|  <kbd>$PREFIX</kbd> + <kbd>/</kbd> |        Find word       |
|      n      |     Next word match    |
|      N      |   Previous word match  |
|  <kbd>alt</kbd> + <kbd>]</kbd> | Copy the selected word |

This functionality is by the [copycat plugins](https://github.com/tmux-plugins/tmux-copycat)
INFO: What is copied to TMUX is also copied to the system clipboard

## Easy Motion

| Command    | Description                       |
|------------|-----------------------------------|
| <kbd>PREFIX</kbd> + <kbd>f</kbd> | Lets jump to any part of the code |

## Mode copy

By default search for a word and easy motion open the copy mode

| Command    | Description                  |
|------------|------------------------------|
| <kbd>h</kbd> , <kbd>left</kbd>   | Move to left   |
| <kbd>j</kbd> , <kbd>down</kbd>   | Move to down   |
| <kbd>k</kbd> , <kbd>up</kbd>     | Move to up     |
| <kbd>l</kbd> , <kbd>right</kbd> | Move to right   |
| <kbd>PREFIX</kbd> + <kbd>[</kbd> | Open mode copy               |
| <kbd>PREFIX</kbd> + <kbd>/</kbd> | Open mode copy (find-word)   |
| <kbd>PREFIX</kbd> + <kbd>F</kbd>  | Open mode copy (easy-motion) |

INFO: To select a text use <kbd>v</kbd>

|    Command    	|                      Description                      	|
|:-------------:	|:-----------------------------------------------------:	|
| $PREFIX + tab 	| Search for a word in the current panel (autocomplete) 	|


## Navigation between panels

|           Shortcut          |       Description      |
|:---------------------------:|:----------------------:|
|       <kbd>Alt</kbd> + up           |  Move to the up panel  |
|       <kbd>Alt</kbd> + down         | Move to the down panel |
|       <kbd>Alt</kbd> + left         | Move to the left panel |
|       <kbd>Alt</kbd> + right        |  Move the right panel  |

INFO: It is recommended to use $ PREFIX + space, because it will change the default layout (tiled)

## Tilish

| Keybinding | Description |
| ---------- | ----------- |
| <kbd>Alt</kbd> + <kbd>0</kbd>-<kbd>9</kbd> | Change to workspace number 0-9, if it doesn't exist create it |
| <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>0</kbd>-<kbd>9</kbd> | Move pane to workspace 0-9 |
| <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>h</kbd><kbd>j</kbd><kbd>k</kbd><kbd>l</kbd> | Move pane left/down/up/right |
| <kbd>Alt</kbd> + <kbd>Enter</kbd> | Create a new pane at "the end" of the current layout |
| <kbd>Alt</kbd> + <kbd>s</kbd> | Switch to layout: split then vsplit |
| <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>s</kbd> | Switch to layout: only split |
| <kbd>Alt</kbd> + <kbd>v</kbd> | Switch to layout: vsplit then split |
| <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>v</kbd> | Switch to layout: only vsplit |
| <kbd>Alt</kbd> + <kbd>t</kbd> | Switch to layout: fully tiled |
| <kbd>Alt</kbd> + <kbd>f</kbd> | Switch to layout: fullscreen (zoom) |
| <kbd>Alt</kbd> + <kbd>r</kbd> | Refresh current layout |
| <kbd>Alt</kbd> + <kbd>n</kbd> | Name current workspace |
| <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>q</kbd> | Quit (close) pane |
| <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>e</kbd> | Exit (detach) `tmux` |
| <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>c</kbd> | Reload config |

## Custom

| Keybinding | Description |
| ---------- | ----------- |
| <kbd>Alt</kbd> + <kbd>z</kbd> | Toggle between zooming for a panel |
| <kbd>Alt</kbd> + <kbd>e</kbd> | Send a session to the background and exit tmux |
| <kbd>Alt</kbd> + <kbd>q</kbd> | Close the current panel, if it is only one close the window |
| <kbd>Alt</kbd> + <kbd>a</kbd> | Open a new tmux session in a floating window |
| <kbd>Alt</kbd> + <kbd>b</kbd> | Open a file explorer in the current directory |

INFO: Shortcuts also work in Uppercase('alt' + 'E')

## Application launcher (Experimental)

| Keybinding | Description |
| ---------- | ----------- |
| <kbd>Alt</kbd> + <kbd>d</kbd> | Pop up a split that lets you fuzzy-search through all executables in your system $PATH. |

## FZF

| Keybinding | Description |
| ---------- | ----------- |
| <kbd>Alt</kbd> + <kbd>c</kbd> | Navigate between directories using fuzzy search |
| <kbd>Ctrl</kbd> + <kbd>r</kbd> | Browse the zsh command history |
| <kbd>Ctrl</kbd> + <kbd>t</kbd> | Search for a file diffusely |

INFO: En el modo de selección múltiple (-m) TAB y Shift-TAB para marcar varios elementos o desmarcar respectivamente

### Files and directories
Fuzzy completion for files and directories can be triggered if the word before the cursor ends with the trigger sequence, which is by default **


``` bash
# Files under the current directory
# - You can select multiple items with TAB key
vim **<TAB>

# Files under parent directory
vim ../**<TAB>

# Files under parent directory that match `fzf`
vim ../fzf**<TAB>

# Files under your home directory
vim ~/**<TAB>


# Directories under current directory (single-selection)
cd **<TAB>

# Directories under ~/github that match `fzf`
cd ~/github/fzf**<TAB>

```

## FZF and ZSH

| Command  | Description                                                                                       |
|----------|---------------------------------------------------------------------------------------------------|
| fkill    | Search diffusely for a process and then eliminate it                                              |
| ftmux    | Search diffusely for a tmux session, if a parameter is passed it creates a session with that name |
| fhistory | Fuzzy search for a command in history                                                             |
| fcd      | Fuzzy search for a directory and then 'cd'                                                        |
| nvim     | Search diffusely for sessions in vim, if a session does not exist it behaves normally             |

## Resurrect

| Keybinding      | Description                                                     |
|-----------------|-----------------------------------------------------------------|
| <kbd>prefix</kbd> - <kbd>Ctrl</kbd> + <kbd>s</kbd> | Saves all data from the current session, including vim sessions |
| <kbd>prefix</kbd> - <kbd>Ctrl</kbd> + <kbd>r</kbd> | Restore a tmux session                                          |

## Tmux Open

| Keybinding | Description                                                                            |
|---------|----------------------------------------------------------------------------------------|
|   <kbd>o</kbd>       | "open" a highlighted selection with the system default program                         |
|  <kbd>ctrl</kbd> + <kbd>o</kbd>      | open a highlighted selection with the $EDITOR                                          |
| <kbd>Shift-s</kbd> | search the highlighted selection directly inside a search engine (defaults to google). |
 
INFO: Tmux open only works in visual or copy mode
