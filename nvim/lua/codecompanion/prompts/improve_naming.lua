return {
  display_name = 'Improve Naming',
  config = {
    strategy = 'inline',
    description = 'Suggest better names for variables, functions, and classes',
    opts = {
      index = 14,
      short_name = 'naming',
    },
    prompts = {
      {
        role = 'system',
        content = 'You are an expert at naming conventions. Suggest clear, descriptive names following language best practices.',
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
          return 'Suggest better names for variables/functions in this code:\n\n```'
            .. filetype
            .. '\n'
            .. code
            .. '\n```'
        end,
      },
    },
  },
}
