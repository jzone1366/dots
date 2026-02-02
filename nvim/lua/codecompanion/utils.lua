local M = {}

-- Helper function to get code from selection or buffer
function M.get_code(context)
  local code = context.selection

  if not code or code == '' then
    local bufnr = context.bufnr or vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    code = table.concat(lines, '\n')
  end

  return code
end

-- Helper function to get filetype
function M.get_filetype(context)
  return context.filetype or vim.bo.filetype or 'text'
end

-- Helper function to create a standard prompt
function M.create_code_prompt(prefix, suffix)
  suffix = suffix or ''
  return function(context)
    local code = M.get_code(context)
    local filetype = M.get_filetype(context)
    return prefix .. ':\n\n```' .. filetype .. '\n' .. code .. '\n```' .. suffix
  end
end

return M
