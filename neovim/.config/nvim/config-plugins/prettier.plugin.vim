" Comando para formatear :Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile


" Prettier for PHP
function PrettierPhpFormat()
  let view = winsaveview()

  " Get full name current file
  if expand('%:t') =~? 'blade.php$'
    !blade-formatter --write %
  else
    !prettier --parser=php --write --ignore-unknown %
  endif

  " Clear prompt
  echon ''

  edit!
  call winrestview(view)
endfunction

" define custom command
command PrettierPhp call PrettierPhpFormat()


