return {
  {
    'zbirenbaum/copilot.lua',
    lazy = false,
    config = function()
      require('copilot').setup({
        suggestion = { enabled = true },
        panel = { enabled = true },
      })
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    event = 'BufReadPre',
    branch = 'main',
    opts = {
      show_help = 'no',
      prompts = {
        Explain = 'Explain how it works.',
        Review = 'Review the following code and provide concise suggestions.',
        Tests = 'Briefly explain how the selected code works, then generate unit tests.',
        Refactor = 'Refactor the code to improve clarity and readability.',
      },
    },
    build = 'make tiktoken',
    keys = {
      { '<leader>ccb', ':CopilotChatBuffer<cr>', desc = 'CopilotChat - Buffer' },
      { '<leader>cce', '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat - Explain code' },
      { '<leader>cct', '<cmd>CopilotChatTests<cr>', desc = 'CopilotChat - Generate tests' },
      {
        '<leader>ccT',
        '<cmd>CopilotChatVsplitToggle<cr>',
        desc = 'CopilotChat - Toggle Vsplit', -- Toggle vertical split
      },
      {
        '<leader>ccv',
        ':CopilotChatVisual',
        mode = 'x',
        desc = 'CopilotChat - Open in vertical split',
      },
      {
        '<leader>ccc',
        ':CopilotChatInPlace<cr>',
        mode = { 'n', 'x' },
        desc = 'CopilotChat - Run in-place code',
      },
      {
        '<leader>ccf',
        '<cmd>CopilotChatFixDiagnostic<cr>', -- Get a fix for the diagnostic message under the cursor.
        desc = 'CopilotChat - Fix diagnostic',
      },
    },
  },
}
