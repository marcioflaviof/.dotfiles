local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local yank_group = augroup("HighlightYank", {})

-- Put stories from storybook as markdown files
autocmd("BufRead", {
	pattern = { "*.stories.mdx", "*.stories.md" },
	callback = function()
		vim.schedule(function()
			vim.api.nvim_command("set ft=tsx")
		end)
	end,
})

-- jbuilder as ruby
autocmd("BufRead", {
	pattern = { "*.jbuilder" },
	callback = function()
		vim.schedule(function()
			vim.api.nvim_command("set ft=ruby")
		end)
	end,
})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

local ag = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

-- GROUPS:
local disable_node_modules_eslint_group = ag("DisableNodeModulesEslint", { clear = true })

-- AUTO-COMMANDS:
au({ "BufNewFile", "BufRead" }, {
	pattern = { "**/node_modules/**", "node_modules", "/node_modules/*" },
	callback = function()
		vim.diagnostic.disable(0)
	end,
	group = disable_node_modules_eslint_group,
})
