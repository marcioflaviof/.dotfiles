local map = vim.keymap.set

-- Remap space as leader key
map("", "<Space>", "<Nop>", { desc = "Leader" })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- Split resize
map("n", "<M-,>", "<C-w>5<", { desc = "Shrink window" })
map("n", "<M-.>", "<C-w>5>", { desc = "Grow window" })

-- Keep the cursor centred when paging
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })

-- Copy path
map("n", "<leader>cfp", "<cmd>let @+ = expand('%:p')<CR>", { desc = "Copy absolute file path" })
map("n", "<leader>cp", '<cmd>let @+ = fnamemodify(expand("%"), ":~:.")<CR>', { desc = "Copy relative file path" })

-- Save
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })

-- Reindent the pasted region. Bound to ]p rather than p so a plain paste
-- keeps its own formatting and still honours a count.
map("n", "]p", "p`[v`]=", { desc = "Paste and reindent" })

-- `]q`/`[q`, `]d`/`[d`, `]b`/`[b` etc. ship with Neovim 0.11+ and already
-- handle counts and end-of-list, so they are deliberately not remapped here.

-- Insert --
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- Visual --
map("v", "<", "<gv", { desc = "Outdent and reselect" })
map("v", ">", ">gv", { desc = "Indent and reselect" })
map("v", "p", '"_dP', { desc = "Paste without yanking replaced text" })

-- Neovide
if vim.g.neovide == true then
	local function scale(delta)
		return function()
			vim.g.neovide_scale_factor = delta and (vim.g.neovide_scale_factor + delta) or 1
		end
	end

	map("n", "<C-+>", scale(0.1), { desc = "Neovide: zoom in" })
	map("n", "<C-->", scale(-0.1), { desc = "Neovide: zoom out" })
	map("n", "<C-0>", scale(nil), { desc = "Neovide: reset zoom" })
end
