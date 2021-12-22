local config = require('zone.config')
local utils = require('zone.utils')

require('Comment').setup(utils.merge({
  pre_hook = function(ctx)
    local U = require('Comment.utils')
    local location = nil
    if ctx.ctype == U.ctype.block then
      location = require('ts_context_commentstring.utils').get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = require('ts_context_commentstring.utils').get_visual_start_location()
    end

    return require('ts_context_commentstring.internal').calculate_commentstring({
      key = type,
      location = location,
    })
  end
}, config.comments or {}))
