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
	guifont = "Fira Code:h11",
	clipboard = "", -- unnamedplus to access system clipboard
	updatetime = 300,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.o.termguicolors = true

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd("set iskeyword+=-")

vim.cmd("set wildignore+=*.pyc")
vim.cmd("set wildignore+=*_build/*")
vim.cmd("set wildignore+=**/coverage/*")
vim.cmd("set wildignore+=**/node_modules/*")
vim.cmd("set wildignore+=**/android/*")
vim.cmd("set wildignore+=**/ios/*")
vim.cmd("set wildignore+=**/.git/*")
vim.g["closetag_filenames"] = "*.jsx, *.html, *.tsx"
