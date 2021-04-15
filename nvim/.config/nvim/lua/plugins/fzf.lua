vim.api.nvim_set_keymap('n', '<c-f>', '<cmd>Files<cr>', {silent = true})
vim.api.nvim_set_keymap('i', '<c-f>', '<cmd>Files<cr>', {silent = true})

vim.env.FZF_DEFAULT_COMMAND = "rg --files --hidden --follow --glob '!{.git,.cache,.npm}'"
