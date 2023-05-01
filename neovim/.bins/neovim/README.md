# Requirements
---
- NeoVim

- [[#Requirements]]

# Debian system:

![Debian](./docs/images/desktop.png)

# Termux Android

![Android](./docs/images/android.jpg)

- If you use **userLand**, proot or have Debian or a derivative installed on android you must use the "install" script

## Installation

Clone repository:

    git clone git@github.com:GiancarloAparicio/NeoVim-Customization.git

For Debian-based systems:

    chmod +x install.sh

    ./install.sh

## Fonts

Fonts are not necessary but I like how it looks with them.

- [Oh-my-zsh](https://ohmyz.sh/)

- [PowerLine](https://github.com/powerline/fonts)

## Short-Cuts

All native NeoVim combinations are still intact but new functionality has been added (NORMAL MODE).

|  shortcuts  |       Definition       |
| :---------: | :--------------------: |
|  ctrl + p   |      Find a file       |
|  space + n  |   open file browser files    |
|  space + s  |     save document      |
|  space + w  | save document and exit |
|  space + q  |  exit without saving   |
|  ctrl + d   |  select similar words  |
|  ctrl + up  | Select multiple lines  |
| ctrl + down | Select multiple lines  |
|   ctrl + n  |   Create a new file    |
|      f      |  Find and select word  |
|   ctrl + k  |     Scroll up 30%      |
|   ctrl + j  |   Scroll down 30%      |

INFO: The templates for creating files are stored in 'nvim / templates', for [more information](https://github.com/tibabit/vim-templates)

## Leader short cuts
|  shortcuts  |       Definition       |
| :---------: | :--------------------: |
|  $LEADER + l   |      Find method/tag in local buffer       |
|  $LEADER + L   |      Find method/tag in all files       |

## Auto-import

Auto-import is only supported for JavaScript and TypeScript on desktop, it is not supported for android yet.
In all normal press \<Tab\> to auto import the class under the cursor

| shortcuts |   Definition    |
| :-------: | :-------------: |
|   \<Tab\>   | Auto-import JS  |
|   \<Tab\>   | Auto-import PHP |

INFO: Auto import only works depending on the type of the file, so it won't cause problems between them.

## Corrector ortográfico

Corrija las palabras mal escritas con una lista de sugerencias.

    " Correct word under cursor.
    <.>

Agregar la palabra seleccionada a la lista interna de palabras

    key <,>

Saltar entre palabras mal escritas

    ZN -> Next word
    ZP -> Previus word

## Coc y autocompletado
|        Shortcut       |             Description             |
|:---------------------:|:-----------------------------------:|
|   ctrl + <space>     |     Muestra la documentación del método o clase    |
| ctrl + up, ctrl + down |     Crear cursores verticalmente    |


## Multiple cursors

|        Shortcut       |             Description             |
|:---------------------:|:-----------------------------------:|
|        ctrl + d       |     Seleccionar palabras iguales    |
| ctrl + up, ctrl + down |     Crear cursores verticalmente    |
|           n           |  Avanzar a la siguiente ocurrencia  |
|           N           | Retroceder a la anterior ocurrencia |
|           [           |     Avanzar al siguiente cursor     |
|           ]           |    Retroceder al anterior cursor    |
|       i, I, a, A      |           Modo insertion            |

INFO: En modo cursor, los comandos funcionan como lo harían en modo normal

## Find and replace in multiple files

### Shortcuts

|        Shortcut       |             Description             |
|:---------------------:|:-----------------------------------:|
|        ctrl + f       |             Busca texto             |
|        ctrl + h       |      Buscar y reemplazar texto      |

Para confirmar los cambios usar ':Fardo'

INFO: Para buscar una palabra rápidamente en el archivo actual usar '/'

## Easymotion, find words

Permite moverse rápido en el archivo actual

|        Shortcut       |                  Description                 |
|:---------------------:|:--------------------------------------------:|
|          /            |    Busca una palabra en el archivo actual    |
|          n            |        Avanza a la siguiente ocurrencia      |
|          N            |       Retrocede a la anterior ocurrencia     |
|          f            | Permite navegar a cualquier parte del código |

INFO: To disable search highlighting use ':noh'

## Copy, paste and delete text

| Command   	| Description                                                                                                                                                            	|
|-----------	|------------------------------------------------------------------------------------------------------------------------------------------------------------------------	|
| d\<motion\> 	| Delete over the given motion and do not change clipboard                                                                                                            	|
| dd        	| Delete the line and do not change clipboard                                                                                                                            	|
| D         	| Delete from cursor to the end of the line and do not change clipboard                                                                                                  	|
| dD        	| Delete the contents of line except the newline character (that is, make it blank) and do not change clipboard                                                          	|
| x         	| Delete the character under cursor and do not change clipboard                                                                                                          	|
| s         	| Delete the character under cursor then enter insert mode and do not change clipboard                                                                                   	|
| S         	| Delete the line under cursor then enter insert mode and do not change clipboard                                                                                        	|
| c         	| Enter insert mode over top the given area and do not change clipboard                                                                                                  	|
| cc        	| Enter insert mode over top the current line and do not change clipboard                                                                                                	|
| C         	| Enter insert mode from cursor to the end of the line and do not change clipboard                                                                                       	|
| p         	| Paste from specified register. Inserts after current line if text is multiline, after current character if text is non-multiline. Leaves cursor at end of pasted text. 	|
| P         	| Same as p except inserts text before current line/character                                                                                                            	|
| m<motion> 	| Delete over the given motion and copy text to clipboard                                                                                                                	|
| mm        	| Delete the current line and copy text to clipboard                                                                                                                     	|
| \<CTRL-P\>  | Rotate the previous paste forward in yank buffer. Note that this binding will only work if executed immediately after a paste                                       	|
| \<CTRL-N\>  | Rotate the previous paste backward in yank buffer. Note that this binding will only work if executed immediately after a paste                                     	|
| Y         	| Copy text from cursor position to the end of line to the clipboard                                                                                                     	|

The ctrl + n and ctrl + p functions only work in insert mode so they don't collide with fzf and advanced new file
INFO: For more information read [easyclip](https://github.com/svermeulen/vim-easyclip)

## Eunuco.vim

Comandos de shell de UNIX:

    :Delete, Elimina un búfer y el archivo en el disco simultáneamente.
    :Unlink, Me gusta :Delete, pero mantiene el búfer ahora vacío.
    :Move, Cambie el nombre de un búfer y el archivo en el disco simultáneamente.
    :Rename, Me gusta :Move, pero relativo al directorio que contiene el archivo actual.
    :Chmod, Cambia los permisos del archivo actual.
    :Mkdir, Crea un directorio, por defecto el padre del archivo actual.
    :Cfind, Ejecute findy cargue los resultados en la lista de correcciones rápidas.
    :Clocate, Ejecute locatey cargue los resultados en la lista de correcciones rápidas.
    :Lfind , Llocate, Como arriba, pero usa la lista de ubicaciones.
    :Wall, Escriba todas las ventanas abiertas. Útil para patear herramientas como guardia.
    :SudaWrite, Escriba un archivo privilegiado con sudo.
    :SudaEdit, Edita un archivo privilegiado con sudo.

## Rehacer y deshacer

    u (Deshacer, ctrl + z )
    U (Rehacer, ctrl + y )

## Windows and Panels

### Move between panels or create panels

| Shortcut |            Description          |
|:--------:|:------------------------------: |
| alt + h |  New window left or Move Left.  |
| alt + j |  New window down or Move Down.  |
| alt + k |    New window up or Move Up.    |
| alt + l | New window right or Move Right. |
| ctrl + o |    Open terminal split.   |

INFO: If you move to a panel that does not exist, a panel is created automatically

### Move between panels

|   Shortcut  |    Description      |
|:-----------:|:-------------------:|
|  alt + left |    Move Left panel. |
|  alt + down |    Move Down panel. |
|   alt + up  |   Move Up panel.    |
| alt + right |   Move Right panel. |


### Resize panels

|   Shortcut  |      Description      |
|:-----------:|:---------------------:|
|   ctrl + r  | Activate resize mode  |
|      k      |   Resize panel to up  |
|      j      |  Resize panel to down |
|      h      |  Resize panel to left |
|      l      | Resize panel to right |

INFO: To exit resize mode use 'q'

## Testing

|   Shortcut  |      Description      |
|:-----------:|:---------------------:|
|     \<F6\>    | Run the test closest to the cursor or the last to be run  |


### Client HTTP

Dependiendo de dónde coloque el cursor, se ejecutará la primera o la segunda solicitud. También puede sustituir variables en cualquier lugar de la solicitud:
[Mas información](https://github.com/aquach/vim-http-client)

Template file.txt:

```
    # First request.
    POST http://localhost...
    header-1: value-1
    ...
    header-n: value-n
    {
      "name": "Erick"
      "edad": 20
    }

    # Second request.
    POST http://localhost...
    header-1: value-1
    ...
    header-n: value-n
    {
      "name": "Erick"
      "edad": 20
    }
```


INFO: Para ejecutar una solicitud usar '<LEADER>tt'

## Git
|   Shortcut  |      Description      |
|:-----------:|:---------------------:|
|     `<F5>`    | Toggle current file's git history  |

## Screenshot


To take a screenshot of the selected code use the command ':TakeScreenShot', For more information [read](https://github.com/SergioRibera/vim-screenshot)

|           Command           	|                                           Description                                           	|
|:---------------------------:	|:-----------------------------------------------------------------------------------------------:	|
|          `<F7>`               	| Takes the selected lines and converts them into the image with the settings you have indicated. 	|
| :OpenFileScreenshotSettings 	|         Opens in a new tab the configuration file in JSON format to customize the image.        	|

![Screenshot](./docs/images/Vim-Screenshot.png "Vim")

## History
The shortcuts is in mode command ':'

|   Shortcut  |      Description      |
|:-----------:|:---------------------:|
|   `ctrl + r`  | Find command in history vim  |
