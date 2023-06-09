augroup VIM_PHP_COMPANION
    autocmd!
    autocmd FileType php nnoremap <TAB> :PHPImportClass<cr>
    autocmd FileType php nnoremap <Leader>e :PHPExpandFQCNAbsolute<cr>
    autocmd FileType php nnoremap <Leader>E :PHPExpandFQCN<cr>
augroup END
