return { -- Hint and fix deviating indentation
  {
    'tenxsoydev/tabs-vs-spaces.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {},
  },
  {
    'nmac427/guess-indent.nvim',
    lazy = false,
    priority = 50,
    opts = {},
  },
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },
}
