require("typescript-tools").setup({
  settings = {
    separate_diagnostic_server = false,
    publish_diagnostic_on = "insert_leave",
    tsserver_max_memory = "auto",
    tsserver_plugins = {},
    tsserver_format_options = {},
    tsserver_file_preferences = {
      includeCompletionsForModuleExports = true,
    },
    expose_as_code_action = 'all',
  },

  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
})
