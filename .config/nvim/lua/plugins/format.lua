local prettier = { "prettierd", "prettier", stop_after_first = true }

return {
	-- Autoformat
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>lf",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = false,
		-- format_on_save = {
		--   lsp_format = "fallback",
		--   timeout_ms = 500
		-- },

		formatters = {
			["herb-format"] = {
				command = "/home/mf/.local/share/mise/installs/node/23.11.0/bin/herb-format", -- use absolute path
				stdin = true,
			},
		},

		formatters_by_ft = {
			lua = { "stylua" },
			-- Conform can also run multiple formatters sequentially
			-- python = { "isort", "black" },
			--
			-- You can use 'stop_after_first' to run the first available formatter from the list
			markdown = prettier,
			javascript = prettier,
			typescript = prettier,
			javascriptreact = prettier,
			typescriptreact = prettier,
			json = { "prettierd", "prettier", "jq", stop_after_first = true },
			css = prettier,
			graphql = prettier,
			yaml = prettier,
			sql = { "sql_formatter" },
			eruby = { "herb-format" },
			go = { "goimports", "gofmt" },
			http = { "kulala-fmt" },
			c = { "clang-format" },
			-- ruby = { "rufo", stop_after_first = true }
		},
	},
}
