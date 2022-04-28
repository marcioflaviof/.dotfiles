return {
	setup = function(client, bufnr)
		local ts = require("nvim-lsp-ts-utils")
		-- vim.lsp.handlers["textDocument/codeAction"] = ts.code_action_handler
		ts.setup({
			disable_commands = false,
			enable_import_on_completion = false,
			import_on_completion_timeout = 5000,
			eslint_bin = "eslint_d", -- use eslint_d if possible!
			eslint_enable_diagnostics = true,
			-- eslint_fix_current = false,
			eslint_enable_disable_comments = true,
		})

		-- local opts = { noremap = true, silent = true }

		-- vim.api.nvim_buf_set_keymap(bufnr, "n", " oi", ":TSLspOrganize<CR>", opts)
		-- vim.api.nvim_buf_set_keymap(bufnr, "n", " ia", ":TSLspImportAll<CR>", opts)

		ts.setup_client(client)
	end,
}
