local gl = require 'galaxyline'
local condition = require'galaxyline.condition'
local fileinfo = require 'galaxyline.provider_fileinfo'
local devicons = require 'nvim-web-devicons'

local colors = {
  bg = '#073642',
  yellow = '#b58900',
  cyan = '#2aa198',
  darkblue = '#081633',
  green = '#859900',
  orange = '#cb4b16',
  purple = '#5d4d7a',
  magenta = '#d33682',
  grey = '#c0c0c0',
  blue = '#268bd2',
  red = '#dc322f'
}

local gls = gl.section
local function u(code)
  if type(code) == 'string' then
    code = tonumber('0x' .. code)
  end
  local c = string.char
  if code <= 0x7f then
    return c(code)
  end
  local t = {}
  if code <= 0x07ff then
    t[1] = c(bit.bor(0xc0, bit.rshift(code, 6)))
    t[2] = c(bit.bor(0x80, bit.band(code, 0x3f)))
  elseif code <= 0xffff then
    t[1] = c(bit.bor(0xe0, bit.rshift(code, 12)))
    t[2] = c(bit.bor(0x80, bit.band(bit.rshift(code, 6), 0x3f)))
    t[3] = c(bit.bor(0x80, bit.band(code, 0x3f)))
  else
    t[1] = c(bit.bor(0xf0, bit.rshift(code, 18)))
    t[2] = c(bit.bor(0x80, bit.band(bit.rshift(code, 12), 0x3f)))
    t[3] = c(bit.bor(0x80, bit.band(bit.rshift(code, 6), 0x3f)))
    t[4] = c(bit.bor(0x80, bit.band(code, 0x3f)))
  end
  return table.concat(t)
end

local mode_map = {
  ['n'] = {'NORMAL', colors.grey},
  ['i'] = {'INSERT', colors.yellow},
  ['R'] = {'REPLACE', colors.grey},
  ['v'] = {'VISUAL', colors.grey},
  ['V'] = {'V-LINE', colors.grey},
  ['c'] = {'COMMAND', colors.grey},
  ['s'] = {'SELECT', colors.grey},
  ['S'] = {'S-LINE', colors.grey},
  ['t'] = {'TERMINAL', colors.grey},
  [''] = {'V-BLOCK', colors.grey},
  [''] = {'S-BLOCK', colors.grey},
  ['Rv'] = {'VIRTUAL'},
  ['rm'] = {'--MORE'},
}

local sep = {
  right_filled = u '2590',
  left_filled = u '258c',
  -- right_filled = u 'e0b2',
  -- left_filled = u 'e0b0',
  right = u '2503',
  left = u '2503',
  -- right = u 'e0b3',
  -- left = u 'e0b1',
}

local icons = {
  locker = u 'f023',
  unsaved = u 'f693',
  dos = u 'e70f',
  unix = u 'f17c',
  mac = u 'f179',
  lsp_warn = u 'f071',
  lsp_error = u 'f46e',
}

local function mode_label() return mode_map[vim.fn.mode()][1] or 'N/A' end
local function mode_hl() return mode_map[vim.fn.mode()][2] or colors.none end

local function highlight(group, fg, bg, gui)
  local cmd = string.format('highlight %s guifg=%s guibg=%s', group, fg, bg)
  if gui ~= nil then
    cmd = cmd .. ' gui=' .. gui
  end
  vim.cmd(cmd)
end

local function buffer_not_empty()
  if vim.fn.empty(vim.fn.expand '%:t') ~= 1 then
    return true
  end
  return false
end

local function diagnostic_exists()
  return vim.tbl_isempty(vim.lsp.buf_get_clients(0))
end

local function wide_enough()
  local squeeze_width = vim.fn.winwidth(0)
  if squeeze_width > 80 then
    return true
  end
  return false
end


i = 1
gls.left[i] = {
  ViMode = {
    provider = function()
      local modehl = mode_hl()
      highlight('GalaxyViMode', colors.bg, modehl, 'bold')
      highlight('GalaxyViModeInv', modehl, colors.bg, 'bold')
      return string.format('  %s ', mode_label())
    end,
    separator = sep.left_filled,
    separator_highlight = 'GalaxyViModeInv',
  }
}

i = i + 1
gls.left[i] = {
  GitIcon = {
    provider = function() return '  ' end,
    condition = buffer_not_empty,
    highlight = {colors.orange,colors.bg},
  }
}

