" Move to word
map <silent> f <Plug>(easymotion-bd-w)
nmap <silent> f <Plug>(easymotion-overwin-w)

" Movimiento de búsqueda de n caracteres
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

" Esta opción establecida, vcoincidirá con ambos v y V, pero Vcoincidirá V solamente. Predeterminado: 0.
let g:EasyMotion_use_smartsign_us = 1 " US layout

" Esto aplica el mismo concepto, pero para símbolos y números. 1coincidirá 1 y !; !coincidencias !solo . Predeterminado: 0
let g:EasyMotion_use_smartsign_jp = 1 " JP layout

let g:EasyMotion_keys = 'abcdefghijkmlopqrstuvnyxwz'
