let g:EditorConfig_exclude_patterns = ['fugitive://.*']

let g:EditorConfig_exclude_patterns = ['scp://.*']

au FileType gitcommit let b:EditorConfig_disable = 1

