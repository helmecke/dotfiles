local gl = require 'galaxyline'
local gls = gl.section
local condition = require 'galaxyline.condition'
local fileinfo = require 'galaxyline.provider_fileinfo'
local devicons = require 'nvim-web-devicons'

local colors = require 'onedark.colors'

local sep = {
  left = '',
  right = '',
}

local function highlight(group, fg, bg, gui)
  local cmd = string.format('highlight %s guifg=%s guibg=%s', group, fg, bg)
  if gui ~= nil then
    cmd = cmd .. ' gui=' .. gui
  end
  vim.cmd(cmd)
end

-- get file encode
local function get_file_info()
  local encode = vim.bo.fenc ~= '' and vim.bo.fenc or vim.o.enc
  local eol = '[!EOL]'
  if vim.bo.eol then
    eol = ''
  end
  return eol .. encode .. '[' .. vim.bo.fileformat .. ']'
end

local function get_buffer_filetype()
  return vim.bo.filetype
end

local function get_file_icon()
  local fname, ext = vim.fn.expand '%:t', vim.fn.expand '%:e'
  local icon, iconhl = devicons.get_icon(fname, ext)
  if icon == nil then
    for _,v in ipairs(gl.short_line_list) do
      if v == fname then
        return ''
      end
    end
    icon = ''
    iconhl = '#6d8086'
  end
  local fg = vim.fn.synIDattr(vim.fn.hlID(iconhl), 'fg')
  highlight('GalaxyFileIcon', fg, colors.vertsplit.gui)
  return ' ' .. icon .. ' '
end


-- get current file name
local function get_current_file_name(modified_icon, readonly_icon)
  local file
  if condition.hide_in_width() then
    file = vim.fn.fnamemodify(vim.fn.expand '%', ':~:.')
    if file:len() > 50 and file ~= nil then
      file = file:sub(-48, -1)
      bla = file:find('/')
      if bla ~= nil then
        file = '..' .. file:sub(bla, -1)
      end
    end
  else
    file = vim.fn.expand '%:t'
  end
  return file .. ' '
end

local function get_current_file_modified(modified_icon)
  local file = vim.fn.expand '%:t'
  local icon = modified_icon or '●'
  if vim.fn.empty(file) == 1 then return '' end
  if vim.bo.modifiable then
    if vim.bo.modified then
      return ' ' .. icon .. ' '
    end
  end
  return ''
end

local function get_current_file_readonly(readonly_icon)
  local file = vim.fn.expand '%:t'
  local icon = readonly_icon or ''
  if vim.fn.empty(file) == 1 then return '' end
  if vim.bo.filetype == 'help' then
    return ''
  end
  if vim.bo.readonly == true then
    return ' ' .. icon .. ' '
  end
  return ''
end

table.insert(gls.left, {
  Start = {
    provider = function() return '▎' end,
    highlight = {colors.white.gui, colors.vertsplit.gui},
    separator_highlight = {colors.white.gui, colors.vertsplit.gui},
  }
})

table.insert(gls.left, {
  ViMode = {
    provider = function()
      -- auto change color according the vim mode
      local mode_color = {
        n = colors.red.gui,
        i = colors.yellow.gui,
        v = colors.purple.gui,
        [''] = colors.purple.gui,
        V = colors.purple.gui,
        c = colors.white.gui,
        no = colors.white.gui,
        s = colors.dark_yellow.gui,
        S = colors.dark_yellow.gui,
        [''] = colors.dark_yellow.gui,
        ic = colors.yellow.gui,
        R = colors.red.gui,
        Rv = colors.red.gui,
        cv = colors.white.gui,
        ce = colors.white.gui,
        r = colors.cyan.gui,
        rm = colors.cyan.gui,
        ['r?'] = colors.cyan.gui,
        ['!']  = colors.white.gui,
        t = colors.blue.gui,
      }
      vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim.fn.mode()] ..' guibg='..colors.vertsplit.gui)
      return '  '
    end,
  }
})

table.insert(gls.left, {
FileSize = {
    provider = 'FileSize',
    condition = condition.buffer_not_empty,
    highlight = {colors.white.gui, colors.vertsplit.gui},
  }
})

