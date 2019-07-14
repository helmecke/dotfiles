function! NumberToggle()
  if(&relativenumber == 1)
    set number
    set norelativenumber
  else
    set relativenumber
    set number
  endif
endfunction

map <silent> <leader>n :call NumberToggle()<cr>
