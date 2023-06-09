"let g:vim_json_syntax_conceal = 0
"let g:vim_markdown_conceal = 0
"let g:vim_markdown_conceal_code_blocks = 0

" General set relative_number
syntax on
filetype on
set nocompatible

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

set termguicolors
set mouse=a     " Habilita la interacción con el mouse
set clipboard^=unnamed,unnamedplus  " Permite copiar/pegar entre vim y el clipboard del sistema

set number relativenumber
set cursorline

let g:loaded_netrw       = 0
let g:loaded_netrwPlugin = 0

" TextEdit might fail if hidden is not set.
set hidden
set linebreak	    "Break lines at word (requires Wrap lines)
set showbreak=+++ 	" Wrap-broken line prefix
set textwidth=160	" Line wrap (number of cols)
set showmatch	    " Highlight matching brace
set spell	        " Enable spell-checking
set spelllang=en,es
set spellfile=~/.config/nvim/spell/en.utf-8.add
set errorbells	    " Beep or flash screen on errors
set visualbell	    " Use visual bell (no beeping)

set hlsearch	" Highlight all search results
set smartcase	" Enable smart-case search
set ignorecase	" Always case-insensitive
set incsearch	" Searches for strings incrementally
set autoread  " Carga automáticamente los archivos si estos cambian fuera de vim
set autowrite " Guarda los archivos automáticamente fuere de vim
set lazyredraw            " improve scrolling performance when navigating through large results
set regexpengine=1        " use old RegExp engine

set exrc            " habilita archivos .vimrc por proyecto (Configuración personalizada para cada proyecto)
set secure          " deshabilita comandos inseguros en archivos .vimrc locales

set mmp=10000  " Aumenta maxmempattern

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

"Indent
set expandtab
set tabstop=2
set cinkeys-=:
set autoindent	    " Auto-indent new lines
set shiftwidth=4	" Number of auto-indent spaces
set smartindent	    " Enable smart-indent
set smarttab	    " Enable smart-tabs
set softtabstop=4	" Number of spaces per Tab

" Advanced
set ruler	" Show row and column ruler information

set undolevels=1000	" Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour

set noswapfile


set list
set listchars=tab:\|\ ,trail:▫
set scrolloff=4
set ttimeoutlen=0
set notimeout
set viewoptions=cursor,folds,slash,unix
set tw=0
set indentexpr=
set foldmethod=indent
set foldlevel=99
set foldenable
set formatoptions-=tc
set splitright
set splitbelow
set noshowmode
set showcmd
set wildmenu
" set shellcmdflag=-ic " Establece una terminal interactiva (permite ejecutar alias desde vim)

if exists('&inccommand')
  set inccommand=split
endif

set completeopt=longest,noinsert,menuone,noselect,preview
set ttyfast "should make scrolling faster

" Remember the line when close
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