i = i + 1
gls.left[i] = {
  GitBranch = {
    provider = 'GitBranch',
    separator = ' ',
    separator_highlight = {colors.purple,colors.bg},
    condition = buffer_not_empty,
    highlight = {colors.fg, colors.bg},
  }
}

i = i + 1
gls.left[i] = {
  FileIcon = {
    provider = function()
      local fname, ext = vim.fn.expand '%:t', vim.fn.expand '%:e'
      local icon, iconhl = devicons.get_icon(fname, ext)
      if icon == nil then
        return ''
      end
      local fg = vim.fn.synIDattr(vim.fn.hlID(iconhl), 'fg')
      highlight('GalaxyFileIcon', fg, colors.bg)
      return ' ' .. icon .. ' '
    end,
    condition = buffer_not_empty,
  }
}

i = i + 1
gls.left[i] = {
  FileName = {
    provider = function()
      if not buffer_not_empty() then
        return ''
      end
      local fname
      if wide_enough() then
        fname = vim.fn.fnamemodify(vim.fn.expand '%', ':~:.')
      else
        fname = vim.fn.expand '%:t'
      end
      if #fname == 0 then
        return ''
      end
      if vim.bo.readonly then
        fname = fname .. ' ' .. icons.locker
      end
      if vim.bo.modified then
        fname = fname .. ' ' .. icons.unsaved
      end
      return ' ' .. fname .. ' '
    end,
    highlight = {colors.fg, colors.bg},
  }
}

k = 1
gls.right[k] = {
  LspStatus = {
    provider = function()
      local connected = not vim.tbl_isempty(vim.lsp.buf_get_clients(0))
      if connected then
        return ' ' .. u 'f817' .. ' '
      else
        return ''
      end
    end,
    highlight = {colors.lsp_active, colors.bg},
  }
}

k = k + 1
gls.right[k] = {
  DiagnosticWarn = {
    provider = function()
      local n = vim.lsp.diagnostic.get_count(0, 'Warning')
      if n == 0 then
        return ''
      end
      return string.format(' %s %d ', icons.lsp_warn, n)
    end,
    highlight = {'yellow', colors.bg},
  }
}

k = k + 1
gls.right[k] = {
  DiagnosticError = {
    provider = function()
      local n = vim.lsp.diagnostic.get_count(0, 'Error')
      if n == 0 then
        return ''
      end
      return string.format(' %s %d ', icons.lsp_error, n)
    end,
    highlight = {'red', colors.bg},
  }
}

k = k + 1
gls.right[k] = {
  FileType = {
    provider = function()
      if not buffer_not_empty() then
        return ''
      end
      local icon = icons[vim.bo.fileformat] or ''
      return string.format(' %s %s ', icon, vim.bo.filetype)
    end,
    condition = buffer_not_empty,
    highlight = {colors.fg, colors.bg},
  }
}

k = k + 1
gls.right[k] = {
  FileEncode = {
    provider = 'FileEncode',
    condition = buffer_not_empty,
    highlight = {colors.grey,colors.bg},
  }
}

k = k + 1
gls.right[k] = {
  FileFormat = {
    provider = 'FileFormat',
    condition = buffer_not_empty,
    highlight = {colors.grey,colors.bg},
  }
}

k = k + 1
gls.right[k] = {
  LineInfo = {
    provider = 'LineColumn',
    condition = buffer_not_empty,
    highlight = {colors.grey,colors.bg},
  },
}

k = k + 1
gls.right[k] = {
  PerCent = {
    provider = 'LinePercent',
    condition = buffer_not_empty,
    highlight = {colors.grey,colors.bg},
  }
}

gl.short_line_list = {'NvimTree', 'vista', 'dbui'}

j = 1
gls.short_line_left[j] = {
  ShortLineSeparator = {
    provider = function() return ' ' end,
    highlight = {colors.section_bg, colors.section_bg},
  }
}

j = j + 1
gls.short_line_left[j] = {
  ShortLineFileName = {
    provider = 'FileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.fg, colors.section_bg},
  },
}

j = j + 1
gls.short_line_left[j] = {
  BufferIcon = {
    provider = 'BufferIcon',
    highlight = {colors.fg, colors.bg}
  }
}
