local lspconfig = require('lspconfig')

local on_attach = function(client)
  local noremap = { noremap = true, silent = true }
  local expr = { expr = true, silent = true }

  -- See `:help nvim_buf_set_keymap()` for more information
  vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', noremap)
  vim.api.nvim_buf_set_keymap(0, 'n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', noremap)
  vim.api.nvim_buf_set_keymap(0, 'n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>', noremap)
  vim.api.nvim_buf_set_keymap(0, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', noremap)
  vim.api.nvim_buf_set_keymap(0, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', noremap)

  vim.api.nvim_buf_set_keymap(0, 'n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', noremap)
  vim.api.nvim_buf_set_keymap(0, 'n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', noremap)
  vim.api.nvim_buf_set_keymap(0, 'n', 'gl', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', noremap)

  -- Use LSP as the handler for omnifunc.
  --    See `:help omnifunc` and `:help ins-completion` for more information.
  vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.api.nvim_win_set_option(0, 'signcolumn', 'yes')

  -- vim.api.nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
  -- vim.api.nvim_command [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
  -- vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
  }
)

vim.fn.sign_define('LspDiagnosticsSignError', { text = "", texthl = "LspDiagnosticsError" })
vim.fn.sign_define('LspDiagnosticsSignWarning', { text = "", texthl = "LspDiagnosticsWarning" })
vim.fn.sign_define('LspDiagnosticsSignInformation', { text = "", texthl = "LspDiagnosticsInformation" })
vim.fn.sign_define('LspDiagnosticsSignHint', { text = "", texthl = "LspDiagnosticsHint" })

lspconfig.gopls.setup{on_attach=on_attach}

lspconfig.tflint.setup{on_attach=on_attach}
lspconfig.terraformls.setup{on_attach=on_attach}


lspconfig.pyls.setup{
  on_attach=on_attach,
  settings = {
    pyls = {
      configurationSources = {'flake8'},
      plugins = {
        autopep8 = {enabled = false},
        black = {enabled = true},
        flake8 = {enabled = true},
        mccabe = {enabled = false},
        pycodestyle = {enabled = false},
        pyflakes = {enabled = false},
        yapf = {enabled = false}
      }
    }
  }
}

-- lspconfig.yamlls.setup{
--   on_attach=on_attach,
--   settings = {
--     yaml = {
--       validate = true,
--       format = {
--         singleQuote = true,
--         enable = true
--       },
--       completion = true
--     }
--   }
-- }

-- lspconfig.sumneko_lua.setup{
--  settings = {
--    Lua = {
--      diagnostics = {
--        enable = true,
--        globals = { "vim" },
--      },
--    }
--  },
--  on_attach = on_attach
-- }

lspconfig.diagnosticls.setup{
  on_attach=on_attach,
  filetypes = { "sh", 'go' },
  init_options = {
    filetypes = {
      sh = "shellcheck",
      go = {'golint', 'golangci'},
    },
    formatFiletypes = {
      sh = "shfmt",
    },
    formatters = {
      shfmt = {
        command = "shfmt",
        args = {
          "-i",
          "2",
          "-bn",
          "-ci",
          "-sr",
        },
      }
    },
    linters = {
      shellcheck = {
        command = "shellcheck",
        rootPatterns = {},
        isStdout = true,
        isStderr = false,
        debounce = 100,
        args = { "--format=gcc", "-"},
        offsetLine = 0,
        offsetColumn = 0,
        sourceName = "shellcheck",
        formatLines = 1,
        formatPattern = {
          "^([^:]+):(\\d+):(\\d+):\\s+([^:]+):\\s+(.*)$",
          {
            line = 2,
            column = 3,
            endline = 2,
            endColumn = 3,
            message = {5},
            security = 4
          }
        },
        securities  = {
          error  ="error",
          warning = "warning",
          note = "info"
        },
      },
      golangci = {
        command = 'golangci-lint',
        rootPatterns = {'go.mod'},
        debounce = 100,
        args = {'run', '--out-format=json'},
        sourceName = 'golangci-lint',
        parseJson = {
          sourceName = 'Pos.Filename',
          sourceNameFilter = true,
          errorsRoot = 'Issues',
          line = 'Pos.Line',
          column = 'Pos.Column',
          message = '${Text} [${FromLinter}]'
        }
      },
      golint = {
        command = 'golint',
        rootPatterns = {'go.mod'},
        isStdout = true,
        isStderr = false,
        debounce = 100,
        args = {'%filepath'},
        offsetLine = 0,
        offsetColumn = 0,
        formatLines = 1,
        formatPattern = {
          '^[^:]+:(\\d+):(\\d+):\\s(.*)$',
          {line = 1, column = 2, message = 3}
        },
      }
    }
  }
}
