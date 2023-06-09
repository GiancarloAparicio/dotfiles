" Autoload
source ~/.config/nvim/autoload/autoload.vim

" Load Plugins
source ~/.config/nvim/plugins/load.plugins.vim

"Common configuration Plugins
source ~/.config/nvim/config-plugins/ale.plugin.vim
source ~/.config/nvim/config-plugins/airline.plugin.vim
source ~/.config/nvim/config-plugins/babel.plugin.vim
source ~/.config/nvim/config-plugins/coc.plugin.vim
source ~/.config/nvim/config-plugins/fzf.plugin.vim
source ~/.config/nvim/config-plugins/indent-line.plugin.vim
source ~/.config/nvim/config-plugins/startify.plugin.vim
source ~/.config/nvim/config-plugins/ultisnips.plugin.vim
source ~/.config/nvim/config-plugins/js-imports.plugin.vim
source ~/.config/nvim/config-plugins/blade.formatter.plugin.vim
source ~/.config/nvim/config-plugins/php-namespace.plugin.vim
source ~/.config/nvim/config-plugins/php-companion.plugin.vim
source ~/.config/nvim/config-plugins/syntaxis.plugin.vim
source ~/.config/nvim/config-plugins/easymotion.plugin.vim
source ~/.config/nvim/config-plugins/test.plugin.vim
source ~/.config/nvim/config-plugins/markdown-preview.plugin.vim
source ~/.config/nvim/config-plugins/latex-preview.plugin.vim
source ~/.config/nvim/config-plugins/windows.plugin.vim
source ~/.config/nvim/config-plugins/editor-config.plugin.vim
source ~/.config/nvim/config-plugins/agit.plugin.vim
source ~/.config/nvim/config-plugins/closetag.plugin.vim
source ~/.config/nvim/config-plugins/tagalong.plugin.vim
source ~/.config/nvim/config-plugins/prettier.plugin.vim
source ~/.config/nvim/config-plugins/python.plugin.vim
source ~/.config/nvim/config-plugins/multi-cursor.plugin.vim
source ~/.config/nvim/config-plugins/vim-cutlass.plugin.vim
source ~/.config/nvim/config-plugins/shfmt.plugin.vim
source ~/.config/nvim/config-plugins/laravel-vim.plugin.vim
source ~/.config/nvim/config-plugins/vim-rooter.plugin.vim
source ~/.config/nvim/config-plugins/vim-yoink.plugin.vim
source ~/.config/nvim/config-plugins/gitgutter.plugin.vim
source ~/.config/nvim/config-plugins/gutentags.plugin.vim

" Mappings
source ~/.config/nvim/maps/general.map.vim
source ~/.config/nvim/maps/resize.map.vim
source ~/.config/nvim/maps/auto-imports-js.map.vim

" Settings
source ~/.config/nvim/settings/autocmd.settings.vim
source ~/.config/nvim/settings/file.settings.vim
source ~/.config/nvim/settings/custom.settings.vim
source ~/.config/nvim/settings/advanced-new-file.settings.vim
source ~/.config/nvim/settings/artisan.settings.vim
source ~/.config/nvim/settings/general.settings.vim

"#-----------------------------------------------------------------
"# Configuration for os
let g:system = system('uname -o')

if g:system =~? 'Android'
  " Load only on

  " Configuration provider python in termux
  let g:python3_host_prog = '/data/data/com.termux/files/usr/bin/python3'
  let g:python_host_prog = '/data/data/com.termux/files/usr/bin/python2'
elseif g:system =~? 'GNU/Linux'
  source ~/.config/nvim/config-plugins/screenshot.plugin.vim

endif

" Themes
source ~/.config/nvim/themes/onedark.theme.vim
