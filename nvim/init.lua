if vim.fn.has('nvim-0.8') == 0 then
  error('Need NVIM 0.8 in order to run.')
end

local ok, err = pcall(require, 'zone')

if not ok then
  error(('Error loading core...\n\n%s'):format(err))
end
