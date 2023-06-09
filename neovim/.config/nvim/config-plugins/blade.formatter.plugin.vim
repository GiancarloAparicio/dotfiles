" Format for Blade
function FormatBladeCursor()
  let view = winsaveview()
  !blade-formatter --write --ignore-unknown %
  edit!
  call winrestview(view)
endfunction

" Define custom command
command FormatBlade call FormatBladeCursor()


