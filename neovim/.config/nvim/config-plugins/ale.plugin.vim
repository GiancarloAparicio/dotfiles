let g:ale_disable_lsp = 1  "  Coc & Ale
let g:ale_fix_on_save = 1

let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠ '

"Mostrar mejor mensajes de error
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:ale_javascript_eslint_executable = 'eslint'
let g:ale_javascript_eslint_options = ''
let g:ale_javascript_eslint_use_global = 0

let g:ale_fixers = {
      \   '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'javascript': ['eslint']
      \}



" YAML lint
" Author: KabbAmine <amine.kabb@gmail.com>

call ale#Set('yaml_yamllint_executable', 'yamllint')
call ale#Set('yaml_yamllint_options', '')

call ale#linter#Define('yaml', {
\   'name': 'yamllint',
\   'executable': {b -> ale#Var(b, 'yaml_yamllint_executable')},
\   'command': function('ale#handlers#yamllint#GetCommand'),
\   'callback': 'ale#handlers#yamllint#Handle',
\})
