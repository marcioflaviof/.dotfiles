local opts = { noremap = true, silent = true }


return {
  {
    'lewis6991/gitsigns.nvim',
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
    keys = {
      { "<leader>gl", "<cmd>lua require('gitsigns').blame_line()<CR>", mode = { 'n' } },
    }
  },

  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>gs", "<cmd>0G<CR>",          opts },
      { "<leader>gf", "<cmd>diffget //2<CR>", opts },
      { "<leader>gj", "<cmd>diffget //3<CR>", opts },
    }
  },
  { 'akinsho/git-conflict.nvim', version = "*", config = true },
  'Almo7aya/openingh.nvim'
}
