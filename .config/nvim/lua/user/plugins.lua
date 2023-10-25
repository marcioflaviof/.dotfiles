local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

-- Install your plugins here
return lazy.setup({
  -- My plugins here
  "nvim-lua/plenary.nvim", -- Useful lua functions used by lots of plugins

  -- User interface
  "RRethy/vim-illuminate",
  "nvim-tree/nvim-tree.lua",
  "freddiehaddad/feline.nvim",
  "moll/vim-bbye", -- better buffer close

  -- Colorschemes
  { "folke/tokyonight.nvim",     lazy = false,   priority = 1000, },

  -- Colors
  "NvChad/nvim-colorizer.lua",

  -- cmp plugins
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- snippets
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",

      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
    },
  },

  -- LSP
  { "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require 'lsp_signature'.setup({
        floating_window = false,
        hint_scheme = "Comment",
        hint_prefix = " ",
      })
    end
  },
  -- LSP Support
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
    },
  },
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "pmizio/typescript-tools.nvim",
  "nvimtools/none-ls.nvim",

  -- shows vars as I navigate
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-telescope/telescope-live-grep-args.nvim" },
  },
  "nvim-telescope/telescope-ui-select.nvim",
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      pcall(require("nvim-treesitter.install").update({ with_sync = true }))
    end,
  },
  { "nvim-treesitter/playground",               lazy = true },
  "JoosepAlviste/nvim-ts-context-commentstring",
  "nvim-treesitter/nvim-treesitter-context",
  { "nvim-treesitter/nvim-treesitter-textobjects", dependencies = "nvim-treesitter/nvim-treesitter" },
  "kchmck/vim-coffee-script",

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
  },
  "f-person/git-blame.nvim",
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",

  -- Utils
  "windwp/nvim-ts-autotag",
  "windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
  { "mbbill/undotree",                             cmd = "UndotreeToggle" },
  "numToStr/Comment.nvim",
  "lukas-reineke/indent-blankline.nvim",
  { "andymass/vim-matchup",    lazy = false, }, -- improve the % key
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  "junegunn/vim-slash",
  "ThePrimeagen/harpoon",
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          -- default options: exact mode, multi window, all directions, with a backdrop
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    },
    config = function()
      require("flash").setup({
        labels = "ASDFGHJKLQWERTYUIOPZXCVBNM",
      })
    end,
  },
  { "akinsho/toggleterm.nvim", version = "*",                              config = true },
  { "kevinhwang91/nvim-ufo",   dependencies = "kevinhwang91/promise-async" },

  -- AI
  {
    "Exafunction/codeium.vim",
    config = function()
      vim.keymap.set("i", "<C-a>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true })
    end,
  },

  -- Tests
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      'marilari88/neotest-vitest',
      'haydenmeade/neotest-jest',
      'nvim-neotest/neotest-plenary'
    },
  },
})
