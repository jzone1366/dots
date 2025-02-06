local fn, lsp = vim.fn, vim.lsp
local M = {}

M.settings = {
  commands = {
    Format = {
      function()
        lsp.buf.range_formatting({}, { 0, 0 }, { fn.line('$'), 0 })
      end,
    },
  },
  init_options = { provideFormatter = false },
  single_file_support = true,
  on_new_config = function(new_config)
    new_config.settings.json.schemas = new_config.settings.json.schemas or {}
    vim.list_extend(new_config.settings.json.schemas, require('schemastore').json.schemas())
  end,
  settings = {
    json = {
      format = { enable = false },
      validate = { enable = true },
    },
  },
}

return M
