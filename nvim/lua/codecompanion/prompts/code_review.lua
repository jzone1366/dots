return {
  display_name = 'Code Review',
  config = {
    strategy = 'chat',
    description = 'Review code for best practices, bugs, and improvements',
    opts = {
      index = 1,
      short_name = 'review',
    },
    prompts = {
      {
        role = 'system',
        content = 'You are an expert code reviewer. Provide constructive feedback on code quality, potential bugs, performance issues, and best practices.',
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
          return 'Please review this code:\n\n```' .. filetype .. '\n' .. code .. '\n```'
        end,
      },
    },
  },
}
