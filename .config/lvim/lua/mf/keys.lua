lvim.leader = "space"

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

vim.g.gui_font_default_size = 12
vim.g.gui_font_size = vim.g.gui_font_default_size
vim.g.gui_font_face = "Fira Code Retina"

RefreshGuiFont = function()
  vim.opt.guifont = string.format("%s:h%s", vim.g.gui_font_face, vim.g.gui_font_size)
end

ResizeGuiFont = function(delta)
  vim.g.gui_font_size = vim.g.gui_font_size + delta
  RefreshGuiFont()
end

ResetGuiFont = function()
  vim.g.gui_font_size = vim.g.gui_font_default_size
  RefreshGuiFont()
end

-- Call function on startup to set default value
ResetGuiFont()

-- Keymaps

local opts = { noremap = true, silent = true }

vim.keymap.set({ 'n', 'i' }, "<C-+>", function() ResizeGuiFont(1) end, opts)
vim.keymap.set({ 'n', 'i' }, "<C-->", function() ResizeGuiFont(-1) end, opts)
vim.keymap.set({ 'n', 'i' }, "<C-BS>", function() ResetGuiFont() end, opts)

local keymap = vim.api.nvim_set_keymap

keymap("n", "<F5>", ":let @+ = expand('%:p')<CR>", opts)
keymap("n", "<F4>", ':let @+ = fnamemodify(expand("%"), ":~:.")<CR>', opts)
