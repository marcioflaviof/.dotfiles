local navbuddy = require("nvim-navbuddy")

navbuddy.setup({
	lsp = {
		auto_attach = true, -- If set to true, you don't need to manually use attach function
		preference = { "tsserver" }, -- list of lsp server names in order of preference
	},
})
