call plug#begin('~/.local/share/nvim/plugged')

Plug 'pangloss/vim-javascript', {'for':'javascript'}
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim', {'on':'Gist'}
Plug 'altercation/vim-colors-solarized'
Plug 'diepm/vim-rest-console'
Plug 'andrewstuart/vim-kubernetes'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf.vim', { 'do': './install --all' }
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'fatih/vim-go', { 'tag': 'v1.21', 'do': ':GoInstallBinaries' }
Plug 'mhinz/neovim-remote', { 'tag': 'v2.4.0' }
Plug 'neoclide/coc.nvim', {'branch':'release'}
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', {'on':'NERDTreeToggle'}
Plug 'stevearc/vim-arduino'
Plug 'towolf/vim-helm'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sirtaj/vim-openscad'

call plug#end()

colorscheme solarized

" save file if :make is called. Some plugins make use of this eg. vim-go
set autowrite
set noswapfile
set colorcolumn=80
set confirm
set cursorline
set ignorecase
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·,eol:¬
set nowrap
set number
set relativenumber
set scrolloff=3
set showbreak=﬌\ 
set showmatch
set smartcase
set splitbelow
set splitright
set wildmode=list:full
set nomodeline


" autocmd BufDelete * if len(filter(range(1, bufnr('$')), '! empty(bufname(v:val)) && buflisted(v:val)')) == 1 | quit | endif
autocmd QuickFixCmdPost [^l]* cwindow
autocmd QuickFixCmdPost l*    lwindow

autocmd BufNewFile,BufRead /tmp/helm-edit-* setlocal ft=yaml

command! Greview :execute ':Git! diff --staged' | :redraw!
command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!

set pastetoggle=<f2>

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <c-h> <c-w>h

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
" show only current window
nnoremap <silent> <leader>o :only<cr>
nnoremap <silent> <leader>bd :bw<cr>
nnoremap <silent> <leader>bD :bw!<cr>
nnoremap <silent> <leader>Bd :bufdo bw<cr>
nnoremap <silent> <leader>BD :bufdo bw!<cr>
" close buffer without closing window
nnoremap <silent> <leader>bc :bp<bar>sp<bar>bn<bar>bd<CR>

nnoremap <silent> <leader><space> :noh<cr>

" wl-clipboard mappings {{{1
xnoremap "+y y:call system("wl-copy", @")<cr>
nnoremap "+p :let @"=substitute(system("wl-paste --no-newline"), '<c-v><c-m>', '', 'g')<cr>p
nnoremap "*p :let @"=substitute(system("wl-paste --no-newline --primary"), '<c-v><c-m>', '', 'g')<cr>p
