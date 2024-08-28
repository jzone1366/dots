return {
  "sindrets/diffview.nvim",
  config = function()
    local map = require("utils").map
    -- will open diff view with all commits from current branch
    -- not in master. Three dots notation will ignore new commits
    -- in master so it can be rebased with no problem.
    map("n", "<leader>do", ":DiffviewOpen master...HEAD<CR>", { desc = 'Diff Master and HEAD' })
    map("n", "<leader>dc", ":DiffviewClose<CR>", { desc = 'Close Diffview' })

    local actions = require("diffview.config").actions
    require("diffview").setup({
      enhanced_diff_hl = true,
      view = {
        default = {
          layout = "diff2_vertical",
        },
        merge_tool = {
          layout = "diff3_mixed",
        },
        file_history = {
          layout = "diff2_vertical",
        },
      },
      keymaps = {
        view = {
          { "n", "<leader>q", actions.toggle_files, { desc = "DiffView Toggle files" } },
          --jump to next diff
          { "n", "gn",        "]c",                 { desc = "Jump to next diff" } },
          --jump to prev diff
          { "n", "gp",        "[c",                 { desc = "Jump to prev diff" } },
        },
        file_panel = {
          { "n", "<leader>q", actions.toggle_files, { desc = "DiffView Toggle files" } },
        },
        file_history_panel = {
          { "n", "<leader>q", actions.toggle_files, { desc = "DiffView Toggle files" } },
        },
      },
    })
  end,
}
