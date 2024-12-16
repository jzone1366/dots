return {
  'goolord/alpha-nvim',
  lazy = false,
  config = function()
    local icons = require('swift.settings').icons
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')
    local headers = require('plugins.alpha.headers')
    local fn = vim.fn
    -- Top Percent
    local marginTopPercent = 0.15
    local topPadding = fn.max({ 2, fn.floor(fn.winheight(0) * marginTopPercent) })

    -- Middle Percent
    local marginMiddlePercent = 0.1
    local middlePadding = fn.max({ 2, fn.floor(fn.winheight(0) * marginMiddlePercent) })

    dashboard.config.layout = {
      { type = 'padding', val = topPadding },
      dashboard.section.header,
      { type = 'padding', val = middlePadding },
      dashboard.section.buttons,
      dashboard.section.footer,
    }
    dashboard.section.header.val = headers.random()

    dashboard.section.buttons.val = {
      dashboard.button('<leader>ff', icons.kind.File .. ' Find File', '<cmd>Pick files<CR>'),
      --dashboard.button('<C-e>', icons.kind.Folder .. ' Find Manager', '<Cmd>NvimTreeToggle<CR>'),
      dashboard.button('<C-e>', icons.kind.Folder .. ' Find Manager', '<Cmd>Neotree toggle reveal position=left<CR>'),
      dashboard.button('<leader>fgg', icons.kind.String .. ' Find by Grep String', '<cmd>Pick grep_live<CR>'),
    }

    dashboard.section.footer.val = 'Keep Calm and Code On.'

    alpha.setup(dashboard.opts)
  end,
}
