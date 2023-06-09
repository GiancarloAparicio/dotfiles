let g:polyglot_disabled = ['php.plugin']

"Put this function at the very end of your vimrc file.
function! PhpSyntaxOverride()
  " Put snippet overrides in this function.
  hi! link phpDocTags phpDefine
  hi! link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END

hi phpUseNamespaceSeparator guifg=#808080 guibg=NONE gui=NONE
hi phpClassNamespaceSeparator guifg=#808080 guibg=NONE gui=NONE

syn match phpParentOnly "[()]" contained containedin=phpParent
hi phpParentOnly guifg=#f08080 guibg=NONE gui=NONE


