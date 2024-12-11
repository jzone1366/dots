local icons = require('theme.icons')

return {
  'vuki656/package-info.nvim',
  event = 'BufEnter package.json',
  config = function()
    require('package-info').setup({
      colors = {
        up_to_date = '#3C4048', -- Text color for up to date package virtual text
        outdated = '#fc514e', -- Text color for outdated package virtual text
      },
      icons = {
        enable = true, -- Whether to display icons
        style = {
          up_to_date = icons.checkSquare, -- Icon for up to date packages
          outdated = icons.gitRemove, -- Icon for outdated packages
        },
      },
      autostart = true, -- Whether to autostart when `package.json` is opened
      hide_up_to_date = true, -- It hides up to date versions when displaying virtual text
      hide_unstable_versions = true, -- It hides unstable versions from version list e.g next-11.1.3-canary3

      -- Can be `npm` or `yarn`. Used for `delete`, `install` etc...
      -- The plugin will try to auto-detect the package manager based on
      -- `yarn.lock` or `package-lock.json`. If none are found it will use the
      -- provided one,                              if nothing is provided it will use `yarn`
      package_manager = 'yarn',
    })
  end,
  keys = {
    { '<LEADER>ns', '<cmd>lua require("package-info").show()<CR>', desc = 'Show dependency versions' },
    { '<LEADER>nc', '<cmd>require("package-info").hide()<CR>', desc = 'Hide dependency versions' },
    { '<LEADER>nt', '<cmd>require("package-info").toggle()<CR>', desc = 'Toggle dependency versions' },
    { '<LEADER>nu', '<cmd>require("package-info").update()<CR>', desc = 'Update dependency' },
    { '<LEADER>nd', '<cmd>require("package-info").delete()<CR>', desc = 'Delete dependency' },
    { '<LEADER>ni', '<cmd>require("package-info").install()<CR>', desc = 'Install dependency' },
    { '<LEADER>np', '<cmd>require("package-info").change_version()<CR>', desc = 'Change dependency version' },
  },
}
