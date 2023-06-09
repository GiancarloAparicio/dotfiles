"#-----------------------------------------------------------------
"# Toggle line number

function! s:ToggleLineNumber()
  let l:show_lines=&number
  let l:current_line_relative=&relativenumber

  if ( l:show_lines == 1  || l:current_line_relative == 1 )
    set nonumber
    set norelativenumber
  else
    set number
    set relativenumber
  endif
endfunction

" Define Custom command
command! -nargs=0 -bar ToggleLineNumber call s:ToggleLineNumber()

"#-----------------------------------------------------------------
"# Toggle git history
let s:is_active_git_history = 0

function! s:ToggleHistoryGit()

  if ( s:is_active_git_history == 0 )
    let s:is_active_git_history = 1
    AgitFile
  else

    let s:is_active_git_history = 0
    tabclose
  endif

endfunction

" Define Custom command
command! -nargs=0 -bar ToggleHistoryGit call s:ToggleHistoryGit()


"#-----------------------------------------------------------------
"# Scroll
function! s:ScrollQuarter(move)
    let l:height=winheight(0)

    if a:move == 'up'
      let l:key="\<C-Y>"
    else
      let l:key="\<C-E>"
    endif

    execute 'normal! ' . l:height/3 . l:key
endfunction

command! -nargs=0 -bar UpScroll call s:ScrollQuarter('up')
command! -nargs=0 -bar DownScroll call s:ScrollQuarter('down')

"#-----------------------------------------------------------------
"# Set Transparent Background
let g:set_transparent_background='y'

function! s:TransparentBackground()
  if g:set_transparent_background == 'n'
    highlight Normal ctermbg=none
    highlight NonText ctermbg=none

    highlight Normal guibg=none
    highlight NonText guibg=none

    let g:set_transparent_background = 'y'

  elseif g:set_transparent_background == 'y'
    colorscheme onedark
    let g:set_transparent_background = 'n'

    " Colors for sing on ALE
    highlight ALEErrorSign guifg=#ff2222 ctermfg=1
    highlight ALEWarningSign guifg=#bbbb00 ctermfg=3

  endif
endfunction

command! -nargs=0 -bar TransparentBackground  call s:TransparentBackground(<f-args>)



"#-----------------------------------------------------------------
"# Formatter for sql
function! s:FormatSql()
  let view = winsaveview()
  execute "!which sqlformat && (sqlformat -k \"upper\" -r % > %.bak; cat %.bak > %; rm %.bak)"
  echon ''

  edit!
  call winrestview(view)
endfunction

" define custom command
command! FormatSql call s:FormatSql()


"#-----------------------------------------------------------------
"# Function exec find and replace to files
function! s:findAndReplace(old, new, files)
  let l:files=a:files
  if a:files == '%'
      let l:files = expand('%')
  endif

  let l:replace = join([a:old, a:new, l:files], " ")
  execute  '!zsh -c ". ~/.zshrc; sd ' . l:replace . '" ; '
endfunction

function! s:getInputFindAndReplace()
  let l:old = input('Find: ', '')
  let l:new = input('Replace with: ', '')
  let l:files = input('File mask: ', '', 'file')

  silent call s:findAndReplace(l:old, l:new, l:files)
endfunction

command! -nargs=0 -bar FindAndReplace  call s:getInputFindAndReplace()


"#-----------------------------------------------------------------
"# Commands
command! -nargs=0 -bar PreviewMarkdown  CocCommand markdown-preview-enhanced.openPreview


"#-----------------------------------------------------------------
"# Function para diccionario
function! FzfSpellSink(word)
  exe 'normal! "_ciw'.a:word
endfunction

function! FzfSpell()
  let suggestions = spellsuggest(expand("<cword>"))
  return fzf#run({'source': suggestions, 'sink': function("FzfSpellSink"), 'down': 10 })
endfunction

function! SaveNewWord(word)
  call inputsave()
  if input(" Confirm add new word (y/n): ") == "y"
    exec "spellgood ".a:word
  endif
  call inputrestore()
endfunction
