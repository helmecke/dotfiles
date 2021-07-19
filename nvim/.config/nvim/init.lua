require 'configs' -- ./lua/configs/init.lua
require 'plugins' -- ./lua/plugins/init.lua
-- require 'as.globals'
-- require 'as.highlights'
-- require 'as.statusline'

-- vim.cmd([[autocmd BufHidden * lua require('galaxyline').load_galaxyline()]])
vim.cmd([[
function! Browse(pathOrUrl)
  " This doesn't work with /usr/bin/vim on macOS (doesn't identify as macOS).
  if has('mac')| let openCmd = 'open'| else| let openCmd = 'xdg-open'| endif
    silent execute "! " . openCmd . " " . shellescape(a:pathOrUrl, 1)| " Escape Path or URL and pass as arg to open command.
    echo openCmd . " " shellescape(a:pathOrUrl, 1)| " Echo what we ran so it's visible.
endfunction

command! -nargs=1 Browse call Browse(<q-args>)|
]])
