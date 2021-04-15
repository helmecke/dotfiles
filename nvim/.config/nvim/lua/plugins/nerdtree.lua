local utils = require'utils'

vim.g.NERDTreeQuitOnOpen = 1
vim.g.NERDTreeAutoDeleteBuffer = 1
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeWinSize = 40

vim.api.nvim_set_keymap('n', '<c-f>', '<cmd>NERDTreeToggle<cr>', {silent=true})
vim.api.nvim_set_keymap('n', '<leader>l', '<cmd>NERDTreeFind %<cr>', {silent=true})
