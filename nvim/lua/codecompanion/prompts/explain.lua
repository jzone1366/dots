return {
  display_name = 'Explain Code',
  config = {
    strategy = 'chat',
    description = 'Explain what the selected code does',
    opts = {
      index = 2,
      short_name = 'explain',
    },
    prompts = {
      {
        role = 'system',
        content = 'You are a patient teacher. Explain code clearly and concisely, breaking down complex concepts.',
      },
      {
        role = 'user',
        content = function(context)
          local code = context.selection

          -- If no selection, get the entire buffer content
          if not code or code == '' then
            local bufnr = context.bufnr or vim.api.nvim_get_current_buf()
            local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
            code = table.concat(lines, '\n')
          end

          local filetype = context.filetype or vim.bo.filetype or 'text'
          return 'Please explain what this code does:\n\n```' .. filetype .. '\n' .. code .. '\n```'
        end,
      },
    },
  },
}
