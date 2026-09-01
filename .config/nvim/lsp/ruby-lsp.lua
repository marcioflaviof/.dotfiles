-- capabilities come from the `vim.lsp.config("*")` block in
-- lua/plugins/lsp/servers.lua, which already merges blink's.
return {
	cmd = { "ruby-lsp" },
	filetypes = { "ruby" },
	settings = {
		rubyLsp = {
			format = { provider = "rubocop" },
			diagnostics = { enabled = true, rubocop = true },
		},
	},
}
