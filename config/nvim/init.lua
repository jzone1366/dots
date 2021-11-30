if not vim.fn.has('nvim-0.6') then
  error('Need NVIM 0.6 to run ZoneNvim!!')
end

do
  local ok, _ = pcall(require, 'impatient')

  if not ok then
    vim.notify('impatient.nvim not installed', vim.log.levels.WARN)
  end
end

local ok, err = pcall(require, 'zone')

if not ok then
  error(('Error loading core...\n\n%s'):format(err))
end
