return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {
    jump = { nohlsearch = true, autojump = false },
    prompt = {
      -- Place the prompt above the statusline.
      win_config = { row = -3 },
    },
    search = {
      multi_window = false,
      mode = 'exact',
      exclude = {
        'cmp_menu',
        'flash_prompt',
        'qf',
        function(win)
          -- Floating windows from bqf.
          if vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win)):match('BqfPreview') then
            return true
          end

          -- Non-focusable windows.
          return not vim.api.nvim_win_get_config(win).focusable
        end,
      },
    },
    modes = {
      search = {
        enabled = false,
      },
      char = {
        keys = { 'f', 'F', 't', 'T' }, -- NOTE: using "," here breaks which-key
      },
    },
  },
  keys = {
    {
      's',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
    },
    {
      'm',
      mode = { 'o', 'x' },
      function()
        require('flash').treesitter()
      end,
    },
    -- { "vn", mode = { "n", "o", "x" }, function() require("flash").treesitter() end },
    {
      'r',
      function()
        require('flash').remote()
      end,
      mode = 'o',
      desc = 'Remote Flash',
    },
    {
      '<c-s>',
      function()
        require('flash').toggle()
      end,
      mode = { 'c' },
      desc = 'Toggle Flash Search',
    },
    {
      'S',
      function()
        require('flash').treesitter_search()
      end,
      mode = { 'o', 'x' },
      desc = 'Flash Treesitter Search',
    },
  },
}
