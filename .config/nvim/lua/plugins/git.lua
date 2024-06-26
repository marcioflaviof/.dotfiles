local opts = { noremap = true, silent = true }


return {
  {
    "f-person/git-blame.nvim",
    config = function()
      require("gitblame").setup({
        enabled = false
      })

      vim.g.gitblame_date_format = "%r"
      vim.g.gitblame_message_template = "<summary> • <date> • <author>"
      vim.g.gitblame_highlight_group = "LineNr"
    end

  },

  {
    'lewis6991/gitsigns.nvim',
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      }
    },
  },

  {
    "tpope/vim-fugitive",
    dependencies = 'tpope/vim-rhubarb',
    keys = {
      { "<leader>gs", "<cmd>0G<CR>",          opts },
      { "<leader>gf", "<cmd>diffget //2<CR>", opts },
      { "<leader>gj", "<cmd>diffget //3<CR>", opts },
    }
  },
  'tpope/vim-rhubarb',
}
