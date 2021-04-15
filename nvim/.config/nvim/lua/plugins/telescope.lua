vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fl', '<cmd>Telescope live_grep<cr>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fgr', '<cmd>Telescope ghq list<cr>', {noremap=true})
vim.api.nvim_set_keymap('n', '<c-g>', '<cmd>Telescope git_files<cr>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fgs', '<cmd>Telescope git_status<cr>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fgc', '<cmd>Telescope git_commits<cr>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fgb', '<cmd>Telescope git_branches<cr>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', {noremap=true})
vim.api.nvim_set_keymap('n', '<a-g>', '<cmd>Telescope ghq list<cr>', {noremap=true})
vim.api.nvim_set_keymap('n', '<c-b>', '<cmd>Telescope buffers<cr>', {noremap=true})

require'telescope'.setup {
  defaults = {
    file_sorter = require'telescope.sorters'.get_fzy_sorter,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    }
  }
}
require'telescope'.setup{}

require'telescope'.load_extension'fzy_native'
require'telescope'.load_extension'gh'
require'telescope'.load_extension'ghq'
