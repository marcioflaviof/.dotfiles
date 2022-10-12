M = {}
lvim.leader = "space"

local opts = { noremap = true, silent = true }
-- For the description on keymaps, I have a function getOptions(desc) which returns noremap=true, silent=true and desc=desc. Then call: keymap(mode, keymap, command, getOptions("some randome desc")

local keymap = vim.keymap.set

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

lvim.keys.insert_mode["jk"] = "<Esc>"
-- Keymaps

-- Normal --
-- Better window navigation
keymap("n", "<m-h>", "<C-w>h", opts)
keymap("n", "<m-j>", "<C-w>j", opts)
keymap("n", "<m-k>", "<C-w>k", opts)
keymap("n", "<m-l>", "<C-w>l", opts)
keymap("n", "<m-tab>", "<c-6>", opts)

keymap("n", "<C-s>", ":w<CR>", { noremap = true })

keymap("n", "<F5>", ":let @+ = expand('%:p')<CR>", opts)
keymap("n", "<F4>", ':let @+ = fnamemodify(expand("%"), ":~:.")<CR>', opts)

-- Naviagate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<leader>c", ":Bdelete<CR>", opts)

keymap("n", "<leader>h",
  ":lua require('harpoon.ui').toggle_quick_menu()<CR>"
  , opts)
keymap("n", "<leader>hm", ":lua require('harpoon.mark').add_file()<CR>", opts)

-- Harpoon
keymap("n", "<leader>h",
  ":lua require('harpoon.ui').toggle_quick_menu()<CR>"
  , opts)
keymap("n", "<leader>hm", ":lua require('harpoon.mark').add_file()<CR>", opts)

-- Insert --
keymap("i", "jk", "<ESC>", opts)

