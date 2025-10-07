local utils = require("plugins.lsp.utils")
local M = {}

function M.setup()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

	local servers = {
		lua_ls = {
			settings = {
				Lua = {
					completion = { callSnippet = "Replace" },
					diagnostics = { disable = { "missing-fields" } },
				},
			},
		},
		ts_ls = {
			filetypes = {
				"typescript",
				"typescriptreact",
				"javascript",
				"javascriptreact",
			},
			settings = {
				preferences = {
					importModuleSpecifierPreference = "relative",
				},
			},
		},
	}

	-- Ruby Version Detection and Server Setup
	local ruby_major = utils.get_ruby_version()

	if ruby_major then
		if ruby_major >= 3 then
			vim.lsp.enable("ruby-lsp")
		elseif ruby_major < 3 then
			vim.lsp.enable("solargraph")
		end
	end

	-- Mason Tool Installation
	local ensure_installed = vim.tbl_keys(servers or {})
	vim.list_extend(ensure_installed, {
		"html",
		"jsonls",
		"lua_ls",
		"flake8",
		"erb-formatter",
		"gopls",
		"ruby_lsp",
		{ "solargraph", version = "0.55.4" },
		"emmet_ls",
		"kulala-fmt",
	})
	require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

	-- Mason LSP Config
	require("mason-lspconfig").setup({
		automatic_enable = { exclude = { "solargraph", "ruby_lsp" } },
		handlers = {
			function(server_name)
				local server = servers[server_name] or {}
				server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
				vim.lsp.enable(server)
			end,
		},
	})
end

return M
