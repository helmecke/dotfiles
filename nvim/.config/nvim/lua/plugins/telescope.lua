local telescope = require 'telescope'

telescope.setup {
  extensions = {
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    }
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    file_browser = {
      hidden = true,
    },
    buffers = {
      sort_lastused = true,
      show_all_buffers = true,
      mappings = {
        i = { ["<c-d>"] = "delete_buffer" },
        n = { ["<c-d>"] = "delete_buffer" },
      },
    },
  },
}

telescope.load_extension'fzy_native'
telescope.load_extension'gh'
telescope.load_extension'ghq'

vim.api.nvim_set_keymap('n', '<a-g>', '<cmd>Telescope ghq list<cr>', {noremap=true})

require("which-key").register({
  ["<leader>"] = {
    b = {
      name = "+buffer",
      b = { "<cmd>Telescope buffers<cr>", "Find buffer" },
    },
    f = {
      name = "+find",
      f = { "<cmd>Telescope find_files<cr>", "Find file" },
      g = { "<cmd>Telescope live_grep<cr>", "Find string" },
      r = { "<cmd>Telescope oldfiles<cr>", "Find recent file" },
      m = { "<cmd>Telescope man_pages<cr>", "Find man page" },
    },
    g = {
      name = "+git",
      r = { "<cmd>Telescope ghq list<cr>", "Find repository" },
      f = { "<cmd>Telescope git_files<cr>", "Find file" },
      c = { "<cmd>Telescope git_commits<cr>", "Find commit" },
      b = { "<cmd>Telescope git_branches<cr>", "Find branch" },
      s = { "<cmd>Telescope git_status<cr>", "Find change" },
      S = { "<cmd>Telescope git_stash<cr>", "Find stash" },
      C = { "<cmd>Telescope git_bcommits<cr>", "Find buffer commit" },
    },
  },
})
