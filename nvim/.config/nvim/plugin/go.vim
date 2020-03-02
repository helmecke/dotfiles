let g:go_list_height = 10 " vim default list height
let g:go_fmt_command = "goimports"
let g:go_def_mapping_enabled = 0

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <silent> <localleader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <silent> <localleader>t <Plug>(go-test)
autocmd FileType go nmap <silent> <localleader>r <Plug>(go-run)
autocmd FileType go nmap <silent> <localleader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <silent> <localleader>ae <Plug>(go-alternate-edit)
autocmd FileType go nmap <silent> <localleader>av <Plug>(go-alternate-vertikal)
autocmd FileType go nmap <silent> <localleader>as <Plug>(go-alternate-split)
