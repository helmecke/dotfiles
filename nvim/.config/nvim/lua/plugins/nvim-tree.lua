vim.g.nvim_tree_show_icons = { git = 0, folders = 1, files = 1, folder_arrows = 1 }
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_special_files = {}
vim.g.nvim_tree_root_folder_modifier = ':p:~'
vim.g.nvim_tree_highlight_opened_files = 0
vim.g.nvim_tree_icons = {
  default = '',
  symlink = '',
}

require('nvim-tree').setup {
  update_cwd = true,
}

vim.api.nvim_set_keymap('n', '<c-f>', '<cmd>NvimTreeToggle<cr>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>l', '<cmd>NvimTreeFindFile<cr>', { silent = true })
