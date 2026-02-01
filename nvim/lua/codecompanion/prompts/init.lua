local M = {}

-- Get the path to the prompts directory
local prompts_path = vim.fn.stdpath('config') .. '/lua/codecompanion/prompts'

-- Scan the directory for all .lua files (excluding init.lua)
local prompt_files = vim.fn.glob(prompts_path .. '/*.lua', false, true)

for _, file_path in ipairs(prompt_files) do
  local filename = vim.fn.fnamemodify(file_path, ':t:r') -- Get filename without extension

  -- Skip init.lua itself
  if filename ~= 'init' then
    M[filename] = require('codecompanion.prompts.' .. filename)
  end
end

return M
