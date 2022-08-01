local status_ok, typescript = pcall(require, "typescript")
if not status_ok then
	return
end

typescript.setup({
	disable_commands = false, -- prevent the plugin from creating Vim commands
	debug = false, -- enable debug logging for commands
	eslint_bin = "eslint_d", -- use eslint_d if possible!
	import_on_completion_timeout = 5000,
	server = {

		on_attach = function(client)
			if client.name == "tsserver" or client.name == "typescript" then
				client.resolved_capabilities.document_formatting = false
				-- require("user.lsp.ts-utils").setup(client)
			end
		end,
	},
})
