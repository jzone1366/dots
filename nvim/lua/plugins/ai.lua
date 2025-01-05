return {
  {
    'zbirenbaum/copilot.lua',
    cond = vim.g.ai == 'copilot',
    lazy = false,
    config = function()
      require('copilot').setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    cond = function()
      return vim.g.ai == 'copilot'
    end,
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

  -- Something new to try
  { -- lua alternative to the official codeium.vim plugin https://github.com/Exafunction/codeium.vim
    'monkoose/neocodeium',
    cond = function()
      return vim.g.ai == 'neocodeium'
    end,
    event = 'InsertEnter',
    cmd = 'NeoCodeium',
    opts = {
      filetypes = {
        oil = false,
        gitcommit = false,
        NeogitCommit = false,
        NeogitCommitMessage = false,
        markdown = false,
        DressingInput = false,
        TelescopePrompt = false,
        noice = false, -- sometimes triggered in error-buffers
        text = false, -- `pass` passwords editing filetype is plaintext
        ['rip-substitute'] = true,
      },
      silent = true,
      show_label = false, -- signcolumn label for number of suggestions
    },
    init = function()
      -- disable while recording
      vim.api.nvim_create_autocmd('RecordingEnter', { command = 'NeoCodeium disable' })
      vim.api.nvim_create_autocmd('RecordingLeave', { command = 'NeoCodeium enable' })
    end,
    keys = {
      {
        '<C-y>',
        function()
          require('neocodeium').accept()
        end,
        mode = 'i',
        desc = '󰚩 Accept full suggestion',
      },
      {
        '<C-t>',
        function()
          require('neocodeium').accept_line()
        end,
        mode = 'i',
        desc = '󰚩 Accept line',
      },
      {
        '<C-c>',
        function()
          require('neocodeium').clear()
        end,
        mode = 'i',
        desc = '󰚩 Clear suggestion',
      },
      {
        '<A-n>',
        function()
          require('neocodeium').cycle(1)
        end,
        mode = 'i',
        desc = '󰚩 Next suggestion',
      },
      {
        '<A-p>',
        function()
          require('neocodeium').cycle(-1)
        end,
        mode = 'i',
        desc = '󰚩 Prev suggestion',
      },
      {
        '<leader>oa',
        function()
          vim.cmd.NeoCodeium('toggle')
        end,
        desc = '󰚩 NeoCodeium Suggestions',
      },
    },
  },
}
