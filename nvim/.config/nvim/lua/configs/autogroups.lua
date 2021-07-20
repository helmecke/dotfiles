local utils = require 'utils'

local autogroups = {
  neovim_terminal = {
    'TermOpen * startinsert',
    'TermOpen * :set nonumber norelativenumber',
    'TermOpen * nnoremap <buffer> <C-c> i<C-c>',
  },
}

utils.create_augroup(autogroups)
