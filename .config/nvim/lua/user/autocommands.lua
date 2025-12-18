local autocmd = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup

local yank_group = ag("HighlightYank", {})

-- jbuilder as ruby
autocmd("BufRead", {
	pattern = { "*.jbuilder" },
	callback = function()
		vim.schedule(function()
			vim.api.nvim_command("set ft=ruby")
		end)
	end,
})

-- eruby.yml as yaml
autocmd("BufRead", {
	pattern = { "*.yml*" },
	callback = function()
		vim.schedule(function()
			vim.api.nvim_command("set ft=yaml")
		end)
	end,
})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.hl.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

-- prevent commenting out next line after comment
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "r", "o" })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.spelllang = { "en_us" }
	end,
})

-- GROUPS:
-- local disable_node_modules_eslint_group = ag("DisableNodeModulesEslint", { clear = true })

-- autocmd({ "BufNewFile", "BufRead" }, {
--   pattern = { "**/node_modules/**", "node_modules", "/node_modules/*" },
--   callback = function()
--     vim.diagnostic.enable(false)
--   end,
--   group = disable_node_modules_eslint_group,
-- })

autocmd({ "FileType" }, {
	desc = "On buffer enter with file type sql",
	group = vim.api.nvim_create_augroup("dbee", { clear = true }),
	pattern = { "sql" },
	callback = function()
		vim.keymap.set({ "n" }, "<leader>bb", function()
			vim.api.nvim_feedkeys("vip", "n", false)
			local srow, scol, erow, ecol = require("dbee.utils").visual_selection()
			local selection = vim.api.nvim_buf_get_text(0, srow, scol, erow, ecol, {})
			local query = table.concat(selection, "\n")
			local command = string.format("Dbee execute %s", query)
			-- vim.print(command)
			vim.api.nvim_command(command)
		end, { desc = "[D]bee [e]xecute query under cursor" })
	end,
})
