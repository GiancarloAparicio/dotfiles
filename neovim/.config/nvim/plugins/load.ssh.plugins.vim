call plug#begin('~/.config/nvim/autoload/plugged')

    "----------------------------------------------------------------------------------
    " Syntax & linting
    Plug 'w0rp/ale'                              " Verifique la sintaxis en Vim de forma asincrónica y repare archivos


    "----------------------------------------------------------------------------------
    " Status line
    Plug 'vim-airline/vim-airline'                  " Barra de estado elegante para NeoVim
    Plug 'vim-airline/vim-airline-themes'           " Temas para airline


    Plug 'Yggdroot/indentLine'                                            " Muestra los niveles de sangría
    Plug 'pechorin/any-jump.vim'               " Ir a cualquier definición y referencia


    "----------------------------------------------------------------------------------
    " Auto Complete
    Plug 'neoclide/coc.nvim', {'branch': 'release'}      " Autocompletado inteligente de VSCode
    Plug 'Raimondi/delimitMate'                  " Autocompletado para palabras dentro de las comillas


    "----------------------------------------------------------------------------------
    " Snippets
    Plug 'SirVer/ultisnips'                   " Snippets y generador de snippets
    Plug 'honza/vim-snippets'                " Snippets generales para NeoVim (snipmate y ultisnips)

    "----------------------------------------------------------------------------------
    " Autoformat
    Plug 'z0mbix/vim-shfmt', { 'for': 'sh' } " Formateo de código bash


    "----------------------------------------------------------------------------------
    " Tex
    Plug 'lervag/vimtex'        " Complemento para archivos LaTeX.

    "----------------------------------------------------------------------------------
    " HTML, CSS, JavaScript, Typescript, PHP, JSON, etc.
    Plug 'alvan/vim-closetag'                " Cerrar automáticamente (X) etiquetas HTML
    Plug 'pangloss/vim-javascript'           " Compatibilidad con sangría y sintaxis de Javascript
    Plug 'leafgarland/typescript-vim'        " Archivos de sintaxis de typescript
    Plug 'octol/vim-cpp-enhanced-highlight'  " Resaltado de syntax para c++
    Plug 'mxw/vim-jsx'                     " Soporte para archivos JSX
    Plug 'peitalin/vim-jsx-typescript'       " Archivos de sintaxis de typescript y react
    Plug 'maxmellon/vim-jsx-pretty'          " Plugins para JSX, mayor compatibilidad
    Plug 'jparise/vim-graphql'               " Archivos de sintaxis para graphql
    Plug 'fatih/vim-go' , { 'for': ['go', 'vim-plug'], 'tag': '*' }
    Plug 'yuezk/vim-js', { 'for': ['vim-plug', 'php','html', 'javascript', 'css', 'less'] } " Resaltado de syntax para js
    Plug 'styled-components/vim-styled-components', { 'branch': 'main' }  " Archivos de sintaxis para styled-components
    Plug 'AndrewRadev/tagalong.vim'         " Auto rename tag from HTML & JSX
    Plug 'ap/vim-css-color'                 " Resaltado de colores para CSS
    Plug 'tpope/vim-projectionist'          "
    Plug 'jwalton512/vim-blade'             " Soporte para Blade
    Plug 'iamcco/coc-tailwindcss',  {'do': 'yarn install --frozen-lockfile && yarn run build'} " Soporte para Tailwind con coc
    Plug 'chr4/nginx.vim'                   " Syntax para nginx


    "----------------------------------------------------------------------------------
    " Editor Enhancement
    Plug 'mg979/vim-visual-multi'            " Complemento de cursores múltiples (Varias lineas)
    Plug 'luochen1990/rainbow'               " Paréntesis de arcoíris
    Plug 'easymotion/vim-easymotion'             " VIM a velocidad increíble con shortcuts (Movimiento en el archivo actual)
    Plug 'kamykn/spelunker.vim'               " Corrector ortografico para NeoVim
    Plug 'kamykn/popup-menu.nvim'             " Menu popup complemento de spelunker
    Plug 'editorconfig/editorconfig-vim'      " Editor config interprete para Vim
    Plug 'jbgutierrez/vim-better-comments'    " Resaltado de comentarios para NeoVim
    Plug 'jiangmiao/auto-pairs'               " Complemento para inserte o elimine corchetes, pares, comillas en pares
    Plug 'svermeulen/vim-cutlass'             " Agrega una operación de 'cortar' separada de 'eliminar'
    Plug 'svermeulen/vim-yoink'               " Complemento de Vim que mantiene un historial de yanks para alternar entre pegar
    Plug 'sunaku/tmux-navigate'               " Complemento para navegar entre paneles de tmux y de vim sin problemas
    Plug 'tmux-plugins/vim-tmux-focus-events' " Actualiza Los eventos de focus cuando se usa vim dentro de tmux
    Plug 'StanAngeloff/php.vim'
    Plug 'phpactor/phpactor', {'for': 'php', 'tag': '*', 'do': 'composer install --no-dev -o'}
    Plug 'eslint/eslint'                    " Añade eslint a vim
    Plug 'stephpy/vim-php-cs-fixer'
    Plug 'SergioRibera/vim-screenshot', { 'do': 'npm install --prefix Renderizer' } " Permite tomar capturas de pantalla

    "----------------------------------------------------------------------------------
    " Themes
    Plug 'joshdick/onedark.vim'              " Tema dark para NeoVim


    "----------------------------------------------------------------------------------
    "Auto-import
    Plug 'ludovicchabant/vim-gutentags'                             " Complemento que administra sus archivos de etiquetas
    Plug 'kristijanhusak/vim-js-file-import', {'do': 'npm install'} " Import/requiere archivos de js y typescript con un solo botón.
    Plug 'sahibalejandro/vim-php'                                   " PHP Companion
    Plug 'quark-zju/vim-cpp-auto-include'                           " Auto include c++


call plug#end()
