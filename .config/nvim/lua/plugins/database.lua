return {
  {
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      require("dbee").install()
    end,
    opts = {}
  },
  {
    {
      "MattiasMTS/cmp-dbee",
      dependencies = {
        { "kndndrj/nvim-dbee" }
      },
      ft = "sql", -- optional but good to have
      opts = {},  -- needed
    },
  },
}
