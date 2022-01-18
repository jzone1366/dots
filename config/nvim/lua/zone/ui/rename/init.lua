local lsp = vim.lsp
local utils = require('zone.ui.utils')
local rename_handler = require('zone.ui.rename.handler')
local Text = require('nui.text')

local function rename(opts)
  local Input = require('nui.input')
  local event = require('nui.utils.autocmd').event
  local curr_name = vim.fn.expand('<cword>')

  local user_border = opts.rename.border
  local width = 25

  if #curr_name > width then
    width = #curr_name
  end

  local popup_opts = {
    position = {
      row = 1,
      col = 0,
    },
    size = {
      width = width,
      height = 2,
    },
    relative = 'cursor',
    border = {
      highlight = user_border.highlight,
      style = user_border.style or opts.border_style,
      text = {
        top = Text(user_border.title, user_border.title_hl),
        top_align = user_border.title_align,
      },
    },
  }

  opts = utils.merge({
    prompt = Text(opts.rename.prompt, opts.rename.prompt_hl),
    default_value = curr_name,
    on_submit = function(new_name)
      if not (new_name and #new_name > 0) or new_name == curr_name then
        return
      end
      local params = lsp.util.make_position_params()
      params.newName = new_name
      lsp.buf_request(0, 'textDocument/rename', params, rename_handler)
    end,
  }, opts or {})

  local input = Input(popup_opts, opts)

  -- mount/open the component
  input:mount()

  utils.default_mappings(input)

  -- unmount component when cursor leaves buffer
  input:on(event.BufLeave, function()
    input:unmount()
  end)
end

return rename

