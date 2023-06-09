call plug#begin('~/.config/nvim/autoload/plugged')

    "----------------------------------------------------------------------------------
    " Syntax & linting
    Plug 'w0rp/ale'                              " Verifique la sintaxis en Vim de forma asincrónica y repare archivos
    "Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Mejora el resaltado de la sintaxis


    "----------------------------------------------------------------------------------
    " Status line
    Plug 'vim-airline/vim-airline'                  " Barra de estado elegante para NeoVim
    Plug 'vim-airline/vim-airline-themes'           " Temas para airline


    "----------------------------------------------------------------------------------
    " File navigation
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }                " Buscador de archivos difuso
    Plug 'junegunn/fzf.vim'                                               " Complemento de FZF para usarlo en NeoVim
    Plug 'Yggdroot/indentLine'                                            " Muestra los niveles de sangría
    Plug 'airblade/vim-rooter'                 " Cambia el directorio de trabajo de Vim a la raíz del proyecto.
    Plug 'pechorin/any-jump.vim'               " Ir a cualquier definición y referencia


    "----------------------------------------------------------------------------------
    " Auto Complete
    Plug 'neoclide/coc.nvim', {'branch': 'release'}      " Auto completado inteligente de VSCode
    "Plug 'Raimondi/delimitMate'                  " Auto completado para palabras dentro de las comillas


    "----------------------------------------------------------------------------------
    " Snippets
    Plug 'SirVer/ultisnips'                   " Snippets y generador de snippets
    "Plug 'MarcWeber/vim-addon-mw-utils'      " Librería para vim script
    Plug 'honza/vim-snippets'                " Snippets generales para NeoVim (snipmate y ultisnips)


    "----------------------------------------------------------------------------------
    " Git
    Plug 'https://github.com/theniceboy/fzf-gitignore', { 'do': ':UpdateRemotePlugins' }       " Usa .gitignore para la busqueda en FZF
    Plug 'mhinz/vim-startify'               " Proporciona una pantalla de inicio para NeoVim
    "Plug 'tpope/vim-fugitive'               " Poder para Git en NeoVim (TODO: Documentar las funcionalidades)
    Plug 'cohama/agit.vim'                  " Muestra historial de git <F5>

    "----------------------------------------------------------------------------------
    " Autoformat
    "Plug 'google/vim-maktaba'   " Biblioteca de complementos de vimscript
    "Plug 'google/vim-codefmt'   " Utilidad para el formateo de código consciente de la sintaxis
    Plug 'z0mbix/vim-shfmt', { 'for': 'sh' } " Formateo de código bash


    "----------------------------------------------------------------------------------
    " HTML, CSS, JavaScript, Typescript, PHP, JSON, etc.
    Plug 'alvan/vim-closetag'                " Cerrar automáticamente (X) etiquetas HTML
    "Plug 'styled-components/vim-styled-components', { 'branch': 'main' }  " Archivos de sintaxis para styled-components
    Plug 'AndrewRadev/tagalong.vim'         " Auto rename tag from HTML & JSX
    Plug 'ap/vim-css-color'                 " Resaltado de colores para CSS
    Plug 'tpope/vim-projectionist'          " Configuración granular del proyecto
    "Plug 'fatih/vim-go' , { 'for': ['go', 'vim-plug'], 'tag': '*' }
    Plug 'artur-shaik/vim-javacomplete2' " Autocomplete for java
    Plug 'uiiaoo/java-syntax.vim' " Syntax java
    Plug 'chr4/nginx.vim'                   " Syntax para nginx
    Plug 'shawncplus/phpcomplete.vim'
    Plug 'jwalton512/vim-blade'             " Soporte para Blade


    "----------------------------------------------------------------------------------
    " Editor Enhancement
        " Plugins only for Linux
    if system('uname -o') =~? "GNU/Linux"
        Plug 'eslint/eslint'                    " Añade eslint a vim
        Plug 'phpactor/phpactor', {'for': 'php', 'tag': '*', 'do': 'composer install --no-dev -o'}
        Plug 'stephpy/vim-php-cs-fixer'
        Plug 'mhinz/vim-signify'                  " Muestra la diferencia entre lineas creadas y eliminadas con signos +,-, en repositorios git
        Plug 'svermeulen/vim-cutlass'             " Agrega una operación de 'cortar' separada de 'eliminar'
        Plug 'svermeulen/vim-yoink'               " Complemento de Vim que mantiene un historial de yanks para alternar entre pegar
        Plug 'voldikss/vim-floaterm'             " Permite ejecutar ventanas flotantes
        Plug 'tpope/vim-dispatch'                " Despachador de prueba y compilación asincrónica
        Plug 'SergioRibera/vim-screenshot', { 'do': 'npm install --prefix Renderizer' } " Permite tomar capturas de pantalla
        Plug 'lambdalisue/suda.vim'              " Permite escribir y leer archivos como usuario sudo
    endif

    Plug 'luarocks/luarocks'                " Instalar luarocks
    Plug 'sheerun/vim-polyglot'
    Plug 'yuezk/vim-js', { 'for': ['vim-plug', 'php', 'jsx', 'html', 'javascript', 'css', 'less'] } " Resaltado de syntax para js
    Plug 'tpope/vim-surround'                " Permite citar / poner entre paréntesis simplificado
    Plug 'mg979/vim-visual-multi'            " Complemento de cursores múltiples (Varias lineas)
    Plug 'ryanoasis/vim-devicons'            " Agrega iconos de tipo de archivo a los complementos de Vim
    " Plug 'svermeulen/vim-subversive'         " Complemento para reemplazar rápidamente el texto
    Plug 'luochen1990/rainbow'               " Paréntesis de arcoíris
    Plug 'tpope/vim-eunuch'                   " Funcionalidades de Unix, POTENCIA para Vim
    Plug 'easymotion/vim-easymotion'             " VIM a velocidad increíble con shortcuts (Movimiento en el archivo actual)
    Plug 'vim-test/vim-test'                   " Contenedor para ejecutar test de cualquier lenguaje, TODO: Develop
    Plug 'kamykn/spelunker.vim'               " Corrector ortográfico para NeoVim
    Plug 'editorconfig/editorconfig-vim'      " Editor config interprete para Vim
    Plug 'jbgutierrez/vim-better-comments'    " Resaltado de comentarios para NeoVim
    Plug 'jiangmiao/auto-pairs'               " Complemento para inserte o elimine corchetes, pares, comillas en pares
    Plug 'sunaku/tmux-navigate'               " Complemento para navegar entre paneles de tmux y de vim sin problemas
    Plug 'tmux-plugins/vim-tmux-focus-events' " Actualiza Los eventos de focus cuando se usa vim dentro de tmux
    Plug 'preservim/tagbar'                   " Muestra las variables y métodos de una clase
    Plug 'octol/vim-cpp-enhanced-highlight'  " Resaltado de syntax para c++
    Plug 'godlygeek/tabular'
    Plug 'preservim/vim-markdown'
    Plug 'vim-scripts/indentpython.vim'
    "Plug 'nvie/vim-flake8'
    Plug 'puremourning/vimspector', {'do': './install_gadget.py --all'}
    Plug 'github/copilot.vim'

    "----------------------------------------------------------------------------------
    " Themes
    " If you want to have icons in your statusline choose one of these
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'joshdick/onedark.vim'              " Tema dark para NeoVim
    Plug 'mhartington/oceanic-next'
    Plug 'christianchiarulli/nvcode-color-schemes.vim'
    Plug 'rakr/vim-one'
    Plug 'gosukiwi/vim-atom-dark'
    Plug 'sonph/onehalf'
    Plug 'EdenEast/nightfox.nvim'
    Plug 'wadackel/vim-dogrun'
    Plug 'ghifarit53/tokyonight-vim'
    Plug 'Avimitin/neovim-deus'
    Plug 'vim-syntastic/syntastic'

    " Plugins only for Linux
    if system('uname -o') =~? "GNU/Linux"

       "----------------------------------------------------------------------------------
       "Auto-import
       Plug 'ludovicchabant/vim-gutentags'                             " Complemento que administra sus archivos de etiquetas
       Plug 'kristijanhusak/vim-js-file-import', {'do': 'npm install'} " Import/requiere archivos de js y typescript con un solo botón.
       Plug 'sahibalejandro/vim-php'                                   " PHP Companion

       Plug 'quark-zju/vim-cpp-auto-include'                           " Auto include c++
       Plug 'mgedmin/python-imports.vim'                               " Auto import python

       "----------------------------------------------------------------------------------
       " Tex
       Plug 'lervag/vimtex'        " Complemento para archivos LaTeX.
       Plug 'xuhdev/vim-latex-live-preview'         " Preview para LaTeX salida en PDF, :LLPStartPreview
    endif

call plug#end()
