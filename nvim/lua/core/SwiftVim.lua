------------------------------------------------
--                                            --
--       This is a main configuration file    --
--      Change variables which you need to    --
--                                            --
------------------------------------------------

local icons = require('theme.icons')

SwiftVim = {
  --colorscheme = 'tokyonight',
  ui = {
    float = {
      border = 'rounded',
    },
  },
  plugins = {
    -- Make sure to reload nvim & "Update Plugins" after change
    ai = {
      chatgpt = {
        enabled = false,
      },
      codeium = {
        enabled = false,
      },
      copilot = {
        enabled = true,
      },
    },
    completion = {
      select_first_on_enter = false,
    },
    -- Completely replaces the UI for messages, cmdline and the popupmenu
    experimental_noice = {
      enabled = false,
    },
    -- Enables moving by subwords and skips significant punctuation with w, e, b motions
    jump_by_subwords = {
      enabled = false,
    },
    rooter = {
      -- Removing package.json from list in Monorepo Frontend Project can be helpful
      -- By that your live_grep will work related to whole project, not specific package
      patterns = { '.git', 'package.json', '_darcs', '.bzr', '.svn', 'Makefile' }, -- Default
    },
    -- <leader>z
    zen = {
      alacritty_enabled = false,
      kitty_enabled = false,
      wezterm_enabled = true,
      enabled = true, -- sync after change
    },
  },
  icons = icons,
  lsp = {
    virtual_text = true, -- show virtual text (errors, warnings, info) inline messages
  },
}
