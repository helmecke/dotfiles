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
  use {
    'hashivim/vim-terraform',
    config = [[require'plugins.vim-terraform']], -- ./vim-terraform.lua
  }
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tjdevries/nlua.nvim'
  use 'google/vim-jsonnet'
  use {
    'tpope/vim-fugitive',
    config = [[require'plugins.fugitive']], -- ./fugitive.lua
    requires = {
      'tpope/vim-rhubarb',
      {
        'shumphrey/fugitive-gitlab.vim',
        config = [[require'plugins.fugitive-gitlab']], -- ./fugitive-gitlab.lua
      },
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
  use {
    'moll/vim-bbye',
    config = function()
      vim.api.nvim_set_keymap('', '<leader>bd', '<cmd>Bdelete<cr>', { noremap = true, silent = true })
    end,
  }
  use {
    'kyazdani42/nvim-tree.lua',
    config = [[require'plugins.nvim-tree']], -- ./nvim-tree.lua
    requires = 'kyazdani42/nvim-web-devicons',
  }
  use {
    'neovim/nvim-lspconfig',
    config = [[require'plugins.nvim-lspconfig']], -- ./nvim-lspconfig.lua
  }
  use { 'creativenull/diagnosticls-nvim', requires = 'neovim/nvim-lspconfig' }
  use {
    'kabouzeid/nvim-lspinstall',
    config = [[require'plugins.nvim-lspinstall']], -- ./nvim-lspinstall.lua
    requires = 'neovim/nvim-lspconfig',
  }
  use {
    'hrsh7th/nvim-compe',
    config = [[require'plugins.nvim-compe']], -- ./nvim-compe.lua
  }
  use {
    'stevearc/vim-arduino',
    setup = [[require'plugins.vim-arduino']], -- ./vim-arduino.lua
    ft = 'arduino',
  }
  use {
    'nvim-telescope/telescope.nvim',
    config = [[require'plugins.telescope']], -- ./telescope.lua
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ghq.nvim',
      'nvim-telescope/telescope-github.nvim',
      'nvim-telescope/telescope-fzy-native.nvim',
      'ThePrimeagen/git-worktree.nvim',
    },
  }
  use {
    'hkupty/iron.nvim',
    config = [[require'plugins.iron']], -- ./iron.lua
  }
  use {
    'vimwiki/vimwiki',
    config = [[require'plugins.vimwiki']], -- ./vimwiki.lua
  }
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
      {
        'kristijanhusak/vim-dadbod-ui',
        config = [[require'plugins.vim-dadbod-ui']], -- ./vim-dadbod-ui.lua
      },
    },
  }
  use { 'diepm/vim-rest-console', ft = { 'rest' } }
  use {
    'windwp/nvim-autopairs',
    config = [[require'plugins.nvim-autopairs']], -- ./nvim-autopairs.lua
  }
  use {
    'akinsho/nvim-bufferline.lua',
    config = [[require'plugins.nvim-bufferline']], -- ./nvim-bufferline.lua
    requires = 'kyazdani42/nvim-web-devicons',
  }
  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    config = [[require'plugins.galaxyline']], -- ./galaxyline.lua
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }
  use { 'Glench/Vim-Jinja2-Syntax', ft = { 'jinja' } }
  use {
    'norcalli/nvim-colorizer.lua',
    config = [[require'plugins.nvim-colorizer']], -- ./nvim-colorizer.lua
  }
  use {
    'b3nj5m1n/kommentary',
    config = [[require'plugins.kommentary']], -- ./kommentary.lua
  }
  use {
    'tools-life/taskwiki',
    config = [[require'plugins.taskwiki']], -- ./taskwiki.lua
    requires = { 'powerman/vim-plugin-AnsiEsc', opt = true },
  }
  use {
    'oberblastmeister/neuron.nvim',
    config = [[require'plugins.neuron']], -- ./neuron.lua
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
  }
  use {
    'folke/which-key.nvim',
    config = [[require'plugins.which-key']], -- ./which-key.lua
  }
  use {
    'folke/zen-mode.nvim',
    config = [[require'plugins.zen-mode']], -- ./zen-mode.lua
  }
  use {
    disable = true,
    'aserowy/tmux.nvim',
    commit = '2a42166',
    config = [[require'plugins.tmux']], -- ./tmux.lua
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
