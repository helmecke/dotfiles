vim.g.mapleader = ','
vim.g.maplocalleader = ';'

vim.api.nvim_set_keymap('n', '<leader><leader>', '<c-^>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>cd', '<cmd>cd %:p:h<CR><cmd>pwd<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader><space>', '<cmd>nohlsearch<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<c-j>', '<c-w>j', {noremap=true})
vim.api.nvim_set_keymap('n', '<c-k>', '<c-w>k', {noremap=true})
vim.api.nvim_set_keymap('n', '<c-l>', '<c-w>l', {noremap=true})
vim.api.nvim_set_keymap('n', '<c-h>', '<c-w>h', {noremap=true})
