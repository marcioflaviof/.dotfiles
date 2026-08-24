local RemoveComments = function()
	local ts = vim.treesitter
	local bufnr = vim.api.nvim_get_current_buf()
	local ft = vim.bo[bufnr].filetype
	local lang = ts.language.get_lang(ft) or ft

	local ok, parser = pcall(ts.get_parser, bufnr, lang)
	if not ok then
		return vim.notify("No parser for " .. ft, vim.log.levels.WARN)
	end

	if parser == nil then
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
		lazy = false,
		branch = "main",
		build = ":TSUpdate",
		config = function()
			if vim.fn.executable("tree-sitter") == 0 then
				vim.notify("nvim-treesitter (main) requires the `tree-sitter` executable", vim.log.levels.WARN)
			end

			local TS = require("nvim-treesitter")

			TS.setup()

			TS.install({
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
			})

			local available = nil
			local pending = {}

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("ts-highlight", { clear = true }),
				callback = function(ev)
					local lang = vim.treesitter.language.get_lang(ev.match)
					if not lang then
						return
					end

					if vim.tbl_contains(TS.get_installed("parsers"), lang) then
						pcall(vim.treesitter.start, ev.buf, lang)
						return
					end

					if pending[lang] then
						return
					end
					available = available or TS.get_available()
					if not vim.tbl_contains(available, lang) then
						return
					end

					pending[lang] = true
					TS.install(lang):await(function()
						pending[lang] = nil
						for _, buf in ipairs(vim.api.nvim_list_bufs()) do
							if vim.api.nvim_buf_is_loaded(buf) then
								local buf_lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
								if buf_lang == lang then
									pcall(vim.treesitter.start, buf, lang)
								end
							end
						end
					end)
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
