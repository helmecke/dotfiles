set pastetoggle=<F2>

inoremap jj <Esc>
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h
nnoremap <Space> za

" umlaute remap {{{1
map ü <C-]>
map Ü <C-O>
map ö [
map ä ]
map Ö {
map Ä }
map ß /

" Leader mappings {{{1
let mapleader=","
let maplocalleader=";"

nnoremap <Leader><Leader> <C-^>
nnoremap <Leader>o :only<CR>
nnoremap <Leader>bd :bw<CR>
nnoremap <Leader>bD :bw!<CR>
nnoremap <Leader>Bd :bufdo bw<CR>
nnoremap <Leader>BD :bufdo bw!<CR>

nnoremap <Silent> <Leader><Space> :noh<CR>

" wl-clipboard mappings {{{1
xnoremap "+y y:call system("wl-copy", @")<CR>
nnoremap "+p :let @"=substitute(system("wl-paste --no-newline"), '<C-V><C-M>', '', 'g')<CR>p
nnoremap "*p :let @"=substitute(system("wl-paste --no-newline --primary"), '<C-V><C-M>', '', 'g')<CR>p

