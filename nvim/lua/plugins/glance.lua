return {
  'dnlhc/glance.nvim',
  config = function()
    local filter = require('core.utils.filter').filter
    local filterReactDTS = require('core.utils.filter').filterReactDTS

    require('glance').setup({
      hooks = {
        before_open = function(results, open, jump, method)
          if #results == 1 then
            jump(results[1]) -- argument is optional
          elseif method == 'definitions' then
            results = filter(results, filterReactDTS)
            if #results == 1 then
              jump(results[1])
            else
              open(results)
            end
          else
            open(results)
          end
        end,
      },
    })
  end,
  cmd = { 'Glance' },
  keys = {
    { 'gd', '<cmd>Glance definitions<CR>',      desc = 'LSP Definition' },
    { 'gr', '<cmd>Glance references<CR>',       desc = 'LSP References' },
    { 'gm', '<cmd>Glance implementations<CR>',  desc = 'LSP Implementations' },
    { 'gy', '<cmd>Glance type_definitions<CR>', desc = 'LSP Type Definitions' },
  },
}
