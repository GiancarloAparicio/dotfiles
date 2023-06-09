" Commands                        Mode
" --------                        ----
"nnoremap, nunmap, nmap          Normal mode
"inoremap, iunmap, imap         Insert and Replace mode
"vnoremap, vunmap, vmap         Visual and Select mode
"xnoremap, xunmap, xmap         Visual mode
"snoremap, sunmap, smap         Select mode
"cnoremap, cunmap, cmap         Command-line mode
"onoremap, ounmap, omap         Operator pending mode

" Set leader key
let mapleader="<space>"

" Activate easy mode (on=1; off=0)
let g:easy_mode=0

" Coc errors
" Coc mostrará los diagnósticos (errores y advertencias) en una información sobre herramientas para las palabras sobre las que coloque el cursor.
nnoremap <silent> K :call CocAction('doHover')<CR>
nnoremap <silent> <c-space> :call CocAction('doHover')<CR>

" Rehacer y deshacer
" nnoremap <silent> u u
nnoremap <silent> U <C-R>

" Close current Buffer
nnoremap <silent> qq :bd<CR>


" Moverse entre buffers
noremap <silent> <space><left>  :bprevious<Cr>
noremap <silent> <space><right> :bnext<Cr>
noremap <silent> <C-Left>  :bprevious<Cr>
noremap <silent> <C-Right> :bnext<Cr>


if  g:easy_mode

  " Comando para guardar el archivo con ctrl + s (En modo visual y en modo normal)
  nnoremap <C-s> :w<CR>
  inoremap <C-s> <c-o>:w<CR>

  " Funcionalidad para des-hacer un acción con 'ctrl + z'
  nnoremap <C-z> :u<CR>
  inoremap <C-z> <c-o>:u<CR>

  " Funcionalidad para re-hacer una acción con 'ctrl + y'
  nnoremap <C-y> <C-r>
  inoremap <C-y> <c-o><C-r>

  " Funcionalidad para cortar el texto seleccionado en vim con 'ctrl + x'
  vnoremap <C-x> "+c

  " Funcionalidad para copiar el texto seleccionado en vim con 'ctrl + c'
  vnoremap <C-c> "*y

  " Funcionalidad para pegar el contenido con 'ctrl + v'
  nnoremap <C-v> <ESC>"+pa
  inoremap <C-v> <c-o>:p<CR>

endif

" Navigate between tags locales and globals
nnoremap <silent> <C-l> :BTags<CR>
nnoremap <silent> <C-L> :Tags<CR>
nnoremap <silent> <space>l :BTags<CR>
nnoremap <silent> <space>L :Tags<CR>

" Show toggle preview git
nnoremap <silent> <F5> :ToggleHistoryGit<CR>

" Ejecuta el test mas cercano al cursor, de lo contrario ejecuta el ultimo test
nnoremap <silent> <F6> :TestNearest -strategy=floaterm<CR>

" Take screen shot to imágenes
vnoremap <silent> <F7> :TakeScreenShot<CR>

" Compile any file
function! s:compileFile(file)

  if !exists('a:file')
    let a:file = expand('%')
  endif

  execute  '!zsh -c ". ~/.zshrc; compile ' . a:file . ' "; '
endfunction

command -nargs=? -complete=file -bar Compile  call s:compileFile(<f-args>)
nnoremap <F8> :Compile %<CR>

" Find command in vim history
nnoremap <silent> <space>h :History:<CR>
cnoremap <silent> <C-h> History:<CR>
cnoremap <silent> <C-r> History:<CR>

" Scroll
nnoremap <silent> <C-k> :UpScroll<CR>
nnoremap <silent> <Space><Up> :UpScroll<CR>
nnoremap <silent> <C-j> :DownScroll<CR>
nnoremap <silent> <Space><Down> :DownScroll<CR>


" Find words in the project
nnoremap <silent> <C-f>  :Rg<CR>
vnoremap <silent> <C-f>  :Rg<CR>

" shortcut for far.vim find and replace
nnoremap <silent> <C-h>  :FindAndReplace<CR>
vnoremap <silent> <C-h>  :FindAndReplace<CR>

