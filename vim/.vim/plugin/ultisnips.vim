let g:UltiSnipsSnippetsDir = '~/.vim/ultisnips'
let g:UltiSnipsSnippetDirectories = [$HOME.'/.vim/ultisnips', 'UltiSnips']

" use enter as expand trigger
let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0

function! ExpandSnippetOrCarriageReturn()
  let snippet = UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res > 0
    return snippet
  else
    return "\<cr>"
  endif
endfunction

inoremap <expr> <cr> pumvisible() ? "<c-r>=ExpandSnippetOrCarriageReturn()<cr>" : "\<cr>"
