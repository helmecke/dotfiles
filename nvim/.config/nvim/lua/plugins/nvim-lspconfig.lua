local lspconfig = require 'lspconfig'
local configs = require 'lspconfig/configs'

local on_attach = function(client)
  local noremap = { noremap = true, silent = true }
  local expr = { expr = true, silent = true }

  vim.lsp.set_log_level 'debug'

  -- See `:help nvim_buf_set_keymap()` for more information
  vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', noremap)
  vim.api.nvim_buf_set_keymap(0, 'n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', noremap)
  vim.api.nvim_buf_set_keymap(0, 'n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', noremap)
  vim.api.nvim_buf_set_keymap(0, 'n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', noremap)

  -- Use LSP as the handler for omnifunc.
  --    See `:help omnifunc` and `:help ins-completion` for more information.
  vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.api.nvim_win_set_option(0, 'signcolumn', 'yes')

  vim.api.nvim_command [[command! -buffer LspFormat lua vim.lsp.buf.formatting()]]

  -- vim.api.nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
  -- vim.api.nvim_command [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
  -- vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
end

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  signs = true,
})

vim.fn.sign_define('LspDiagnosticsSignError', { text = '', texthl = 'LspDiagnosticsError' })
vim.fn.sign_define('LspDiagnosticsSignWarning', { text = '', texthl = 'LspDiagnosticsWarning' })
vim.fn.sign_define('LspDiagnosticsSignInformation', { text = '', texthl = 'LspDiagnosticsInformation' })
vim.fn.sign_define('LspDiagnosticsSignHint', { text = '', texthl = 'LspDiagnosticsHint' })

lspconfig.terraformls.setup {
  on_attach = on_attach,
}

lspconfig.gopls.setup {
  on_attach = on_attach,
}

lspconfig.dotls.setup {
  on_attach = on_attach,
}

lspconfig.pylsp.setup {
  on_attach = on_attach,
  settings = {
    configurationSources = { 'flake8', 'black', 'mypy', 'isort' },
    plugins = {
      autopep8 = { enabled = false },
      black = { enabled = true },
      flake8 = { enabled = true },
      mccabe = { enabled = false },
      pycodestyle = { enabled = false },
      pyflakes = { enabled = false },
      yapf = { enabled = false },
    },
  },
}

lspconfig.yamlls.setup {
  on_attach = on_attach,
  settings = {
    yaml = {
      validate = false,
      hover = true,
      completion = true,
      schemaStore = { enable = true },
      schemas = {
        -- ['https://json.schemastore.org/ansible-role-2.9.json'] = 'roles/**/{yml,yaml}',
        -- ['https://json.schemastore.org/ansible-playbook.json'] = 'playbook*.{yml,yaml}',
        ['https://json.schemastore.org/gitlab-ci.json'] = {
          'gitlab-ci.{yml,yaml}',
          'gitlab-ci-templates/**/*.{yml,yaml}',
        },
      },
    },
  },
}

local shfmt = require 'lsp.diagnosticls.formatters.shfmt'
local shellcheck = require 'lsp.diagnosticls.linters.shellcheck'
local yamllint = require 'lsp.diagnosticls.linters.yamllint'
local ansible_lint = require 'lsp.diagnosticls.linters.ansible-lint'
local golangcilint = require 'lsp.diagnosticls.linters.golangci-lint'

lspconfig.diagnosticls.setup {
  on_attach = on_attach,
  filetypes = { 'sh', 'yaml', 'lua' },
  init_options = {
    filetypes = {
      sh = 'shellcheck',
      yaml = 'yamllint',
    },
    formatFiletypes = {
      sh = 'shfmt',
      lua = 'stylua',
    },
    formatters = {
      shfmt = shfmt,
      stylua = {
        rootPatterns = { '.git' },
        command = 'stylua',
        args = { '-' },
      },
    },
    linters = {
      shellcheck = shellcheck,
      yamllint = yamllint,
    },
  },
}

if not lspconfig.golangcilsp then
  configs.golangcilsp = {
    default_config = {
      cmd = { 'golangci-lint-langserver' },
      root_dir = lspconfig.util.root_pattern('.git', 'go.mod'),
      init_options = {
        command = { 'golangci-lint', 'run', '--enable-all', '--disable', 'lll', '--out-format', 'json' },
      },
    },
  }
end

lspconfig.golangcilsp.setup {
  filetypes = { 'go' },
}

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = '/usr/share/lua-language-server'
local sumneko_binary = '/usr/bin/lua-language-server'

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').sumneko_lua.setup {
  on_attach = on_attach,
  cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim', 'describe', 'use', 'awesome', 'client', 'root' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          -- vim.api.nvim_get_runtime_file('', true),
          ['/usr/share/nvim/runtime/lua'] = true,
          ['/usr/share/nvim/runtime/lua/lsp'] = true,
          ['/usr/share/awesome/lib'] = true,
        },
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

lspconfig.golangcilsp.setup {
  filetypes = { 'go' },
}
