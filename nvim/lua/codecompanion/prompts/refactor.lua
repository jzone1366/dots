return {
  display_name = 'Refactor Code',
  config = {
    strategy = 'inline',
    description = 'Refactor code to improve readability and maintainability',
    opts = {
      index = 4,
      short_name = 'refactor',
    },
    prompts = {
      {
        role = 'system',
        content = 'You are an expert at refactoring code. Improve code quality while maintaining functionality.',
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
          return 'Refactor this code to improve readability and maintainability:\n\n```'
            .. filetype
            .. '\n'
            .. code
            .. '\n```'
        end,
      },
    },
  },
}
