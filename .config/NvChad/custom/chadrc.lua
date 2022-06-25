local M = {}

local override = require "custom.override"

M.plugins = {

  options = {
    lspconfig = {
      setup_lspconf = "custom.plugins.lspconfig",
    },

    statusline = {
      separator_style = "round",
    },
  },

  override = {
    ["nvim-treesitter/nvim-treesitter"] = override.treesitter,
    ["kyazdani42/nvim-tree.lua"] = override.nvimtree,
  },

  user = require "custom.plugins",

  remove = {
    "folke/which-key.nvim",
  },
}

M.ui = {
  theme = "tokyonight",
}

M.mappings = require "custom.mappings"

return M
