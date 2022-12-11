-- if you don't want all the parsers change this to a table of the ones you want
local formatters = require "lvim.lsp.null-ls.formatters"

formatters.setup {
  { command = "rubocop", filetypes = { "ruby" } },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "rubocop", filetypes = { "ruby" } },
}
