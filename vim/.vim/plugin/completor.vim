let g:completor_gocode_binary = '~/Documents/Go/bin/gocode-gomod'

inoremap <Expr> <Tab> pumvisible() ? "\<C-N>" : "\<Tab>"
inoremap <Expr> <S-Tab> pumvisible() ? "\<C-P>" : "\<S-Tab>"
