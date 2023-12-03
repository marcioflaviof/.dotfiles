require("typescript-tools").setup({
  settings = {
    separate_diagnostic_server = false,
    publish_diagnostic_on = "insert_leave",
    tsserver_max_memory = "auto",
    tsserver_plugins = {},
    tsserver_format_options = {},
    tsserver_file_preferences = {
      includeInlayParameterNameHints = "all",
      includeInlayEnumMemberValueHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeCompletionsForModuleExports = true,
    },
    expose_as_code_action = 'all',
  },

  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    -- if client.server_capabilities.inlayHintProvider then
    --   local inlay_hints_group = vim.api.nvim_create_augroup('InlayHints', { clear = true })
    --
    --
    --   -- Initial inlay hint display.
    --   local mode = vim.api.nvim_get_mode().mode
    --   vim.lsp.inlay_hint(bufnr, mode == 'n' or mode == 'v')
    --
    --   vim.api.nvim_create_autocmd('InsertEnter', {
    --     group = inlay_hints_group,
    --     buffer = bufnr,
    --     callback = function()
    --       vim.lsp.inlay_hint(bufnr, false)
    --     end,
    --   })
    --   vim.api.nvim_create_autocmd('InsertLeave', {
    --     group = inlay_hints_group,
    --     buffer = bufnr,
    --     callback = function()
    --       vim.lsp.inlay_hint(bufnr, true)
    --     end,
    --   })
    -- end
  end,
})
