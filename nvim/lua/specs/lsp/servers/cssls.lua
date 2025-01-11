local M = {}

M.settings = {
  css = {
    validate = false,
    lint = {
      unknownProperties = 'ignore',
      unknownAtRules = 'ignore',
      vendorPrefix = 'ignore', -- needed for scrollbars
      duplicateProperties = 'warning',
      zeroUnits = 'warning',
    },
  },
  scss = {
    lint = {
      idSelector = 'warning',
      zeroUnits = 'warning',
      duplicateProperties = 'warning',
      unknownAtRules = 'ignore',
    },
    completion = {
      completePropertyWithSemicolon = true,
      triggerPropertyValueCompletion = true,
    },
  },
}

M.on_attach = function(client, _)
  client.server_capabilities.documentFormattingProvider = true
  client.server_capabilities.documentRangeFormattingProvider = true
end

return M
