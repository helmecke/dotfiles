let g:go_list_height = 10 " vim default list height
let g:go_fmt_command = "goimports"
let g:go_def_mapping_enabled = 0

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

map <buffer> <localleader>b <plug>(go-build)
map <buffer> <localleader>r <plug>(go-run)
map <buffer> <localleader>t <plug>(go-test)
map <buffer> <localleader>i <plug>(go-info)
map <buffer> <localleader>c <plug>(go-coverage-toggle)
map <buffer> <localleader>a <plug>(go-alternate-edit)
map <buffer> <localleader>as <plug>(go-alternate-split)
map <buffer> <localleader>av <plug>(go-alternate-vertical)

map <buffer> <silent> <c-]> <plug>(go-def)
