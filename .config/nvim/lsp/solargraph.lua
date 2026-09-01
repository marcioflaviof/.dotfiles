-- capabilities come from the `vim.lsp.config("*")` block in
-- lua/plugins/lsp/servers.lua, which already merges blink's.
return {
	cmd = { "solargraph", "stdio" },
	filetypes = { "ruby" },
	settings = {
		solargraph = {
			diagnostics = true,
			formatting = true,
			completion = true,
		},
	},
}
