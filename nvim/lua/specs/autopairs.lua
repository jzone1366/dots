return {
  {
    'altermo/ultimate-autopair.nvim',
    event = { 'InsertEnter', 'CmdlineEnter' },
    opts = {
      { '$', '$', ft = { 'typst' } },
    },
  },
}
