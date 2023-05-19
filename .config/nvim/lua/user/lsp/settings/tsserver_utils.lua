local status_ok, typescript = pcall(require, "typescript")
if not status_ok then
	return
end

local function filter(arr, fn)
	if type(arr) ~= "table" then
		return arr
	end

	local filtered = {}
	for k, v in pairs(arr) do
		if fn(v, k, arr) then
			table.insert(filtered, v)
		end
	end

	return filtered
end

local function filterReactDTS(value)
	return string.match(value.filename, "react/index.d.ts") == nil
end

local function on_list(options)
	local items = options.items
	if #items > 1 then
		items = filter(items, filterReactDTS)
	end

	vim.fn.setqflist({}, " ", { title = options.title, items = items, context = options.context })
	vim.api.nvim_command("cfirst") -- or maybe you want 'copen' instead of 'cfirst'
end

typescript.setup({
	disable_commands = false, -- prevent the plugin from creating Vim commands
	debug = false, -- enable debug logging for commands
	eslint_bin = "eslint_d", -- use eslint_d if possible!
	import_on_completion_timeout = 5000,
	go_to_source_definition = {
		fallback = true,
	},
	server = {
		on_attach = function(client, bufnr)
			if client.name == "tsserver" or client.name == "typescript" then
				client.server_capabilities.document_formatting = false

				local bufopts = { noremap = true, silent = true, buffer = bufnr }

				vim.keymap.set("n", "gd", function()
					vim.lsp.buf.definition({ on_list = on_list })
				end, bufopts)

				vim.keymap.set("n", "<leader>lu", function()
					local ts = require("typescript").actions
					ts.removeUnused({ sync = true })
				end)
			end
		end,
	},
})

-- Remove an annoying warning
vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, ...)
	local client = vim.lsp.get_client_by_id(ctx.client_id)

	if client and client.name == "tsserver" then
		result.diagnostics = vim.tbl_filter(function(diagnostic)
			return not diagnostic.message:find("File is a CommonJS module; it may be converted to an ES module.")
		end, result.diagnostics)
	end

	return vim.lsp.diagnostic.on_publish_diagnostics(nil, result, ctx, ...)
end
