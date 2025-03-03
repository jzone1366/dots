return {
  'ramilito/kubectl.nvim',
  config = function()
    require('kubectl').setup()
  end,
  cmd = { 'Kubectl', 'Kubectx', 'Kubens' },
  keys = {
    { '<leader>k', '<cmd>lua require("kubectl").toggle()<cr>', desc = 'Toggle K8s' },
    { '<C-k>', '<Plug>(kubectl.kill)', ft = 'k8s_*', desc = 'K8s kill' },
    { '7', '<Plug>(kubectl.view_nodes)', ft = 'k8s_*', desc = 'Kubectl view nodes' },
    { '8', '<Plug>(kubectl.view_overview)', ft = 'k8s_*', desc = 'Kubectl view overview' },
    { '<C-t>', '<Plug>(kubectl.view_top)', ft = 'k8s_*', desc = 'Kubectl vew top' },
  },
}
