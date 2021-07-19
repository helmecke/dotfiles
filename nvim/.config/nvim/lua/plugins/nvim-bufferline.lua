require'bufferline'.setup{
  options = {
    offsets = {{filetype = "NvimTree", text = "File Explorer", highlight = "Directory", text_align = "left"}},
    show_close_icon = false,
    show_buffer_close_icons = false,
    diagnostics = "nvim_lsp",
  }
}

vim.api.nvim_set_keymap('n', '<leader>bp', '<cmd>BufferLinePick<cr>', {silent=true})
