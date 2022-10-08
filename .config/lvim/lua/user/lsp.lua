lvim.format_on_save = true
lvim.lsp.diagnostics.virtual_text = true

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = { "javascript", "typescript", "html", "tsx", "org", "ruby", "lua", "css" }

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "prettier", filetypes = { "javascript", "typescript", "typescriptreact" } },
  { command = "stylua", filetypes = { "lua" } },
  { command = "rubocop", filetypes = { "ruby" } },
}

-- lvim.lsp.on_attach_callback = function(client, bufnr)
-- end

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "eslint_d", filetypes = { "javascript", "typescript", "typescriptreact" } },
  { command = "rubocop", filetypes = { "ruby" } },
}
