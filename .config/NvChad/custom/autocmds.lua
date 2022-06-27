local autocmd = vim.api.nvim_create_autocmd
local cmd = vim.cmd

cmd("set whichwrap+=<,>,[,],h,l")
cmd("set iskeyword+=-")

autocmd("FileType", {
	pattern = "norg",
	callback = function()
		vim.opt.laststatus = 0
	end,
})
