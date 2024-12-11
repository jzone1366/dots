return {
  'goolord/alpha-nvim',
  lazy = false,
  config = function()
    local icons = require('theme.icons')
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
      dashboard.button('<leader>sf', icons.fileNoBg .. ' Search File', '<cmd>Pick files<CR>'),
      dashboard.button('<C-e>', icons.file .. ' Find Manager', '<Cmd>NvimTreeToggle<CR>'),
      dashboard.button('<leader>sgg', icons.word .. ' Grep String', '<cmd>Pick grep_live<CR>'),
    }

    dashboard.section.footer.val = 'Keep Calm and Code On.'

    alpha.setup(dashboard.opts)
  end,
}
