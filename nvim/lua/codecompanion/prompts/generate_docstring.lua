return {
  display_name = 'Generate Docstring',
  config = {
    strategy = 'inline',
    description = 'Generate language-appropriate docstring for function/class',
    opts = {
      index = 11,
      short_name = 'docstring',
    },
    prompts = {
      {
        role = 'system',
        content = function(context)
          local filetype = context.filetype or vim.bo.filetype or 'text'
          local docstring_styles = {
            python = 'Google-style Python docstrings',
            javascript = 'JSDoc comments',
            typescript = 'TSDoc comments',
            lua = 'LuaDoc comments',
            go = 'GoDoc comments',
            rust = 'Rust doc comments (///)',
            java = 'JavaDoc comments',
          }
          local style = docstring_styles[filetype] or 'appropriate documentation comments'
          return 'You are an expert at writing ' .. style .. '. Generate comprehensive documentation.'
        end,
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
          return 'Generate a docstring for this code:\n\n```' .. filetype .. '\n' .. code .. '\n```'
        end,
      },
    },
  },
}
