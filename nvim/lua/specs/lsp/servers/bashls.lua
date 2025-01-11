local M = {}

M.settings = {
  bash = {
    filetypes = { 'sh', 'zsh', 'bash' }, -- work in zsh as well
    settings = {
      bashIde = {
        shellcheckPath = '',                  -- disable while using efm
        shellcheckArguments = '--shell=bash', -- PENDING https://github.com/bash-lsp/bash-language-server/issues/1064
        shfmt = { spaceRedirects = true },
      },
    },
  },
}

return M
