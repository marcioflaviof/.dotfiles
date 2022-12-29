require "user.lsp.languages.js-ts"
require "user.lsp.languages.ruby"

lvim.format_on_save = true
lvim.lsp.diagnostics.virtual_text = true

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = { "javascript", "typescript", "html", "tsx", "org", "ruby", "lua", "css" }

local formatters = require "lvim.lsp.null-ls.formatters"

formatters.setup {
  { command = "stylua", filetypes = { "lua" } },
}
