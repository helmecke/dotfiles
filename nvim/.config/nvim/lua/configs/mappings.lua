vim.g.mapleader = ','
vim.g.maplocalleader = ';'

vim.api.nvim_set_keymap('', '<leader><leader>', '<c-^>', {noremap=true})
vim.api.nvim_set_keymap('', '<leader>cd', '<cmd>cd %:p:h<CR><cmd>pwd<CR>', {noremap=true})
vim.api.nvim_set_keymap('', '<leader><space>', '<cmd>nohlsearch<CR>', {noremap=true})
vim.api.nvim_set_keymap('', '<leader>bc', '<cmd>bw<cr>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('', '<c-j>', '<c-w>j', {noremap=true})
vim.api.nvim_set_keymap('', '<c-k>', '<c-w>k', {noremap=true})
vim.api.nvim_set_keymap('', '<c-l>', '<c-w>l', {noremap=true})
vim.api.nvim_set_keymap('', '<c-h>', '<c-w>h', {noremap=true})
-- traversing text in insert mode like in terminal
vim.api.nvim_set_keymap('i', '<a-f>', '<c-o>f', {noremap=true})
vim.api.nvim_set_keymap('i', '<a-b>', '<c-o>b', {noremap=true})
vim.api.nvim_set_keymap('i', '<c-f>', '<c-o>l', {noremap=true})
vim.api.nvim_set_keymap('i', '<c-b>', '<c-o>h', {noremap=true})
vim.api.nvim_set_keymap('i', '<c-a>', '<c-o>0', {noremap=true})
vim.api.nvim_set_keymap('i', '<c-e>', '<c-o>$', {noremap=true})
vim.api.nvim_set_keymap('i', '<c-e>', '<c-o>$', {noremap=true})
vim.api.nvim_set_keymap('i', '<c-u>', '<c-o>d0', {noremap=true})
vim.api.nvim_set_keymap('i', '<c-k>', '<c-o>d$', {noremap=true})
vim.api.nvim_set_keymap('i', '<c-y>', '<c-o>P', {noremap=true})
vim.api.nvim_set_keymap('i', '<c-_>', '<c-o>u', {noremap=true})

vim.api.nvim_set_keymap('', '<leader>ots', '<cmd>botright sp +te<CR>', {noremap=true})
vim.api.nvim_set_keymap('', '<leader>otv', '<cmd>botright vs +te<CR>', {noremap=true})
vim.api.nvim_set_keymap('', '<leader>ott', '<cmd>tabe +te<CR>', {noremap=true})
