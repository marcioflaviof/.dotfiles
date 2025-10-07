local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

return {
	cmd = { "ruby-lsp" },
	filetypes = { "ruby" },
	capabilities = capabilities,
	settings = {
		rubyLsp = {
			format = { provider = "rubocop" },
			diagnostics = { enabled = true, rubocop = true },
		},
	},
}
