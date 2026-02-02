return {
  display_name = 'Generate Tests',
  config = {
    strategy = 'chat',
    description = 'Generate unit tests for the selected code',
    opts = {
      index = 3,
      short_name = 'tests',
    },
    prompts = {
      {
        role = 'system',
        content = 'You are an expert at writing comprehensive unit tests. Generate tests that cover edge cases, happy paths, and error conditions.',
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
          return 'Generate unit tests for this code:\n\n```' .. filetype .. '\n' .. code .. '\n```'
        end,
      },
    },
  },
}
