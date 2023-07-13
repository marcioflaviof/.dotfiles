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

local opts = { noremap = true, silent = true }

require("typescript-tools").setup({
	on_attach = function(client, bufnr)
		client.server_capabilities.document_formatting = false
		vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

		local bufopts = { noremap = true, silent = true, buffer = bufnr }

		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition({ on_list = on_list })
		end, bufopts)
	end,

	settings = {
		separate_diagnostic_server = true,
		publish_diagnostic_on = "insert_leave",
		tsserver_max_memory = "auto",
		tsserver_plugins = {},
		tsserver_format_options = {},
		tsserver_file_preferences = {},
	},
})
