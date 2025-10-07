local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

return {
	cmd = { "solargraph", "stdio" },
	filetypes = { "ruby" },
	capabilities = capabilities,
	settings = {
		solargraph = {
			diagnostics = true,
			formatting = true,
			completion = true,
		},
	},
}
