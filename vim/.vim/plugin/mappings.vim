set pastetoggle=<F2>

inoremap jj <ESC>
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h
nnoremap <space> za

cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>

" umlaute remap {{{1
map ü <C-]>
map ö [
map ä ]
map Ö {
map Ä }
map ß /

" Leader mappings {{{1
let mapleader=","

map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

map <leader>t :tabnew<cr>

map <silent> <leader><space> :noh<CR>

nnoremap <c-t> :FZF!<CR>

map <silent> <Leader>n :call NumberToggle()<CR>

map <leader>/ <plug>NERDCommenterToggle
nnoremap <Leader>f :NERDTreeToggle<Enter>

nnoremap <silent> <Leader>bd :Bclose<CR>
nnoremap <silent> <Leader>bD :Bclose!<CR>
nnoremap <silent> <Leader>Bd :bufdo bw<CR>
nnoremap <silent> <Leader>BD :bufdo bw!<CR>

" wl-clipboard mappings {{{1
xnoremap "+y y:call system("wl-copy", @")<cr>
nnoremap "+p :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<cr>p
nnoremap "*p :let @"=substitute(system("wl-paste --no-newline --primary"), '<C-v><C-m>', '', 'g')<cr>p
