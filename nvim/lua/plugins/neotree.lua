local opts = {
  -- use_default_mappings = false,
  window = {
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    --mappings = {
    --	["l"] = "open",
    --	["h"] = "close_node",
    --	["!"] = "toggle_hidden",
    --	["d"] = "add_directory",
    --	["X"] = "delete",
    --	["/"] = "noop", -- Disable fuzzy finder thx
    --	["space"] = "none",
    --	["<Esc>"] = "close_window",
    --},
  },
  git_status = {
    symbols = {
      -- Change type
      added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
      modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
      deleted   = "✖", -- this can only be used in the git_status source
      renamed   = "󰁕", -- this can only be used in the git_status source
      -- Status type
      untracked = "",
      ignored   = "",
      unstaged  = "󰄱",
      staged    = "",
      conflict  = "",
    }
  },
  filesystem = {
    filtered_items = {
      visible = true,
      -- hide_dotfiles = false,
    }
  },
}

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    "s1n7ax/nvim-window-picker",
  },
  cmd = "Neotree",
  opts = opts,
  init = function()
    require('core.keymaps').neotree()
  end
}
