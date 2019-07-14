setlocal tabstop=4 shiftwidth=4 foldmethod=syntax

map <buffer> <localleader>b <plug>(go-build)
map <buffer> <localleader>r <plug>(go-run)
map <buffer> <localleader>t <plug>(go-test)
map <buffer> <localleader>i <plug>(go-info)
map <buffer> <localleader>c <plug>(go-coverage-toggle)
map <buffer> <localleader>a <plug>(go-alternate-edit)
map <buffer> <localleader>as <plug>(go-alternate-split)
map <buffer> <localleader>av <plug>(go-alternate-vertical)

map <buffer> <silent> <c-]> <plug>(go-def)
