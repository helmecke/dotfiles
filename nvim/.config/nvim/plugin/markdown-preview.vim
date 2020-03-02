function! g:Open_browser(url)
    silent exec "!qutebrowser --target window " . a:url . " &"
endfunction

let g:mkdp_browserfunc = 'g:Open_browser'
let g:mkdp_markdown_css='/home/jhe/Documents/Github/sindresorhus/github-markdown-css/github-markdown.css'
let g:mkdp_page_title = 'Preview: ${name}'

autocmd FileType markdown nmap <localleader>p <Plug>MarkdownPreviewToggle
