-- MATCHUP

vim.g.matchup_enabled = 1
-- vim.g.matchup_matchparen_enabled = 0
vim.g.matchup_surround_enabled = 1


return {
  { "andymass/vim-matchup", lazy = false, },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = 'kevinhwang91/promise-async',
    config = function()
      vim.o.foldcolumn = "0" -- '0' is not bad
      vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = -1
      vim.o.foldenable = true
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

      require("ufo").setup {
        -- close_fold_kinds_for_ft = { default = { "imports" } },
        provider_selector = function(_, ft, _)
          local lspWithOutFolding = { "markdown", "zsh", "css", "html", "python", "json" }
          if vim.tbl_contains(lspWithOutFolding, ft) then return { "treesitter", "indent" } end
          return { "lsp", "indent" }
        end,
      }
    end
  },
  {
    "windwp/nvim-ts-autotag",
    opts = {}
  },
  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure({})
    end
  },
  "junegunn/vim-slash",
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
  },
  {
    'echasnovski/mini.ai',
    version = '*',
    opts = {
      n_lines = 300
    }

  },
  {
    'echasnovski/mini.surround',
    version = '*',
    opts = {
      n_lines = 300,
      search_method = 'cover_or_next'
    }
  },
  {
    'echasnovski/mini.pairs',
    version = '*',
    opts = {
      modes = { insert = true, command = false, terminal = false },
    },
  },
  {
    'echasnovski/mini.operators',
    version = '*',
    opts = {}
  },
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    'stevearc/quicker.nvim',
    event = "FileType qf",
    opts = {},
  },
  'kchmck/vim-coffee-script',
  {
    "sphamba/smear-cursor.nvim",
    opts = {},
  }
}
