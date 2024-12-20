return {
  'OXY2DEV/markview.nvim',
  lazy = false, -- Recommended
  -- ft = "markdown" -- If you decide to lazy-load anyway
  config = function()
    local markview = require('markview')
    local presets = require('markview.presets')

    markview.setup({
      headings = presets.headings.glow_labels,
    })

    vim.cmd('Markview enableAll')
  end,
  dependencies = {
    -- You will not need this if you installed the
    -- parsers manually
    -- Or if the parsers are in your $RUNTIMEPATH
    'nvim-treesitter/nvim-treesitter',
    'echasnovski/mini.icons',
  },
}
