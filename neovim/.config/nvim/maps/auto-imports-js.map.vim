augroup VIM_JS_AUTOIMPORTS
  autocmd!
  autocmd FileType typescriptreact nnoremap <TAB> :JsFileImport<CR>
  autocmd FileType vue nnoremap <TAB> :JsFileImport<CR>
  autocmd FileType typescript nnoremap <TAB> :JsFileImport<CR>
  autocmd FileType javascript nnoremap <TAB> :JsFileImport<CR>
augroup END

augroup VIM_PYTHON_AUTOIMPORTS
    autocmd!
    autocmd FileType python nnoremap <TAB> :ImportName<CR>
augroup END


if system('uname -o') =~? "GNU/Linux"
  " C++ auto import
  augroup VIM_CPP_AUTOIMPORTS
    autocmd!
    autocmd! FileType cpp nnoremap <TAB> :ruby CppAutoInclude::process<cr>
  augroup END
endif
