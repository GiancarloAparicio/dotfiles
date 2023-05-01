----------------------------------------------------------------------------------------------------------------------------
------ KEYBINDINGS
----------------------------------------------------------------------------------------------------------------------------
lvim.leader     = "space"
vim.g.easy_mode = false

local nmap      = lvim.keys.normal_mode
local imap      = lvim.keys.insert_mode
local vmap      = lvim.keys.visual_mode

if vim.g.easy_mode then
    nmap["<C-s>"] = ":w<cr>"      -- guardar el archivo con ctrl + s (En modo normal)
    imap["<C-s>"] = "<c-o>:w<cr>" -- guardar el archivo con ctrl + s (En modo visual)

    nmap["<C-z>"] = ":u<cr>"      -- Deshace una acción ctrl + z (En modo normal)
    imap["<C-z>"] = "<c-o>:u<cr>" -- Deshace una acción ctrl + z (En modo visual)

    nmap["<C-y>"] = "<c-r>"       -- Re-hace una acción ctrl + y (En modo normal)
    imap["<C-y>"] = "<c-o><c-r>"  -- Re-hace una acción ctrl + y (En modo visual)

    vmap["<c-x>"] = '"+c'         -- Corta el texto seleccionado con ctrl +x
    vmap["<c-c>"] = '"*y'         -- Copia el texto seleccionado con ctrl +c

    nmap["<c-v>"] = '<ESC>"+pa'   -- Pega el texto del clipboard  con ctrl + v
    imap["<c-v>"] = '<ESC>"+pa'   -- Pega el texto del clipboard con ctrl + v
end

nmap["<S-u>"]            = "<C-r>"                    -- Re-hace una acción
nmap["zz"]               = ":e #<CR>"                 -- Abre el ultimo buffer que se cerro

nmap["<leader>s"]        = ":w!<CR>"                  -- Guarda el archivo actual
nmap["<leader>S"]        = ":w!<CR>"                  -- Guarda el archivo actual

nmap["<leader><leader>"] = "za"                       -- Toggle pliegue

nmap["qq"]               = ":BufferKill<CR>"          -- Cerrar el buffer actual
nmap["<leader><right>"]  = ":BufferLineCycleNext<CR>" -- Navegar al buffer derecho
nmap["<leader><left>"]   = ":BufferLineCyclePrev<CR>" -- Navegar al buffer izquierdo

-- Telescope
nmap["<c-f>"]            = ":lua require'telescope.builtin'.live_grep()<CR>"       -- Busca texto
imap["<c-f>"]            = "<ESC>:lua require'telescope.builtin'.live_grep()<CR>"  -- Busca texto
--nmap["<c-h>"]            = ":lua require'telescope.builtin'.command_history()<CR>" -- Busca texto
nmap["<c-h>"]            = "<cmd>lua require('spectre').open()<CR>"                -- Busca y reemplaza texto
nmap["<c-p>"]            = ":lua require'telescope.builtin'.find_files()<CR>"      -- Busca archivo
imap["<c-p>"]            = "<ESC>:lua require'telescope.builtin'.find_files()<CR>" -- Busca archivo

function _G.ScrollWindow(direction)
    local height = tonumber(vim.fn.winheight(0)) / 3
    local key
    if direction == "up" then
        key = "k"
    elseif direction == "down" then
        key = "j"
    end
    vim.cmd('normal! ' .. tostring(height) .. key)
end

nmap['jj'] = ':lua ScrollWindow("down")<CR>' -- Scroll hacia abajo
nmap['kk'] = ':lua ScrollWindow("up")<CR>'   -- Scroll hacia arriba


vim.g.is_active_git_history = false
function _G.ToggleHistoryGit()
    if vim.g.is_active_git_history then
        vim.g.is_active_git_history = false
        vim.cmd('tabclose')
    else
        vim.g.is_active_git_history = true
        vim.cmd('AgitFile')
    end
end

nmap['<F5>']  = ':lua ToggleHistoryGit()<CR>'      -- Show toggle preview git
imap['<F5>']  = '<ESC>:lua ToggleHistoryGit()<CR>' -- Show toggle preview git

nmap['.']     = ":lua require('telescope.builtin').spell_suggest(require('telescope.themes').get_cursor({}))<CR>"

nmap['<C-b>'] = ':NeoTreeShowToggle<CR>'
