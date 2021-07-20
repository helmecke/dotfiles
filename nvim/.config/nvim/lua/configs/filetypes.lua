local utils = require 'utils'

local filetypes = {
  c = {
    'tabstop=2',
    'shiftwidth=2',
    'expandtab',
  },
  cucumber = {
    'tabstop=4',
    'shiftwidth=4',
    'expandtab',
  },
  python = {
    'colorcolumn=88',
  },
  conf = {
    'tabstop=4',
    'shiftwidth=4',
    'expandtab',
  },
  lua = {
    'tabstop=2',
    'shiftwidth=2',
    'expandtab',
  },
  jinja = {
    'tabstop=2',
    'shiftwidth=2',
    'expandtab',
  },
  yaml = {
    'tabstop=2',
    'shiftwidth=2',
    'expandtab',
    'iskeyword-=_',
  },
  jsonnet = {
    'tabstop=2',
    'shiftwidth=2',
    'expandtab',
  },
  zsh = {
    'tabstop=2',
    'shiftwidth=2',
    'expandtab',
    'foldmethod=expr',
    'foldexpr=ZshFolds(v:lnum)',
    'foldtext=ZshFoldText()',
  },
  git = {
    'foldmethod=syntax',
  },
  gitcommit = {
    'nofoldenable',
  },
  json = {
    'tabstop=2',
    'shiftwidth=2',
    'expandtab',
    'foldmethod=expr',
    'foldexpr=nvim_treesitter#foldexpr()',
  },
}

utils.create_filetype(filetypes)