" Search and go to files to FZF
nnoremap <silent> <C-p> :Files<CR>

" Correct word with FZF
nnoremap <silent> . :call FzfSpell()<CR>

" Add word to list-completions
nnoremap <silent> , :call SaveNewWord(expand('<cword>'))<CR>

" Save document
nnoremap <space>s :w!<CR>
nnoremap <space>S :w!<CR>
nnoremap <c-s> :w!<CR>
nnoremap <c-S> :w!<CR>

" Enable folding with the spacebar
nnoremap <space><space> za

" Resize panels
nnoremap <silent> <C-r>  :ResizePanels<CR>

" Quit vim (Quit session)
function QuitVim()
  if input(" Do you want quit? [y/N]") =~? '^y\%[es]$'
    wq!
  else
      echon ''
  endif
endfunction

nnoremap <silent> <space>q :call QuitVim()<CR>
nnoremap <silent> <space>Q :call QuitVim()<CR>

" Split window
nnoremap <space>" :sp<CR>
nnoremap <space>% :vsp<CR>

" Muestra los métodos y variables de la clase
nmap <silent> <F9> :TagbarToggle<CR>

" Open last buffer
nnoremap zz :e #<CR>

" Open file in Obsidian vault
command IO execute 'silent !zsh -c ". ~/.zshrc; open \"obsidian://open?vault=🧠 Cerebro digital&file=' . expand('%:r') . '\";"'
nnoremap <space>ob :IO<CR>


"#-----------------------------------------------------------------
"# Debug
" Inicia el debug en el archivo
nnoremap <TAB>d :SignifyToggle<CR> :call vimspector#Launch()<CR>
" Reinicia el debug
nnoremap <TAB>r :call vimspector#Restart()<CR>
" Termina o sale del modo debug
nnoremap <TAB>q :SignifyToggle<CR> :call vimspector#Reset()<CR>
" Continua al siguiente breakpoint
nnoremap <TAB>n :call vimspector#Continue()<CR>
" Crea/Borra un breakpoint
nnoremap <TAB>b :call vimspector#ToggleBreakpoint()<CR>
" Borra todos los breakpoints
nnoremap <TAB>db :call vimspector#ClearBreakpoints()<CR>
" Ejecuta el codigo hasta el cursor
nnoremap <TAB>v :call vimspector#RunToCursor()<CR>

nmap <TAB>e :<c-u>call vimspector#Evaluate( expand('<cexpr>') )<CR>

" Sale del scope de una funcion o clase
nmap <TAB><UP> <Plug>VimspectorStepOut
" Entra dentro del scope de una funcion o clase
nmap <TAB><DOWN> <Plug>VimspectorStepInto
" Avanza a la siguiente linea
nmap <TAB><RIGHT> <Plug>VimspectorStepOver
" Agrego un vigilante a un variable, para ver como cambia su valor
nmap <TAB><LEFT> :call vimspector#AddWatch( expand('<cexpr>') )<CR>

nnoremenu WinBar.■\ Stop :call vimspector#Stop( { 'interactive': v:false } )<CR>
nnoremenu WinBar.▶\ Cont :call vimspector#Continue()<CR>
nnoremenu WinBar.▷\ Pause :call vimspector#Pause()<CR>
nnoremenu WinBar.↷\ Next :call vimspector#StepOver()<CR>
nnoremenu WinBar.→\ Step :call vimspector#StepInto()<CR>
nnoremenu WinBar.←\ Out :call vimspector#StepOut()<CR>
nnoremenu WinBar.⟲: :call vimspector#Restart()<CR>
nnoremenu WinBar.✕ :call vimspector#Reset( { 'interactive': v:false } )<CR>

nnoremap <C-b> :CocCommand explorer --toggle --position right --sources=file+<CR>
nnoremap <C-B>  :CocCommand explorer --toggle --position right --sources=file+<CR>

nnoremap <c-o> :FloatermNew<CR>

"#-----------------------------------------------------------------
"# nvim diff
if &diff
   map <space>1 :diffget LOCAL<CR>
   map <space>2 :diffget BASE<CR>
   map <space>3 :diffget REMOTE<CR>

   " Save document
   nmap qq :wqa!<CR>
endif
