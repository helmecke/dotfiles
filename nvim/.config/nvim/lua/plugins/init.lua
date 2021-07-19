local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
  if vim.fn.input 'Download Packer? (y for yes)' ~= 'y' then
    return
  end

  local directory = string.format('%s/site/pack/packer/opt/', vim.fn.stdpath 'data')

  vim.fn.mkdir(directory, 'p')

  local out = vim.fn.system(
    string.format('git clone %s %s', 'https://github.com/wbthomason/packer.nvim', directory .. '/packer.nvim')
  )

  print(out)
  print 'Downloading packer.nvim...'

  return
end

local packer = require 'packer'
local use = packer.use

return packer.startup(function()
  -- Packer can manage itself as an optional plugin
  use { 'wbthomason/packer.nvim', opt = true }
  use {
    '~/Git/github.com/helmecke/onedark.nvim',
    config = function()
      vim.cmd 'colorscheme onedark'
    end,
  }
  use { 'hashivim/vim-terraform', config = [[require'plugins.vim-terraform']] }
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tjdevries/nlua.nvim'
  use 'google/vim-jsonnet'
  use {
    'tpope/vim-fugitive',
    config = [[require'plugins.fugitive']],
    requires = {
      'tpope/vim-rhubarb',
      { 'shumphrey/fugitive-gitlab.vim', config = [[require'plugins.fugitive-gitlab']] },
    },
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = [[require'plugins.treesitter']], -- ./treesitter.lua
    requires = {
      'nvim-treesitter/playground',
    },
  }
  use { 'chriskempson/base16-vim', disable = true, config = [[require'plugins.base16-vim']] }
  use { 'mhinz/vim-sayonara', disable = true, config = [[require('plugins.sayonara')]] }
  use {
    'moll/vim-bbye',
    config = function()
      vim.api.nvim_set_keymap('', '<leader>bd', '<cmd>Bdelete<cr>', { noremap = true, silent = true })
    end,
  }
  use {
    'kyazdani42/nvim-tree.lua',
    config = [[require'plugins.nvim-tree']],
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
  }
  use { 'neovim/nvim-lspconfig', config = [[require'plugins.lsp']] }
  use { 'creativenull/diagnosticls-nvim', requires = 'neovim/nvim-lspconfig' }
  use {
    'kabouzeid/nvim-lspinstall',
    requires = 'neovim/nvim-lspconfig',
    config = function()
      require('lspinstall').setup {}
    end,
  }
  use { 'hrsh7th/nvim-compe', config = [[require'plugins.nvim-compe']] }
  use {
    'stevearc/vim-arduino',
    setup = function()
      vim.g.arduino_dir = '~/Documents/Arduino'
      vim.g.arduino_serial_port = '/dev/ttyUSB0'
    end,
    ft = 'arduino',
  }
  use {
    'nvim-telescope/telescope.nvim',
    config = [[require'plugins.telescope']],
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-ghq.nvim' },
      { 'nvim-telescope/telescope-github.nvim' },
      { 'nvim-telescope/telescope-fzy-native.nvim' },
    },
  }
  use {
    'ThePrimeagen/git-worktree.nvim',
    requires = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('git-worktree').setup {}
      require('telescope').load_extension 'git_worktree'
      require('which-key').register {
        ['<leader>'] = {
          g = {
            w = { '<cmd>Telescope git_worktree<cr>', 'Find worktree' },
          },
        },
      }
    end,
  }
  use { 'hkupty/iron.nvim', config = [[require'plugins.iron']] }
  use { 'vimwiki/vimwiki', config = [[require'plugins.vimwiki']] }
  use { 'npxbr/glow.nvim', cmd = 'Glow', ft = { 'markdown', 'vimwiki' } }
  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app & yarn install',
    ft = { 'markdown', 'vimwiki' },
    cmd = 'MarkdownPreview',
  }
  use {
    'tpope/vim-dadbod',
    requires = {
      'kristijanhusak/vim-dadbod-completion',
      { 'kristijanhusak/vim-dadbod-ui', setup = [[require'plugins.dadbod-ui']] },
    },
  }
  use { 'diepm/vim-rest-console', ft = { 'rest' } }
  use { 'windwp/nvim-autopairs', config = [[require'plugins.nvim-autopairs']] }
  use {
    'akinsho/nvim-bufferline.lua',
    config = [[require'plugins.nvim-bufferline']],
    requires = 'kyazdani42/nvim-web-devicons',
  }
  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    config = [[require'plugins.galaxyline']], -- ./galaxyline.lua
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }
  use { 'Glench/Vim-Jinja2-Syntax', ft = { 'jinja' } }
  use { 'norcalli/nvim-colorizer.lua', config = [[require'plugins.nvim-colorizer']] }
  use {
    'b3nj5m1n/kommentary',
    config = function()
      require('kommentary.config').configure_language('default', {
        prefer_single_line_comments = true,
      })
    end,
  }
  use {
    'tools-life/taskwiki',
    config = [[require'plugins.taskwiki']],
    requires = { 'powerman/vim-plugin-AnsiEsc', opt = true },
  }
  use {
    'oberblastmeister/neuron.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('neuron').setup {
        virtual_titles = true,
        mappings = true,
        run = nil, -- function to run when in neuron dir
        neuron_dir = '~/Git/gitlab.local.hacon.de/jahe/wiki', -- the directory of all of your notes, expanded by default (currently supports only one directory for notes, find a way to detect neuron.dhall to use any directory)
        leader = 'gz', -- the leader key to for all mappings, remember with 'go zettel'
      }
    end,
  }
  use {
    'folke/which-key.nvim',
    config = [[require'plugins.which-key']], -- ./which-key.lua
  }
  use {
    'folke/zen-mode.nvim',
    config = function()
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
    end,
  }
  use {
    'aserowy/tmux.nvim',
    commit = '2a42166',
    config = function()
      require('tmux').setup {
        -- overwrite default configuration
        -- here, e.g. to enable default bindings
        copy_sync = {
          -- enables copy sync and overwrites all register actions to
          -- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
          enable = false,
          redirect_to_clipboard = true,
        },
        navigation = {
          -- enables default keybindings (C-hjkl) for normal mode
          enable_default_keybindings = true,
          cycle_navigation = false,
        },
        resize = {
          -- enables default keybindings (A-hjkl) for normal mode
          enable_default_keybindings = true,
        },
      }
    end,
  }
  use {
    'vhyrro/neorg',
    config = [[require'plugins.neorg']], -- ./neorg.lua
    requires = 'nvim-lua/plenary.nvim',
  }
  use {
    'will133/vim-dirdiff',
    opt = true,
    cmd = { 'DirDiff' },
  }
end)
