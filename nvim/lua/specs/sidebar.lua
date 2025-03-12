return {

  -- Generic and modular lua sidebar
  {
    'jzone1366/sidebar.nvim',
    enabled = false, -- Will turn back on when I fix the issues
    main = 'sidebar-nvim',
    cmd = { 'SidebarNvimToggle', 'SidebarNvimOpen' },
    opts = {
      open = true,
      bindings = {
        ['q'] = function()
          require('sidebar-nvim').close()
        end,
      },
    },
  },
}
