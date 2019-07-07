setlocal noexpandtab tabstop=4 shiftwidth=4 foldmethod=syntax foldnestmax=2

nmap <buffer> <C-g> :GoDeclsDir<cr>
imap <buffer> <C-g> <esc>:<C-u>GoDeclsDir<cr>

" :GoBuild and :GoTestCompile
nmap <buffer> <leader>gb :<C-u>call <SID>build_go_files()<CR>

" :GoTest
nmap <buffer> <leader>gt <Plug>(go-test)

" :GoRun
nmap <buffer> <leader>gr <Plug>(go-run)

" :GoDoc
nmap <buffer> <Leader>gd <Plug>(go-doc)

" :GoCoverageToggle
nmap <buffer> <Leader>gc <Plug>(go-coverage-toggle)

" :GoInfo
nmap <buffer> <Leader>gi <Plug>(go-info)

" :GoMetaLinter
nmap <buffer> <Leader>gl <Plug>(go-metalinter)

" :GoDef but opens in a vertical split
nmap <buffer> <Leader>gv <Plug>(go-def-vertical)
" :GoDef but opens in a horizontal split
nmap <buffer> <Leader>gs <Plug>(go-def-split)

" :GoAlternate  commands :A, :AV, :AS and :AT
command! -bang A call go#alternate#Switch(<bang>0, 'edit',,)
command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit',,)
command! -bang AS call go#alternate#Switch(<bang>0, 'split',,)
command! -bang AT call go#alternate#Switch(<bang>0, 'tabe',,)