table.insert(gls.left, {
  FileIcon = {
    provider = get_file_icon,
    condition = condition.buffer_not_empty,
    highlight = {colors.white.gui, colors.vertsplit.gui},
    separator_highlight = {colors.white.gui, colors.vertsplit.gui},
  }
})

table.insert(gls.left, {
  FileName = {
    provider = get_current_file_name,
    highlight = {colors.white.gui, colors.vertsplit.gui},
    separator_highlight = {colors.white.gui, colors.vertsplit.gui},
  }
})

table.insert(gls.left, {
  Modified = {
    provider = get_current_file_modified,
    highlight = {colors.green.gui, colors.vertsplit.gui},
  }
})

table.insert(gls.left, {
  ReadOnly = {
    provider = get_current_file_readonly,
    highlight = {colors.red.gui, colors.vertsplit.gui},
  }
})

table.insert(gls.left, {
  BufferIcon = {
    provider= 'BufferIcon',
    highlight = {colors.white.gui, colors.vertsplit.gui},
    separator_highlight = {colors.white.gui, colors.vertsplit.gui},
  }
})

-- table.insert(gls.right, {
--   BufferType = {
--     provider = get_buffer_filetype,
--     separator = ' ',
--     separator_highlight = {'NONE', colors.vertsplit.gui},
--     highlight = {colors.green.gui, colors.vertsplit.gui,'bold'}
--   }
-- })

table.insert(gls.right, {
  FileEncode = {
    provider = get_file_info,
    condition = condition.buffer_not_empty,
    separator = ' ',
    highlight = {colors.white.gui, colors.vertsplit.gui},
    separator_highlight = {colors.white.gui, colors.vertsplit.gui},
  }
})

table.insert(gls.right, {
  GitIcon = {
    provider = function() return '   ' end,
    condition = condition.check_git_workspace,
    highlight = {colors.red.gui, colors.vertsplit.gui},
  }
})

table.insert(gls.right, {
  GitBranch = {
    provider = 'GitBranch',
    condition = condition.check_git_workspace,
    highlight = {colors.white.gui, colors.vertsplit.gui},
  }
})

table.insert(gls.right, {
  Whitespace = {
    provider = function() return ' ' end,
    condition = condition.check_git_workspace,
    highlight = {colors.white.gui, colors.vertsplit.gui},
    separator_highlight = {colors.white.gui, colors.vertsplit.gui},
  }
})

gl.short_line_list = {'NvimTree', 'packer'}

table.insert(gls.short_line_left, {
  Start = {
    provider = function() return '▎' end,
    highlight = {colors.white.gui, colors.vertsplit.gui},
    separator_highlight = {colors.white.gui, colors.vertsplit.gui},
  }
})

table.insert(gls.short_line_left, {
  SFileIcon = {
    provider = get_file_icon,
    condition = condition.buffer_not_empty,
    highlight = {colors.white.gui, colors.vertsplit.gui},
    separator_highlight = {colors.white.gui, colors.vertsplit.gui},
  }
})

table.insert(gls.short_line_left, {
  SFileName = {
    provider = 'SFileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.white.gui, colors.vertsplit.gui},
    separator_highlight = {colors.white.gui, colors.vertsplit.gui},
  }
})

table.insert(gls.short_line_right, {
  SBufferIcon = {
    provider= 'BufferIcon',
    highlight = {colors.white.gui, colors.vertsplit.gui},
    separator_highlight = {colors.white.gui, colors.vertsplit.gui},
  }
})

-- table.insert(gls.short_line_right, {
--   SGitIcon = {
--     provider = function() return '   ' end,
--     condition = condition.check_git_workspace,
--     separator = ' ',
--     highlight = {colors.white.gui, colors.vertsplit.gui},
--     separator_highlight = {colors.white.gui, colors.vertsplit.gui},
--   }
-- })

-- table.insert(gls.short_line_right, {
--   SGitBranch = {
--     provider = 'GitBranch',
--     condition = condition.check_git_workspace,
--     highlight = {colors.white.gui, colors.vertsplit.gui},
--   }
-- })

table.insert(gls.short_line_right, {
  SWhitespace = {
    provider = function() return ' ' end,
    highlight = {'NONE', colors.vertsplit.gui},
  }
})
