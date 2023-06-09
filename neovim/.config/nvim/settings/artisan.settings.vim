" let g:artisan_command="!php artisan"
let g:artisan_command="!docker-compose run --rm artisan"

"Function exec Artisan
function! s:CreatePolicy(...)
  let l:policy=substitute(a:1,'\(\<\w\+\>\)', '\u\1', 'g')
  silent exec g:artisan_command . ' make:policy ' . l:policy . 'Policy --model=' . l:policy

  let l:new_policy=system('fd ' . l:policy . 'Policy')

  silent exec "e " . l:new_policy
endfunction

" Define custom command
command -nargs=1 Apolicy  call s:CreatePolicy(<f-args>)
