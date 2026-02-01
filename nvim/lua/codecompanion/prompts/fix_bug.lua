return {
  display_name = 'Fix Bug',
  config = {
    strategy = 'chat',
    description = 'Analyze and fix bugs in the code',
    opts = {
      index = 7,
      short_name = 'fix',
    },
    prompts = {
      {
        role = 'system',
        content = 'You are an expert debugger. Analyze the code, identify the bug, and provide a fix with explanation.',
      },
      {
        role = 'user',
        content = function(context)
          local code = context.selection

          if not code or code == '' then
            local bufnr = context.bufnr or vim.api.nvim_get_current_buf()
            local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
            code = table.concat(lines, '\n')
          end

          local filetype = context.filetype or vim.bo.filetype or 'text'
          return "There's a bug in this code. Please identify and fix it:\n\n```" .. filetype .. '\n' .. code .. '\n```'
        end,
      },
    },
  },
}
