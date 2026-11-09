-- ┌────┐
-- │ AI │
-- └────┘

-- Copilot (completion source + chat) and agentic.nvim (ACP agents).
local add, now_if_args = vim.pack.add, Config.now_if_args

now_if_args(function()
  add({ 'https://github.com/zbirenbaum/copilot.lua' })
  add({
    'https://github.com/CopilotC-Nvim/CopilotChat.nvim',
  })
  add({ 'https://github.com/giuxtaposition/blink-cmp-copilot' })
  require('copilot').setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
  })

  require('CopilotChat').setup({})

  add({ 'https://github.com/carlos-algms/agentic.nvim' })

  require('agentic').setup({
    -- Any ACP-compatible provider works. Built-in: "claude-agent-acp" | "gemini-acp" | "codex-acp" | "opencode-acp"
    -- "cursor-acp" |"copilot-acp" | "auggie-acp" | "mistral-vibe-acp" | "cline-acp" | "goose-acp"
    -- provider = 'opencode-acp',
    provider = 'claude-agent-acp',
  })
end)
