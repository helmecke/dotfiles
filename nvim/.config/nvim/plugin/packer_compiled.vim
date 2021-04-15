" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/home/jahe/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/jahe/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/jahe/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/jahe/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/jahe/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  NeoSolarized = {
    config = { "require'plugins.neosolarized'" },
    loaded = true,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/start/NeoSolarized"
  },
  ["glow.nvim"] = {
    commands = { "Glow" },
    loaded = false,
    needs_bufread = false,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/opt/glow.nvim"
  },
  ["goyo.vim"] = {
    commands = { "Goyo" },
    loaded = false,
    needs_bufread = false,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/opt/goyo.vim"
  },
  ["iron.nvim"] = {
    config = { "require'plugins.iron'" },
    loaded = true,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/start/iron.nvim"
  },
  ["jupytext.vim"] = {
    config = { "require'plugins.jupytext'" },
    loaded = true,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/start/jupytext.vim"
  },
  ["limelight.vim"] = {
    commands = { "Limelight" },
    loaded = false,
    needs_bufread = false,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/opt/limelight.vim"
  },
  ["markdown-preview.nvim"] = {
    commands = { "MarkdownPreview" },
    loaded = false,
    needs_bufread = false,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim"
  },
  nerdcommenter = {
    config = { "require'plugins.nerdcommenter'" },
    loaded = true,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/start/nerdcommenter"
  },
  nerdtree = {
    commands = { "NERDTreeToggle", "NERDTreeFind" },
    loaded = false,
    needs_bufread = false,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/opt/nerdtree"
  },
  ["nvim-compe"] = {
    config = { "require'plugins.nvim-compe'" },
    loaded = true,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    config = { "require'plugins.lsp'" },
    loaded = true,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    config = { "require'plugins.treesitter'" },
    loaded = true,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim"
  },
  ["telescope-ghq.nvim"] = {
    loaded = true,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/start/telescope-ghq.nvim"
  },
  ["telescope-github.nvim"] = {
    loaded = true,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/start/telescope-github.nvim"
  },
  ["telescope.nvim"] = {
    config = { "require'plugins.telescope'" },
    loaded = true,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["vim-airline"] = {
    config = { "require'plugins.airline'" },
    loaded = true,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/start/vim-airline"
  },
  ["vim-airline-themes"] = {
    loaded = true,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/start/vim-airline-themes"
  },
  ["vim-arduino"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/opt/vim-arduino"
  },
  ["vim-dadbod"] = {
    loaded = true,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/start/vim-dadbod"
  },
  ["vim-dadbod-completion"] = {
    loaded = true,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/start/vim-dadbod-completion"
  },
  ["vim-dadbod-ui"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/opt/vim-dadbod-ui"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/start/vim-rhubarb"
  },
  ["vim-sayonara"] = {
    config = { "require('plugins.sayonara')" },
    loaded = true,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/start/vim-sayonara"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-terraform"] = {
    config = { "require'plugins.vim-terraform'" },
    loaded = true,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/start/vim-terraform"
  },
  ["vim-textobj-hydrogen"] = {
    loaded = true,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/start/vim-textobj-hydrogen"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/start/vim-textobj-user"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/start/vim-unimpaired"
  },
  vimwiki = {
    config = { "require'plugins.vimwiki'" },
    loaded = true,
    path = "/home/jahe/.local/share/nvim/site/pack/packer/start/vimwiki"
  }
}

-- Setup for: limelight.vim
require'plugins.limelight'
-- Setup for: goyo.vim
require'plugins.goyo'
-- Setup for: vim-arduino
require'plugins.arduino'
-- Setup for: vim-dadbod-ui
require'plugins.dadbod-ui'
vim.cmd [[packadd vim-dadbod-ui]]
-- Setup for: nerdtree
require'plugins.nerdtree'
-- Config for: iron.nvim
require'plugins.iron'
-- Config for: nvim-treesitter
require'plugins.treesitter'
-- Config for: vimwiki
require'plugins.vimwiki'
-- Config for: jupytext.vim
require'plugins.jupytext'
-- Config for: nerdcommenter
require'plugins.nerdcommenter'
-- Config for: nvim-compe
require'plugins.nvim-compe'
-- Config for: vim-terraform
require'plugins.vim-terraform'
-- Config for: nvim-lspconfig
require'plugins.lsp'
-- Config for: vim-airline
require'plugins.airline'
-- Config for: vim-sayonara
require('plugins.sayonara')
-- Config for: NeoSolarized
require'plugins.neosolarized'
-- Config for: telescope.nvim
require'plugins.telescope'

-- Command lazy-loads
vim.cmd [[command! -nargs=* -range -bang -complete=file MarkdownPreview lua require("packer.load")({'markdown-preview.nvim'}, { cmd = "MarkdownPreview", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Limelight lua require("packer.load")({'limelight.vim'}, { cmd = "Limelight", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Goyo lua require("packer.load")({'goyo.vim'}, { cmd = "Goyo", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Glow lua require("packer.load")({'glow.nvim'}, { cmd = "Glow", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file NERDTreeFind lua require("packer.load")({'nerdtree'}, { cmd = "NERDTreeFind", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file NERDTreeToggle lua require("packer.load")({'nerdtree'}, { cmd = "NERDTreeToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
vim.cmd [[au FileType arduino ++once lua require("packer.load")({'vim-arduino'}, { ft = "arduino" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'markdown-preview.nvim', 'glow.nvim'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType vimwiki ++once lua require("packer.load")({'markdown-preview.nvim', 'glow.nvim'}, { ft = "vimwiki" }, _G.packer_plugins)]]
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
vim.cmd [[source /home/jahe/.local/share/nvim/site/pack/packer/opt/vim-arduino/ftdetect/arduino.vim]]
vim.cmd("augroup END")
END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
