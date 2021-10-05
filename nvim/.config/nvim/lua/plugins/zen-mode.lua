require('zen-mode').setup {
  window = {
    backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    width = 120, -- width of the Zen window
    height = 1, -- height of the Zen window
    options = {
      signcolumn = 'no', -- disable signcolumn
      number = false, -- disable number column
      relativenumber = false, -- disable relative numbers
      cursorline = false, -- disable cursorline
      cursorcolumn = false, -- disable cursor column
      colorcolumn = '121',
      foldcolumn = '0', -- disable fold column
      list = false, -- disable whitespace characters
    },
  },
  plugins = {
    options = {
      enabled = true,
      ruler = true, -- disables the ruler text in the cmd line area
      showcmd = true, -- disables the command in the last line of the screen
    },
    tmux = { enabled = true }, -- disables the tmux statusline
    kitty = {
      enabled = true,
      font = '+4', -- font size increment
    },
  },
}

require('which-key').register {
  ['<leader>'] = {
    t = {
      name = '+toggle',
      z = { '<cmd>ZenMode<cr>', 'Zen Mode' },
    },
  },
}
