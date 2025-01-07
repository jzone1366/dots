local fmt = string.format
local map = vim.keymap.set

local SETTINGS = require('swift.settings')
local U = require('swift.utils')

local M = {}

---@class Autocommand
---@field desc string
---@field event  string[] list of autocommand events
---@field pattern string[] list of autocommand patterns
---@field command string | function
---@field nested  boolean
---@field once    boolean
---@field buffer  number
---@field enabled boolean

---Create an autocommand
---returns the group ID so that it can be cleared or manipulated.
---@param name string
---@param ... Autocommand A list of autocommands to create (variadic parameter)
---@return number
function M.augroup(name, commands)
  --- Validate the keys passed to swift.augroup are valid
  ---@param name string
  ---@param cmd Autocommand
  local function validate_autocmd(name, cmd)
    local keys = { 'event', 'buffer', 'pattern', 'desc', 'callback', 'command', 'group', 'once', 'nested', 'enabled' }
    local incorrect = U.fold(function(accum, _, key)
      if not vim.tbl_contains(keys, key) then
        table.insert(accum, key)
      end
      return accum
    end, cmd, {})
    if #incorrect == 0 then
      return
    end
    vim.schedule(function()
      vim.notify('Incorrect keys: ' .. table.concat(incorrect, ', '), vim.log.levels.ERROR, {
        title = fmt('Autocmd: %s', name),
      })
    end)
  end

  assert(name ~= 'User', 'The name of an augroup CANNOT be User')

  local auname = fmt('swift-%s', name)
  local id = vim.api.nvim_create_augroup(auname, { clear = true })

  for _, autocmd in ipairs(commands) do
    if autocmd.enabled == nil or autocmd.enabled == true then
      validate_autocmd(name, autocmd)
      local is_callback = type(autocmd.command) == 'function'
      vim.api.nvim_create_autocmd(autocmd.event, {
        group = id,
        pattern = autocmd.pattern,
        desc = autocmd.desc,
        callback = is_callback and autocmd.command or nil,
        command = not is_callback and autocmd.command or nil,
        once = autocmd.once,
        nested = autocmd.nested,
        buffer = autocmd.buffer,
      })
    end
  end

  return id
end

