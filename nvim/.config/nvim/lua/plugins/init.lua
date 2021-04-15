local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
  if vim.fn.input("Download Packer? (y for yes)") ~= "y" then
    return
  end

  local directory = string.format(
    '%s/site/pack/packer/opt/',
    vim.fn.stdpath('data')
  )

  vim.fn.mkdir(directory, 'p')

  local out = vim.fn.system(string.format(
    'git clone %s %s',
    'https://github.com/wbthomason/packer.nvim',
    directory .. '/packer.nvim'
  ))

  print(out)
  print("Downloading packer.nvim...")

  return
end

vim.cmd[[autocmd BufWritePost */plugins/init.lua luafile %]]
vim.cmd[[autocmd BufWritePost */plugins/init.lua PackerSync]]
vim.cmd[[autocmd BufWritePost */plugins/init.lua PackerCompile]]

local packer = require('packer')
local use = packer.use

return packer.startup(function()
  -- Packer can manage itself as an optional plugin
  use {'wbthomason/packer.nvim', opt = true}

  use {'hashivim/vim-terraform',
    config = [[require'plugins.vim-terraform']]
  }
  -- Pairs of handy bracket mappings
  use {'tpope/vim-unimpaired'}
  use {'tpope/vim-repeat'}
  use {'tpope/vim-surround'}
  use {'tpope/vim-fugitive',
    requires = 'tpope/vim-rhubarb'
  }

  use {'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = [[require'plugins.treesitter']]
  }

  -- Colorscheme
  use {'overcache/NeoSolarized',
  config = [[require'plugins.neosolarized']]
  }

  use {'junegunn/fzf.vim',
    disable = true,
    setup = [[require('plugins.fzf')]],
    cmd = {'Files', 'Buffers'},
  }

  use {'vim-airline/vim-airline',
    config = [[require'plugins.airline']],
    requires = 'vim-airline/vim-airline-themes',
  }

  -- Buffer management
  use {'mhinz/vim-sayonara',
    config = [[require('plugins.sayonara')]]
  }

  use {'scrooloose/nerdtree',
    setup = [[require'plugins.nerdtree']],
    cmd = {'NERDTreeToggle', 'NERDTreeFind'},
  }

  use {'scrooloose/nerdcommenter',
    config = [[require'plugins.nerdcommenter']],
  }

  use {'neovim/nvim-lspconfig',
    config = [[require'plugins.lsp']],
  }

  use {'hrsh7th/nvim-compe',
    config = [[require'plugins.nvim-compe']]
  }

  use {'stevearc/vim-arduino',
    setup = [[require'plugins.arduino']],
    ft = 'arduino',
  }

  use {'nvim-telescope/telescope.nvim',
    config = [[require'plugins.telescope']],
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-ghq.nvim'},
      {'nvim-telescope/telescope-github.nvim'},
      {'nvim-telescope/telescope-fzy-native.nvim'}
    }
  }

  use {'hkupty/iron.nvim',
    config = [[require'plugins.iron']]
  }

  use {'vimwiki/vimwiki',
    config = [[require'plugins.vimwiki']]
  }

  use {'npxbr/glow.nvim',
    cmd = 'Glow', ft = {'markdown', 'vimwiki'}
  }
  use {'iamcco/markdown-preview.nvim',
    run = 'cd app & yarn install',
    ft = {'markdown', 'vimwiki'},
    cmd = 'MarkdownPreview',
  }

  use {'junegunn/goyo.vim',
    setup = [[require'plugins.goyo']],
    cmd = 'Goyo'
  }

  use {'junegunn/limelight.vim',
    setup = [[require'plugins.limelight']],
    cmd = 'Limelight'
  }

  use {'tpope/vim-dadbod',
    requires = {
      'kristijanhusak/vim-dadbod-completion',
      {'kristijanhusak/vim-dadbod-ui', setup = [[require'plugins.dadbod-ui']]},
    }
  }

  use {'goerz/jupytext.vim',
    config = [[require'plugins.jupytext']],
    requires = {
      'kana/vim-textobj-user',
      'GCBallesteros/vim-textobj-hydrogen',
    },
  }

end)
