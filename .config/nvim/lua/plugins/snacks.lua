vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("terminal-keymaps", { clear = true }),
	pattern = "term://*",
	callback = function(event)
		vim.keymap.set("t", "jk", [[<C-\><C-n>]], { buffer = event.buf, desc = "Leave terminal mode" })
	end,
})

vim.api.nvim_create_autocmd("User", {
	group = vim.api.nvim_create_augroup("mini-files-rename", { clear = true }),
	pattern = "MiniFilesActionRename",
	callback = function(event)
		Snacks.rename.on_rename_file(event.data.from, event.data.to)
	end,
})

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {

		---@class snacks.picker.matcher.Config
		matcher = {
			frecency = true,
		},
		image = {
			enabled = true,
			-- formats = {},
		},
		statuscolumn = {
			left = { "mark", "sign" }, -- priority of signs on the left (high to low)
			right = { "fold", "git" }, -- priority of signs on the right (high to low)
			folds = {
				open = false, -- show open fold icons
				git_hl = false, -- use Git Signs hl for fold icons
			},
			git = {
				-- patterns to match Git signs
				patterns = { "GitSign", "MiniDiffSign" },
			},
			refresh = 50, -- refresh at most every 50ms
		},
		gh = {},
		bigfile = { enabled = true },
		indent = { enabled = true, animate = { enabled = false } },
		picker = {
			sources = {
				gh_issue = {},
				gh_pr = {},
			},
			layouts = {
				default = {
					layout = {
						box = "vertical",
						backdrop = false,
						row = -1,
						width = 0,
						height = 0.7,
						border = "top",
						title = " {title} {live} {flags}",
						title_pos = "left",
						{ win = "input", height = 1, border = "bottom" },
						{
							box = "horizontal",
							{ win = "list", border = "none" },
							{ win = "preview", title = "{preview}", width = 0.6, border = "left" },
						},
					},
				},
			},
			win = {
				input = {
					keys = {
						["<c-h>"] = { "toggle_hidden", mode = { "i", "n" } },
						["<a-g>"] = { "toggle_live", mode = { "i", "n" } },
					},
				},
			},
		},
		quickfile = { enabled = true },
		terminal = {
			win = { style = "float" },
		},
	},
	keys = {
		{
			"<leader>bd",
			function()
				Snacks.bufdelete()
			end,
			desc = "Delete Buffer",
		},
		{
			"<c-\\>",
			function()
				Snacks.terminal()
			end,
			desc = "Toggle Terminal",
			mode = { "n", "i", "t" },
		},

		-- picker
		{
			"<leader>f",
			function()
				Snacks.picker.files({ exclude = { "node_modules/", "*.lock" }, hidden = true })
			end,
			desc = "Find Files",
		},
		{
			"<leader>sf",
			function()
				local buf_dir = vim.fn.expand("%:p:h")
				Snacks.picker.files({ cwd = buf_dir })
			end,
			desc = "Search Folder",
		},
		{
			"<leader>sh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Pages",
		},
		{
			"<leader>sg",
			function()
				Snacks.picker.grep({ exclude = { "node_modules/", "*.lock" } })
			end,
			desc = "Grep",
		},
		{
			"<leader>sb",
			function()
				Snacks.picker.git_branches()
			end,
			desc = "Git Branches",
		},
		{
			"<leader>sw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Visual selection or word",
			mode = { "n", "x" },
		},
		{
			"<leader>sr",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume",
		},
		{
			"<leader>sH",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<leader>sq",
			function()
				Snacks.picker.qflist()
			end,
			desc = "Quickfix List",
		},
		{
			"<leader>so",
			function()
				Snacks.picker.recent({ filter = { cwd = true } })
			end,
			desc = "Recent",
		},
		{
			"<leader>ss",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},
		{
			"<leader>sk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},

		-- remove outer identation "do"
		{
			"o",
			mode = "o",
			desc = "Move outer indentation",
			function()
				local operator = vim.v.operator
				if operator == "d" then
					local move = ""

					local scope = require("snacks").scope.get(function(scope)
						local top = scope.from
						local bottom = scope.to
						local row, col = unpack(vim.api.nvim_win_get_cursor(0))

						if row == bottom then
							move = "k"
						elseif row == top then
							move = "j"
						end

						local ns = vim.api.nvim_create_namespace("border")

						vim.hl.range(0, ns, "Substitute", { top - 1, 0 }, { top - 1, -1 })
						vim.hl.range(0, ns, "Substitute", { bottom - 1, 0 }, { bottom - 1, -1 })

						vim.defer_fn(function()
							vim.api.nvim_buf_set_text(0, top - 1, 0, top - 1, -1, {})
							vim.api.nvim_buf_set_text(0, bottom - 1, 0, bottom - 1, -1, {})
							vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
						end, 150)
					end, { cursor = false })

					return "<esc>" .. move
				else
					return "o"
				end
			end,
			{ expr = true },
		},

		{
			"<leader>gi",
			function()
				Snacks.picker.gh_issue()
			end,
			desc = "GitHub Issues (open)",
		},
		{
			"<leader>gI",
			function()
				Snacks.picker.gh_issue({ state = "all" })
			end,
			desc = "GitHub Issues (all)",
		},
		{
			"<leader>gp",
			function()
				Snacks.picker.gh_pr()
			end,
			desc = "GitHub Pull Requests (open)",
		},
		{
			"<leader>gP",
			function()
				Snacks.picker.gh_pr({ state = "all" })
			end,
			desc = "GitHub Pull Requests (all)",
		},
	},
}