function M.apply()
  M.augroup('HighlightYank', {
    {
      desc = 'Highlight when yanking (copying) text',
      event = { 'TextYankPost' },
      command = function()
        vim.highlight.on_yank({ timeout = 500, on_visual = false, higroup = 'VisualYank' })
      end,
    },
  })

  M.augroup('CheckOutsideTime', {
    desc = 'Automatically check for changed files outside vim',
    event = { 'WinEnter', 'BufWinEnter', 'BufWinLeave', 'BufRead', 'BufEnter', 'FocusGained' },
    command = function()
      vim.cmd.checktime()
    end,
  })

  M.augroup('SmartCloseBuffers', {
    {
      event = { 'FileType' },
      desc = 'Smart close certain filetypes with `q`',
      pattern = { '*' },
      command = function()
        -- local is_unmapped = vim.fn.hasmapto("q", "n") == 0
        local is_eligible =
          -- is_unmapped
          vim.wo.previewwindow or vim.tbl_contains({}, vim.bo.buftype) or vim.tbl_contains({
            'help',
            'git-status',
            'git-log',
            'oil',
            'dbui',
            'fugitive',
            'fugitiveblame',
            'LuaTree',
            'log',
            'tsplayground',
            'startuptime',
            'outputpanel',
            'preview',
            'qf',
            'man',
            'terminal',
            'lspinfo',
            'neotest-output',
            'neotest-output-panel',
            'query',
            'elixirls',
          }, vim.bo.filetype)
        if is_eligible then
          map('n', 'q', function()
            if vim.fn.winnr('$') ~= 1 then
              -- dbg("smart close quit mappings")
              vim.api.nvim_win_close(0, true)
              vim.cmd('wincmd p')
            end
          end, { buffer = 0, nowait = true, desc = 'smart buffer quit' })
        end
      end,
    },
  })

  local function clear_commandline()
    --- Track the timer object and stop any previous timers before setting
    --- a new one so that each change waits for 10secs and that 10secs is
    --- deferred each time
    local timer

    return function()
      if timer then
        timer:stop()
      end

      timer = vim.defer_fn(function()
        if vim.fn.mode() == 'n' then
          vim.cmd.echon("''")
        end
      end, 10000)
    end
  end

  M.augroup('CmdlineBehaviours', {
    {
      event = 'CmdlineEnter',
      command = function(ctx)
        if not ctx.match == ':' then
          return
        end
        local cmdline = vim.fn.getcmdline()
        local isSubstitution = cmdline:find('s ?/.+/.-/%a*$')
        if isSubstitution then
          vim.cmd(cmdline .. 'ne')
        end
      end,
    },
    {
      event = 'CmdlineLeave',
      command = function(ctx)
        if not ctx.match == ':' then
          return
        end
        vim.defer_fn(function()
          local lineJump = vim.fn.histget(':', -1):match('^%d+$')
          if lineJump then
            vim.fn.histdel(':', -1)
          end
        end, 100)
      end,
    },
    {
      event = { 'CmdlineLeave', 'CmdlineChanged' },
      desc = 'Clear command line messages',
      pattern = { ':' },
      command = clear_commandline(),
    },
  })

  M.augroup('EnterLeaveBehaviours', {
    {
      desc = 'Enable things on *Enter',
      event = { 'BufEnter', 'WinEnter' },
      command = function(evt)
        vim.defer_fn(function()
          local ibl_ok, ibl = pcall(require, 'ibl')
          if ibl_ok then
            ibl.setup_buffer(evt.buf, { indent = { char = SETTINGS.indent_char } })
          end
        end, 1)
        vim.wo.cursorline = true
        require('nvim-highlight-colors').turnOn()
      end,
    },
    {
      desc = 'Disable things on *Leave',
      event = { 'BufLeave', 'WinLeave' },
      command = function(evt)
        vim.defer_fn(function()
          local ibl_ok, ibl = pcall(require, 'ibl')
          if ibl_ok then
            ibl.setup_buffer(evt.buf, { indent = { char = '' } })
          end
        end, 1)
        vim.wo.cursorline = false
        require('nvim-highlight-colors').turnOff()
      end,
    },
  })

  M.augroup('InsertBehaviours', {
    {
      desc = 'OnInsertEnter',
      event = { 'InsertEnter' },
      command = function(_evt)
        vim.diagnostic.enable(not vim.diagnostic.is_enabled())
      end,
    },
    {
      desc = 'OnInsertLeave',
      event = { 'InsertLeave' },
      command = function(_evt)
        vim.diagnostic.enable()
      end,
    },
  })

  function swift.searchCountIndicator(mode)
    local signColumnPlusScrollbarWidth = 2 + 3 -- CONFIG

    local countNs = vim.api.nvim_create_namespace('searchCounter')
    vim.api.nvim_buf_clear_namespace(0, countNs, 0, -1)
    if mode == 'clear' then
      return
    end

    local row = vim.api.nvim_win_get_cursor(0)[1]
    local last_search = vim.fn.getreg('/')
    local count = vim.fn.searchcount()
    if count.total == 0 then
      return
    end
    local text = (' %d/%d (%s) '):format(count.current, count.total, last_search)
    local line = vim.api.nvim_get_current_line():gsub('\t', (' '):rep(vim.bo.shiftwidth))
    local lineFull = #line + signColumnPlusScrollbarWidth >= vim.api.nvim_win_get_width(0)
    local margin = { (' '):rep(lineFull and signColumnPlusScrollbarWidth or 0) }

    vim.api.nvim_buf_set_extmark(0, countNs, row - 1, 0, {
      virt_text = { { text, 'IncSearch' }, margin },
      virt_text_pos = lineFull and 'right_align' or 'eol',
      priority = 200, -- so it comes in front of lsp-endhints
    })
  end

  -- without the `searchCountIndicator`, this `on_key` simply does `auto-nohl`
  vim.on_key(function(char)
    local key = vim.fn.keytrans(char)
    local isCmdlineSearch = vim.fn.getcmdtype():find('[/?]') ~= nil
    local isNormalMode = vim.api.nvim_get_mode().mode == 'n'
    local searchStarted = (key == '/' or key == '?') and isNormalMode
    local searchConfirmed = (key == '<CR>' and isCmdlineSearch)
    local searchCancelled = (key == '<Esc>' and isCmdlineSearch)
    if not (searchStarted or searchConfirmed or searchCancelled or isNormalMode) then
      return
    end

    -- works for RHS, therefore no need to consider remaps
    local searchMovement = vim.tbl_contains({ 'n', 'N', '*', '#' }, key)

    if searchCancelled or (not searchMovement and not searchConfirmed) then
      vim.opt.hlsearch = false
      swift.searchCountIndicator('clear')
    elseif searchMovement or searchConfirmed or searchStarted then
      vim.opt.hlsearch = true
      vim.defer_fn(swift.searchCountIndicator, 1)
    end
  end, vim.api.nvim_create_namespace('autoNohlAndSearchCount'))

  M.augroup('Utilities', {
    {
      event = { 'VimResized' },
      --     desc = "Automatically resize windows in all tabpages when resizing Vim",
      command = function(args)
        vim.schedule(function()
          vim.cmd('tabdo wincmd =')
          swift.resize_windows(args.buf)
        end)
      end,
    },
    {
      event = { 'QuickFixCmdPost' },
      desc = 'Goes to first item in quickfix list automatically in Trouble',
      command = function(_args)
        vim.cmd([[Trouble qflist open]])
        pcall(vim.cmd.cfirst)
      end,
    },
    {
      event = { 'UIEnter', 'ColorScheme' },
      desc = 'Remove terminal padding around neovim instance',
      command = function(_args)
        local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
        if not normal.bg then
          return
        end
        io.write(string.format('\027]11;#%06x\027\\', normal.bg))
      end,
    },
    {
      event = { 'UILeave' },
      desc = 'remove terminal padding around neovim instance',
      command = function(_args)
        io.write('\027]111\027\\')
      end,
    },
    {
      event = { 'TermClose' },
      command = function(args)
        --- automatically close a terminal if the job was successful
        if U.falsy(vim.v.event.status) and U.falsy(vim.bo[args.buf].ft) then
          vim.cmd.bdelete({ args.buf, bang = true })
        end
      end,
    },

    {
      event = { 'BufWritePost' },
      desc = 'chmod +x shell scripts on-demand',
      command = function(args)
        local not_executable = vim.fn.getfperm(vim.fn.expand('%')):sub(3, 3) ~= 'x'
        local has_shebang = string.match(vim.fn.getline(1), '^#!')
        local has_bin = string.match(vim.fn.getline(1), '/bin/')
        if not_executable and has_shebang and has_bin then
          vim.notify(fmt('made %s executable', args.file), L.INFO)
          -- vim.cmd([[!chmod +x "%"]]) -- or a+x ?
          vim.cmd([[silent !chmod +x <afile>]]) -- or a+x ?
          vim.defer_fn(function()
            vim.cmd('edit')
          end, 100)
        end
      end,
    },
    -- REF: https://github.com/ribru17/nvim/blob/master/lua/autocmds.lua#L68
    -->> "RUN ONCE" ON FILE OPEN COMMANDS <<--
    --
    {
      event = { 'BufRead', 'BufNewFile' },
      enabled = false,
      desc = 'Prevents comment from being inserted when entering new line in existing comment',
      command = function()
        -- allow <CR> to continue block comments only
        -- https://stackoverflow.com/questions/10726373/auto-comment-new-line-in-vim-only-for-block-comments
        vim.schedule(function()
          -- TODO: find a way for this to work without changing comment format, to
          -- allow for automatic comment wrapping when hitting textwidth
          vim.opt_local.comments:remove('://')
          vim.opt_local.comments:remove(':--')
          vim.opt_local.comments:remove(':#')
          vim.opt_local.comments:remove(':%')
        end)
        vim.opt_local.bufhidden = 'delete'
      end,
    },
    {
      event = { 'BufNewFile', 'BufWritePre' },
      desc = 'Recursive mkdir on-demand',
      pattern = { '*' },
      command = [[if @% !~# '\(://\)' | call mkdir(expand('<afile>:p:h'), 'p') | endif]],
      -- command = function()
      --   -- @see https://github.com/yutkat/dotfiles/blob/main/.config/nvim/lua/rc/autocmd.lua#L113-L140
      --   swift.auto_mkdir()
      -- end,
    },
    {
      event = 'BufWritePost',
      pattern = '.envrc',
      command = function()
        if vim.fn.executable('direnv') then
          vim.cmd([[silent !direnv allow %]])
        end
      end,
    },
    {
      event = 'BufWritePost',
      pattern = '*/spell/*.add',
      command = 'silent! :mkspell! %',
    },
    {
      event = { 'BufEnter', 'BufRead', 'BufNewFile' },
      buffer = 0,
      desc = 'Extreeeeme `gf` open behaviour',
      command = function(args)
        map('n', 'gf', function()
          local target = vim.fn.expand('<cfile>')

          -- FIXME: get working with ghostty
          -- if U.is_image(target) then
          --   local root_dir = require("swift.utils.lsp").root_dir({ ".git" })
          --   target = target:gsub("./samples", fmt("%s/samples", root_dir))
          --   return require("swift.utils").preview_file(target)
          -- end

          -- go to linear ticket
          if target:match('TRN-') then
            local url = fmt('https://linear.app/ternit/issue/%s', target)
            vim.notify(fmt('Opening linear ticket %s at %s', target, url))
            vim.fn.jobstart(fmt('%s %s', vim.g.open_command, url))

            return false
          end

          -- go to PR for specific repos
          if target:match('^PR%-([DIR|BELL|RET|MOB]*)#(%d*)') then
            local repo_abbr, pr_num = target:match('^PR%-([DIR|BELL|RET|MOB]*)#(%d*)')
            local repos = {
              DIR = 'director',
              BELL = 'bellhop',
              RET = 'retriever',
              MOB = 'ternreturns',
            }

            local url = fmt('https://github.com/TernSystems/%s/pull/%s', repos[repo_abbr], pr_num)
            vim.notify(fmt('Opening PR %d on %s', pr_num, repos[repo_abbr]))
            vim.fn.jobstart(fmt('%s %s', vim.g.open_command, url))

            return false
          end

          -- go to hex packages
          if args.file:match('mix.exs') then
            local line = vim.fn.getline('.')
            local _, _, pkg, _ = string.find(line, [[^%s*{:(.*), %s*"(.*)"}]])

            local url = fmt('https://hexdocs.pm/%s/', pkg)
            vim.notify(fmt('Opening %s at %s', pkg, url))
            vim.fn.jobstart(fmt('%s %s', vim.g.open_command, url))

            return false
          end

          -- go to node packages
          if args.file:match('package.json') then
            local line = vim.fn.getline('.')
            local _, _, pkg, _ = string.find(line, [[^%s*"(.*)":%s*"(.*)"]])

            local url = fmt('https://www.npmjs.com/package/%s', pkg)
            vim.notify(fmt('Opening %s at %s', pkg, url))
            vim.fn.jobstart(fmt('%s %s', vim.g.open_command, url))

            return false
          end

          -- go to web address
          if target:match('https://') then
            return vim.cmd('norm gx')
          end

          -- a normal file, so do the normal go-to-file thing
          if not target or #vim.split(target, '/') ~= 2 then
            return vim.cmd('norm! gf')
          end

          -- maybe it's a github repo? try it and see..
          local url = fmt('https://github.com/%s', target)
          vim.fn.jobstart(fmt('%s %s', vim.g.open_command, url))
          vim.notify(fmt('Opening %s at %s', target, url))
        end, { desc = '[g]oto [f]ile (on steroids)' })
      end,
    },
    {
      event = { 'BufRead', 'BufNewFile' },
      pattern = '*/doc/*.txt',
      command = function(args)
        vim.bo.filetype = 'help'
      end,
    },
    {
      event = { 'BufRead', 'BufNewFile' },
      pattern = 'package.json',
      command = function(args)
        vim.keymap.set({ 'n' }, 'gx', function()
          local line = vim.fn.getline('.')
          local _, _, pkg, _ = string.find(line, [[^%s*"(.*)":%s*"(.*)"]])

          if pkg then
            local url = 'https://www.npmjs.com/package/' .. pkg
            vim.ui.open(url)
          end
        end, { buffer = true, silent = true, desc = '[g]o to node [p]ackage' })
      end,
    },
    {
      event = { 'BufRead', 'BufNewFile' },
      pattern = 'mix.exs',
      command = function(args)
        vim.keymap.set({ 'n' }, 'gx', function()
          local line = vim.fn.getline('.')
          local _, _, pkg, _ = string.find(line, [[^%s*{:(.*), %s*"(.*)"}]])

          if pkg then
            local url = fmt('https://hexdocs.pm/%s/', pkg)
            vim.ui.open(url)
          end
        end, { buffer = true, silent = true, desc = '[g]o to hex [p]ackage' })
      end,
    },
  })
end

return M
