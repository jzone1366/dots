local M = {}

M.code_actions = {}
function M.code_action_listener()
  local bufnr = vim.api.nvim_get_current_buf()
  local context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }
  local params = vim.lsp.util.make_range_params()
  params.context = context
  pcall(vim.lsp.buf_request, bufnr, 'textDocument/codeAction', params, function(err, actions, result)
    if err or not result or not result.bufnr then
      return
    end
    M.code_actions[result.bufnr] = M.code_actions[result.bufnr] or {}
    M.code_actions[result.bufnr][result.client_id] = actions and #actions or 0
    local count = 0
    for _, sub_count in ipairs(M.code_actions[result.bufnr]) do
      count = count + sub_count
    end
    M.code_actions[result.bufnr].count = count
  end)
end

return M
