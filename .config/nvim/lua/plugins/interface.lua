vim.g.navic_silence = true

return {
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons"
    },
    opts = {
      theme = "tokyonight"
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = {}
  },
  "nvim-tree/nvim-web-devicons",
}
