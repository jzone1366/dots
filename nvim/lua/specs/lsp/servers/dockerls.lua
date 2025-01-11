local M = {}

M.settings = {
  single_file_support = true,
  settings = {
    docker = {
      languageserver = {
        formatter = {
          ignoreMultilineInstructions = true,
        },
      },
    },
  },
}

return M
