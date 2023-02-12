local map = require('zone.utils').map

return {
  'folke/noice.nvim',
  config = function()
    local config = {
      presets = {
        bottom_search = true,
        command_palette = true,
        lsp_doc_border = true,
      },
      views = {
        notify = {
          merge = true,
        },
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        hover = {
          enabled = true,
        },
        signature = {
          enabled = true,
        },
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = false,
        },
      },
    }

    require('noice').setup(config)

    map('n', '<c-j>', function()
      if not require('noice.lsp').scroll(4) then
        return '<c-j>'
      end
    end)

    map('n', '<c-k>', function()
      if not require('noice.lsp').scroll(-4) then
        return '<c-k>'
      end
    end)
  end,
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
}
