local autocmd = vim.api.nvim_create_autocmd

local opt = vim.opt

opt.scrolloff = 8
opt.number = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.termguicolors = true
opt.autoread = true
opt.completeopt = { "menuone", "noselect" }
opt.mouse = "a"
opt.guifont = "JetBrainsMono Nerd Font"
opt.clipboard = "unnamedplus"

autocmd("FileType", {
	pattern = "norg",
	callback = function()
		vim.opt.laststatus = 0
	end,
})
