local command = function(lhs, rhs, opts)
  opts = vim.tbl_extend('force', opts, {})
  vim.api.nvim_create_user_command(lhs, rhs, opts)
end

command('Todo', [[noautocmd silent grep! 'TODO\|FIXME\|BUG\|HACK' | copen]], {})
