local utils = {}

function utils.create_filetype(definitions)
  for group_name, definition in pairs(definitions) do
    vim.cmd("augroup filetype_" .. group_name)
    vim.cmd("autocmd!")
    for _, def in ipairs(definition) do
      vim.cmd("autocmd FileType " .. group_name .. " setlocal " .. def)
    end
    vim.cmd("augroup END")
  end
end

return utils
