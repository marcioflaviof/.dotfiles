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

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- split resize
keymap("n", "≤", "<c-w>5<", opts)
keymap("n", "≥", "<c-w>5>", opts)

-- Better navigation with ctrl d and ctrl u
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)


-- Naviagate buffers
keymap("n", "<leader>c", ":Bdelete<CR>", opts)

-- Copy path
keymap("n", "<leader>cfp", "<cmd>let @+ = expand('%:p')<CR>", opts)
keymap("n", "<leader>cp", '<cmd>let @+ = fnamemodify(expand("%"), ":~:.")<CR>', opts)



-- Git
keymap("n", "<leader>gl", "<cmd>GitBlameToggle<CR>", opts)
keymap("n", "<leader>gll", "<cmd>Gitsigns blame_line<CR>", opts)
keymap("n", "<leader>gs", "<cmd>0G<CR>", opts)          -- vim fugitive
keymap("n", "<leader>gf", "<cmd>diffget //2<CR>", opts) -- vim fugitive
keymap("n", "<leader>gj", "<cmd>diffget //3<CR>", opts) -- vim fugitive

-- save with ctrl + s
keymap("n", "<C-s>", ":w<CR>", { noremap = true })


-- lsp-ts-utils
keymap("n", "<leader>lu", "<cmd>TSToolsRemoveUnusedImports<CR>", opts)
keymap("n", "<leader>li", "<cmd>TSToolsAddMissingImports<CR>", opts)

-- Undotree
keymap("n", "<leader>u", "<cmd>UndotreeToggle<cr>", opts)

-- quickfix list
keymap("n", "<leader>qn", ":cn<CR>", opts)
keymap("n", "<leader>qp", ":cp<CR>", opts)

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

-- Neovide
--
if vim.g.neovide == true then
  vim.api.nvim_set_keymap(
    "n",
    "<C-+>",
    ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>",
    { silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<C-->",
    ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>",
    { silent = true }
  )
  vim.api.nvim_set_keymap("n", "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>", { silent = true })
end
