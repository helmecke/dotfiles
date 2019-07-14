let g:completor_gocode_binary = '~/Documents/Go/bin/gocode-gomod'

inoremap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
