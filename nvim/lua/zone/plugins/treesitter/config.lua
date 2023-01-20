local servers = require('zone.plugins.treesitter.servers')

local defaults = {
  ensure_installed = servers.installed,
  ignore_install = servers.ignored,
  sync_install = false,
  auto_install = false,
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = {
    enable = true, -- can cause weird indent behavior.
  },
  autotag = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = false },
  },
}

require('nvim-treesitter.configs').setup(defaults)
