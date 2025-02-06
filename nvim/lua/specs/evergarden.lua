return {
  'comfysage/evergarden',
  dir = '~/workspace/personal/nvim/evergarden', --Remove this to use prod version
  enabled = false,
  priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
  config = function()
    require('evergarden').setup({
      variant = 'hard', -- 'hard'|'medium'|'soft'
      overrides = {}, -- add custom overrides
    })
    vim.cmd('colorscheme evergarden')
  end,
}
