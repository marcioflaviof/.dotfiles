local utils = require("plugins.lsp.utils")
local M = {}

-- shared between typescript + javascript blocks
M.inlay_hints = {
	includeInlayParameterNameHints = "all",
	includeInlayParameterNameHintsWhenArgumentMatchesName = false,
	includeInlayFunctionParameterTypeHints = true,
	includeInlayVariableTypeHints = true,
	includeInlayVariableTypeHintsWhenTypeMatchesName = false,
	includeInlayPropertyDeclarationTypeHints = true,
	includeInlayFunctionLikeReturnTypeHints = true,
	includeInlayEnumMemberValueHints = true,
}

function M.setup()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

	local servers = {
		lua_ls = {
			settings = {
				Lua = {
					completion = { callSnippet = "Replace" },
					telemetry = { enable = false },
					hint = { enable = false },
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
				-- inlayHints config is read per-language (typescript/javascript), not under preferences
				typescript = { inlayHints = M.inlay_hints },
				javascript = { inlayHints = M.inlay_hints },
			},
		},
	}

	-- Ruby: pick a server from what the project pins, defaulting to ruby-lsp.
	local ruby_major = utils.get_ruby_version()
	vim.lsp.enable((ruby_major and ruby_major < 3) and "solargraph" or "ruby-lsp")

	-- Mason tool installation. Listed explicitly rather than derived from
	-- `servers` so lua_ls is not requested twice with conflicting versions.
	require("mason-tool-installer").setup({
		ensure_installed = {
			{ "lua_ls", version = "3.16.4", auto_update = false },
			"ts_ls",
			"html",
			"jsonls",
			"gopls",
			"ruby_lsp",
			{ "solargraph", version = "0.55.4" },
			"emmet_ls",
			"kulala-fmt",
			"sql-formatter", -- conform's `sql_formatter` for filetype=sql
		},
	})

	-- Register per-server config so automatic_enable picks it up (mason-lspconfig v2 dropped `handlers`)
	vim.lsp.config("*", { capabilities = capabilities })
	for server_name, server in pairs(servers) do
		vim.lsp.config(server_name, server)
	end

	-- Mason LSP Config
	require("mason-lspconfig").setup({
		automatic_enable = { exclude = { "solargraph", "ruby_lsp" } },
	})
end

return M
