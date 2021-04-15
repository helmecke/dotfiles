vim.g.db_ui_show_help = 0
vim.g.dbui_disable_mappings = 0

vim.o.previewheight=20

vim.api.nvim_set_keymap('n', '<leader>db', '<cmd>DBUIToggle<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', '<Plug>(DBExe)', [[db#op_exec()]], {noremap = true, expr = true})
vim.api.nvim_set_keymap('n', '<Plug>(DBExe)', [[db#op_exec()]], {noremap = true, expr = true})
vim.api.nvim_set_keymap('n', '<Plug>(DBExeLine)', [[db#op_exec() . '_']], {noremap = true, expr = true})

vim.api.nvim_set_keymap('x', '<leader>d', '<Plug>(DBExe)', {})
vim.api.nvim_set_keymap('n', '<leader>d', '<Plug>(DBExe)', {})
vim.api.nvim_set_keymap('o', '<leader>d', '<Plug>(DBExe)', {})
vim.api.nvim_set_keymap('n', '<leader>dl', '<Plug>(DBExeLine)', {})
