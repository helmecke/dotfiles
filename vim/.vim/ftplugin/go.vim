setlocal tabstop=4 shiftwidth=4 foldmethod=syntax

map <Buffer> <Localleader>b <Plug>(go-build)
map <Buffer> <Localleader>r <Plug>(go-run)
map <Buffer> <Localleader>t <Plug>(go-test)
map <Buffer> <Localleader>i <Plug>(go-info)
map <Buffer> <Localleader>c <Plug>(go-coverage-toggle)
map <Buffer> <Localleader>a <Plug>(go-alternate-edit)
map <Buffer> <Localleader>as <Plug>(go-alternate-split)
map <Buffer> <Localleader>av <Plug>(go-alternate-vertical)

map <Buffer> <Silent> <C-]> <Plug>(go-def)
