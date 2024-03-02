if vim.fn.has('nvim-0.9') == 0 then
  error('Need NVIM 0.9 in order to run.')
end

local ok, err = pcall(require, 'core')

if not ok then
  error(('Error loading core...\n\n%s'):format(err))
end
