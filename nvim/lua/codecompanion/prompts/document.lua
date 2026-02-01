return {
  display_name = 'Add Documentation',
  config = {
    strategy = 'inline',
    description = 'Add comments and documentation to code',
    opts = {
      index = 6,
      short_name = 'doc',
    },
    prompts = {
      {
        role = 'system',
        content = 'You are an expert at writing clear, concise documentation. Add appropriate comments and docstrings.',
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
          return 'Add documentation and comments to this code:\n\n```' .. filetype .. '\n' .. code .. '\n```'
        end,
      },
    },
  },
}
