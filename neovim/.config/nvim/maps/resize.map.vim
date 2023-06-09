
let s:save_cpo = &cpo
set cpo&vim


" Create/Change Splits
function! s:Resize(key)
  if (g:ez_window_splits)
    let t:curwin = winnr()
    exec "wincmd " . a:key
    if (t:curwin == winnr())
      if (match(a:key,'[jk]'))
        wincmd v
      else
        wincmd s
      endif
      exec "wincmd " . a:key | enew
    endif
  else
    exec "wincmd " . a:key
  endif
endfunction

" List of commands for 'Resize Mode'
function! s:ResizeCommands()
  let behavior = s:GetResizeBehavior()
  let commands = {
        \  'left'   : ':vertical resize ' . behavior['left']  . '2',
        \  'right'  : ':vertical resize ' . behavior['right'] . '2',
        \  'up'     : ':resize ' . behavior['up']   . '2',
        \  'down'   : ':resize ' . behavior['down'] . '2',
        \}
  return commands
endfun


" List of ASCII codes for each symbol
let s:code_list = {
     \  'left'   :'104',
     \  'down'   :'106',
     \  'up'     :'107',
     \  'right'  :'108',
     \  'finish' :'113',
     \}


" Create mapping for allowed directions in current split
function! s:GetEdgeInfo()
  let chk_direct = ['left', 'down', 'up', 'right']
  let result = {}
  for direct in chk_direct
    exe 'let result["' . direct . '"] = ' . !s:CanMoveCursorFromCurrentWindow(direct)
  endfor
  return result
endfun


" Get information about current split position
function! s:CanMoveCursorFromCurrentWindow(direct)
  let map_direct = {'left':'h', 'down':'j', 'up':'k', 'right':'l'}
  if has_key(map_direct, a:direct)
    let direct = map_direct[a:direct]
  elseif index(values(map_direct), a:direct) != -1
    let direct = a:direct
  endif
  let from = winnr()
  exe "wincmd " . direct
  let to = winnr()
  exe from . "wincmd w"
  return from != to
endfun


" Create correct mapping for resize movement
function! s:GetResizeBehavior()
  let signs = {'left':'-', 'down':'+', 'up':'-', 'right':'+'}
  let ei = s:GetEdgeInfo()
  if !ei['left'] && ei['right']
    let signs['left'] = '+'
    let signs['right'] = '-'
  endif
  if !ei['up'] && ei['down']
    let signs['up'] = '+'
    let signs['down'] = '-'
  endif
  return signs
endfun


" Resize Splits
function! s:ResizeMode(commands)
  echo "Start Resizing. Press 'q' to quit"

  let l:commands = a:commands

  while 1
    let l:c = getchar()

    if c == s:code_list['left'] "h
      exec l:commands['left']
    elseif c == s:code_list['down'] "j
      exec l:commands['down']
    elseif c == s:code_list['up'] "k
      exec l:commands['up']
    elseif c == s:code_list['right'] "l
      exec l:commands['right']
    elseif c == s:code_list['finish'] "q
      redraw
      echo "Finished!"
      break
    endif
    redraw
  endwhile
endfunction


" List of Commands
com! ResizeGoLeft call s:Resize('h')
com! ResizeGoDown call s:Resize('j')
com! ResizeGoUp call s:Resize('k')
com! ResizeGoRight call s:Resize('l')
com! ResizePanels call s:ResizeMode(s:ResizeCommands())


" List of Mappings
let s:default_start_key = '<C-m>'
let s:default_ez_window_keys = {
            \ 'left'  : '<A-h>',
            \ 'down'  : '<A-j>',
            \ 'up'    : '<A-k>',
            \ 'right' : '<A-l>',
            \}

let g:resize_start_key = get(g:, 'resize_start_key', s:default_start_key)
let g:ez_window_splits = get(g:, 'ez_window_splits', 1)


exe 'nnoremap <silent> '. g:resize_start_key .' :ResizePanels<CR>'
exe 'nnoremap <silent> '. s:default_ez_window_keys['left'] .' :ResizeGoLeft<CR>'
exe 'nnoremap <silent> '. s:default_ez_window_keys['down'] .' :ResizeGoDown<CR>'
exe 'nnoremap <silent> '. s:default_ez_window_keys['up'] .' :ResizeGoUp<CR>'
exe 'nnoremap <silent> '. s:default_ez_window_keys['right'] .' :ResizeGoRight<CR>'

if (g:ez_window_splits == 0)
  exe 'nnoremap <silent> <leader>- :split \| enew<CR>'
  exe 'nnoremap <silent> <leader>_ :vsplit \| enew<CR>'
endif

let &cpo = s:save_cpo
