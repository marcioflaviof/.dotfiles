local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --

--  format
keymap("n", "<leader>lf", "<cmd>LspToggleAutoFormat<cr>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Better navigation with ctrl d and ctrl u
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Replace the word below the pointer
keymap("n", "<leader>r", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", opts)

-- Open buff in ruby
keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

-- Naviagate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<leader>c", ":Bdelete<CR>", opts)

-- Copy path
keymap("n", "<F5>", ":let @+ = expand('%:p')<CR>", opts)
keymap("n", "<F4>", ':let @+ = fnamemodify(expand("%"), ":~:.")<CR>', opts)

-- Git
keymap("n", "<leader>gl", "<cmd>GitBlameToggle<CR>", opts)
keymap("n", "<leader>gll", "<cmd>Gitsigns blame_line<CR>", opts)
keymap("n", "<leader>gs", "<cmd>0G<CR>", opts) -- vim fugitive
keymap("n", "<leader>gd", "<cmd>G diff<CR>", opts) -- vim fugitive
keymap("n", "<leader>gf", "<cmd>diffget //2<CR>", opts) -- vim fugitive
keymap("n", "<leader>gj", "<cmd>diffget //3<CR>", opts) -- vim fugitive

-- Tests
keymap("n", "<leader>tf", "<cmd>w<CR><cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", opts) -- test file
keymap(
  "n",
  "<leader>to",
  "<cmd>lua require('neotest').output.open({ open_win = function() vim.cmd('vsplit') end })<CR>",
  opts
) -- open output
keymap("n", "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<CR>", opts) -- open summary
keymap("n", "<leader>ta", "<cmd>lua require('neotest').run.run(vim.fn.getcwd())<CR>", opts) -- test all

-- save with ctrl + s
keymap("n", "<C-s>", ":w<CR>", { noremap = true })

-- Open file tree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- lsp-ts-utils
keymap("n", "<leader>li", ":TypescriptAddMissingImports<CR>", opts)

-- Harpoon
keymap("n", "<leader>h",
  ":lua require('harpoon.ui').toggle_quick_menu()<CR>"
  , opts)
keymap("n", "<leader>hm", ":lua require('harpoon.mark').add_file()<CR>", opts)
keymap("n", "<leader>hn", ":lua require('harpoon.ui').nav_next()<CR>", opts)
keymap("n", "<leader>hp", ":lua require('harpoon.ui').nav_prev()<CR>", opts)
keymap("n", "<leader>1", ":lua require('harpoon.ui').nav_file(1)<CR>", opts)
keymap("n", "<leader>2", ":lua require('harpoon.ui').nav_file(2)<CR>", opts)
keymap("n", "<leader>3", ":lua require('harpoon.ui').nav_file(3)<CR>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<Esc>", "<C-\\><C-n>", opts)
