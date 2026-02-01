return {
  display_name = 'Add Error Handling',
  config = {
    strategy = 'inline',
    description = 'Add comprehensive error handling to code',
    opts = {
      index = 9,
      short_name = 'errors',
    },
    prompts = {
      {
        role = 'system',
        content = 'You are an expert at defensive programming. Add appropriate error handling, validation, and edge case handling.',
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
          return 'Add error handling to this code:\n\n```' .. filetype .. '\n' .. code .. '\n```'
        end,
      },
    },
  },
}
