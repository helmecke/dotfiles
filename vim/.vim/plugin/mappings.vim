set pastetoggle=<f2>

inoremap jj <esc>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <c-h> <c-w>h
nnoremap <space> za

" umlaute remap {{{1
map ü <c-]>
map Ü <c-o>
map ö [
map ä ]
map Ö {
map Ä }
map ß /

" Leader mappings {{{1
let mapleader=","
let maplocalleader=";"

nnoremap <leader><leader> <c-^>
nnoremap <leader>o :only<cr>
nnoremap <leader>bd :bw<cr>
nnoremap <leader>bD :bw!<cr>
nnoremap <leader>Bd :bufdo bw<cr>
nnoremap <leader>BD :bufdo bw!<cr>

nnoremap <silent> <leader><space> :noh<cr>

" wl-clipboard mappings {{{1
xnoremap "+y y:call system("wl-copy", @")<cr>
nnoremap "+p :let @"=substitute(system("wl-paste --no-newline"), '<c-v><c-m>', '', 'g')<cr>p
nnoremap "*p :let @"=substitute(system("wl-paste --no-newline --primary"), '<c-v><c-m>', '', 'g')<cr>p
