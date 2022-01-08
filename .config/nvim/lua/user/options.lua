local options = {
	scrolloff = 8,
	number = true,
	tabstop = 4,
	softtabstop = 4,
	shiftwidth = 2,
	expandtab = true,
	smartindent = true,
	termguicolors = true,
	autoread = true,
	completeopt = { "menuone", "noselect" },
	mouse = "a",
	guifont = "Hack:h11",
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd("set nohlsearch")
-- Ignore files
vim.cmd("set wildignore+=*.pyc")
vim.cmd("set wildignore+=*_build/*")
vim.cmd("set wildignore+=**/coverage/*")
vim.cmd("set wildignore+=**/node_modules/*")
vim.cmd("set wildignore+=**/android/*")
vim.cmd("set wildignore+=**/ios/*")
vim.cmd("set wildignore+=**/.git/*")
