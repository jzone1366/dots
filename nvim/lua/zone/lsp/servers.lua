local utils = require('zone.utils')
local lazy = require('zone.utils.lazy')

local luals_conf = {
  'lua_ls',
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = utils.get_runtime_path(),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          [vim.fn.stdpath('config') .. '/lua'] = true,
        },
        maxPreload = 10000,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

local lsp_servers = {
  'bashls', -- npm i -g bash-language-server
  --'ccls', -- https://github.com/MaskRay/ccls/wiki
  {
    'cssls', -- npm i -g vscode-langservers-extracted
    settings = {
      css = { validate = false },
      scss = { validate = false },
      less = { validate = false },
    },
  },
  'cmake',
  --   'denols', -- TODO: Prevent denols from starting in NodeJS projects https://github.com/denoland/deno
  'dockerls', -- npm install -g dockerfile-language-server-nodejs
  'dotls', -- npm install -g dot-language-server
  {
    'gopls', -- go install golang.org/x/tools/gopls@latest / https://github.com/golang/tools/tree/master/gopls
    formatting = false,
  },
  'graphql', -- npm install -g graphql-language-service-cli
  'html', -- npm i -g vscode-langservers-extracted
  {
    'jsonls', -- npm i -g vscode-langservers-extracted
    formatting = false,
    cmd = {
      'node',
      '/usr/lib/code/extensions/json-language-features/server/dist/node/jsonServerMain.js',
      '--stdio',
    },
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line('$'), 0 })
        end,
      },
    },
    settings = lazy.table(function()
      return {
        json = { schemas = require('schemastore').json.schemas() },
      }
    end),
  },
  'phpactor',
  {
    'pylsp', -- pip install "python-lsp-server[all]"
    formatting = false,
    cmd = {
      'pylsp',
      '-v',
      '--log-file',
      vim.fn.stdpath('cache') .. '/pylsp.log',
    },
    --    settings = {
    --      pylsp = {
    --        plugins = {
    --          pylint = { enabled = true, args = { '-j0' } },
    --          yapf = { enabled = false },
    --          pycodestyle = { enabled = false },
    --          autopep8 = { enabled = true },
    --          pydocstyle = { enabled = false },
    --        },
    --      },
    --    },
  },
  --'rust_analyzer', -- https://rust-analyzer.github.io/manual.html#rust-analyzer-language-server-binary
  -- 'rnix', -- cargo install rnix-lsp
  'sqlls', -- npm i -g sql-language-server
  luals_conf, -- brew install lua-language-server
  'tailwindcss', -- npm install -g @tailwindcss/language-server
  {
    'tsserver', -- npm install -g typescript typescript-language-server
    formatting = false,
  },
  'vuels',
  'vimls', -- npm install -g vim-language-server
  'yamlls', -- npm install -g yaml-language-server
}

return lsp_servers
