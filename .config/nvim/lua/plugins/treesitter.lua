local highlighter = require("vim.treesitter.highlighter")
local RemoveComments = function()
	local ts = vim.treesitter
	local bufnr = vim.api.nvim_get_current_buf()
	local ft = vim.bo[bufnr].filetype
	local lang = ts.language.get_lang(ft) or ft

	local ok, parser = pcall(ts.get_parser, bufnr, lang)
	if not ok then
		return vim.notify("No parser for " .. ft, vim.log.levels.WARN)
	end

	local tree = parser:parse()[1]
	local root = tree:root()
	local query = ts.query.parse(lang, "(comment) @comment")

	local ranges = {}
	for _, node in query:iter_captures(root, bufnr, 0, -1) do
		table.insert(ranges, { node:range() })
	end

	table.sort(ranges, function(a, b)
		if a[1] == b[1] then
			return a[2] < b[2]
		end
		return a[1] > b[1]
	end)

	for _, r in ipairs(ranges) do
		vim.api.nvim_buf_set_text(bufnr, r[1], r[2], r[3], r[4], {})
	end
end

vim.api.nvim_create_user_command("RemoveComments", RemoveComments, {})

return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		lazy = true,
		branch = "main",
		build = ":TSUpdate",
		cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
		init = function() end,
		config = function()
			if vim.fn.executable("tree-sitter") == 0 then
				print("**treesitter-main** requires the `tree-sitter` executable to be installed")
			end
			local opts = {
				auto_install = true,
				matchup = {
					enable = true,
					enable_quotes = true,
				},
			}

			local ensure_installed = {
				"javascript",
				"go",
				"typescript",
				"html",
				"css",
				"tsx",
				"ruby",
				"lua",
				"embedded_template",
				"markdown",
			}

			local TS = require("nvim-treesitter")
			TS.install(ensure_installed)
			TS.setup(opts)

			local installed = TS.get_installed("parsers")

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(ev)
					local lang = vim.treesitter.language.get_lang(ev.match)

					if vim.tbl_contains(installed, lang) then
						pcall(vim.treesitter.start)
					end
				end,
			})
		end,
	},
	{
		"folke/ts-comments.nvim",
		opts = { lang = { sql = "-- %s" } },
		event = "VeryLazy",
		enabled = true,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			enable = true,
			max_lines = 3,
		},
	},
}
