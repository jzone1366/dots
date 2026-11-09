-- ┌─────────────────────────┐
-- │ Language-specific tools │
-- └─────────────────────────┘

local add, later = vim.pack.add, Config.later

-- Database ====================================================================

-- 'dadbod-grip.nvim' turns database tables into editable Vim buffers, with
-- schema browsing, staged mutations, generated SQL, and FK navigation.
-- Requires the CLI client for whichever database you connect to, e.g.
-- `psql`, `mysql`, `sqlite3`, `duckdb`, or `sqlcmd`.
later(function()
  add({ 'https://github.com/joryeugene/dadbod-grip.nvim' })

  -- Let blink.cmp show grip's completions (see the dadbod_grip source in 43_completion.lua)
  -- instead of grip disabling blink and using its own popup in the query pad.
  require('dadbod-grip').setup({ completion = false })
end)

-- LaTeX ========================================================================

-- VimTeX provides build system integration, PDF viewer SyncTeX, section/env
-- text objects, improved syntax, folding, and more for LaTeX editing.
-- texlab (LSP) handles completion, hover, go-to-definition, and formatting.
-- They complement each other: VimTeX builds/views, texlab does language smarts.
later(function()
  -- Set VimTeX globals before loading the plugin
  vim.g.vimtex_view_method = 'skim'         -- macOS: Skim supports SyncTeX (forward/inverse search)
  vim.g.vimtex_compiler_method = 'latexmk'
  vim.g.vimtex_mappings_prefix = '<LocalLeader>' -- default is \ ; keep as-is or customize
  -- Disable VimTeX's own completion (use texlab via blink.cmp instead)
  vim.g.vimtex_complete_enabled = 0

  add({ 'https://github.com/lervag/vimtex' })
end)
