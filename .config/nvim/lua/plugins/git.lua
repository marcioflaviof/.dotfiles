return {
  {
    'lewis6991/gitsigns.nvim',
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      gh = true
    },
    keys = {
      { "<leader>gl", "<cmd>lua require('gitsigns').blame_line()<CR>",     mode = { 'n' } },
      { "]c",         "<cmd>lua require('gitsigns').nav_hunk('next')<CR>", mode = { 'n' } },
      { "[c",         "<cmd>lua require('gitsigns').nav_hunk('prev')<CR>", mode = { 'n' } },
    },
  },

  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git" },
    keys = {
      { "<leader>gs", "<cmd>0G<CR>", desc = "Fugitive status" },
    },
  },
  {
    'akinsho/git-conflict.nvim',
    version = "*",
    config = true,
  },
}
