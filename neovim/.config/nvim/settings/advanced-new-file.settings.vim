""" CONFIGURATION """

let g:ad_funct_create= 'ad'
let g:ad_height='35%'
let g:ad_key='<C-n>'


""" FUNCTIONALITY TO CREATE NEW FILE"""

let s:last_directory = ""

" Validate if the selected path is contaminated with '~ AnyThingsString', return the clean path without extra strings
function! s:ValidatePathDir(dir)
  let l:ValidateLastDir= matchstr(a:dir, '\~ Last selection$') " Regexp validate if a:dirname has '~ AnyThing'
  if !empty( l:ValidateLastDir )
    return split( a:dir,' \~ ')[0] " Return only a:dirname
  endif

  let l:ValidateWorkspaceRoot=  matchstr(a:dir, '\~ Workspace root$') " Regexp validate if a:dirname has '~ AnyThing'
  if !empty( l:ValidateWorkspaceRoot )
    return '.' " Return root project
  endif

  let l:ValidateCurrentPath= matchstr(a:dir, '\~ Current file$') " Regexp validate if a:dirname has '~ AnyThing'
  if !empty( l:ValidateCurrentPath )
    return expand('%:h') " Return current directory
  endif

  return a:dir

endfunction

" Create new file with path directory and name file
function! s:CreateFile(file)
  call inputsave()
  let s:last_directory= s:ValidatePathDir( s:last_directory )  " Update last directory to filename
  let l:new_file= s:last_directory  . '/' .  a:file         " Get full name file

  silent execute  '!zsh -c ". ~/.zshrc; ' . g:ad_funct_create . ' ' . l:new_file ' "; '
  silent execute 'e ' . l:new_file

  %s///ge
  call inputrestore()
endfunction


""" FZF INTEGRATION """

" Get a new name with fzf to create one or more files
function! s:GetFile(directory)
  let s:last_directory=a:directory " Save latest selection
  call fzf#run(fzf#wrap({'source': ':', 'down': g:ad_height, 'options': '--multi --reverse -i --prompt="New file: " --layout=default --print-query --read0 --preview "~/.config/nvim/bin/fzf-preview.sh ' . s:last_directory . ' "','sink':function('s:CreateFile')})) " Run fzf to get new file
endfunction


""" MAIN FUNCTION """
function! s:CreateNewFile()

  let l:list_to_dirs= ""
  if ( 0 < len(s:last_directory) )
    let l:list_to_dirs= l:list_to_dirs . 'echo "' . s:last_directory . ' ~ Last selection";'                 " Get latest selection directory if exists
  endif

  " Run in bash for get all directories with fd
  let l:list_to_dirs= l:list_to_dirs . 'echo ". ~ Workspace root";'                     " Get path workspace root
  let l:list_to_dirs= l:list_to_dirs . 'echo "' . expand('%:h') . ' ~ Current file";'    " Get path to current file
  let l:list_to_dirs= l:list_to_dirs . ' fd -H -t d -E $FZF_IGNORE;'                     " Get list directories

  " Call fzf to get a directory
  call fzf#run(fzf#wrap({'source': l:list_to_dirs, 'down': g:ad_height, 'options': '--multi --reverse --prompt=": " --layout=default  --preview "~/.config/nvim/bin/fzf-preview.sh {} " ' ,'sink': function('s:GetFile')}))
endfunction


" Define custom command to advanced new file
command! CreateNewFile  call s:CreateNewFile()

" Create new file with fzf
" Simple Created Relative Directory
execute 'nnoremap <silent>' . g:ad_key . ' :CreateNewFile<Cr>'
