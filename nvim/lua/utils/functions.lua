local async_present, async = pcall(require, 'plenary.async')
if not async_present then
  return
end

local present, win = pcall(require, 'lspconfig.ui.windows')
if not present then
  return
end

local _default_opts = win._default_opts
win._default_opts = function(options)
  local opts = _default_opts(options)
  opts.border = 'rounded'
  return opts
end
