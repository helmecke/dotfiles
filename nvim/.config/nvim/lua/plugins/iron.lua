vim.api.nvim_set_keymap('n', '<leader>r<cr>', '<Plug>(iron-cr)', {silent=true})
vim.api.nvim_set_keymap('n', '<leader>r', '<Plug>(iron-send-motion)', {silent=true})
vim.api.nvim_set_keymap('v', '<leader>r', '<Plug>(iron-visual-send)', {silent=true})
vim.api.nvim_set_keymap('n', '<leader>rl', '<Plug>(iron-send-line)', {silent=true})

vim.g.iron_map_defaults = 0
vim.g.iron_map_extended = 0

local iron = require('iron')

iron.core.set_config {
  repl_open_cmd = "vsplit"
}

