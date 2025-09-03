return {
  {
    "mistweaverco/kulala.nvim",
    -- keys = {
    --     { "<leader>rs", desc = "Send request" },
    --     { "<leader>ra", desc = "Send all requests" },
    --   },
    ft = { "http", "rest" },
    opts = {
      -- your configuration comes here
      global_keymaps = {
        ["Send request"] = { -- sets global mapping
          "<leader>rs",
          function() require("kulala").run() end,
          mode = { "n", "v" },  -- optional mode, default is n
          desc = "Send request" -- optional description, otherwise inferred from the key
        },
        ["Send all requests"] = {
          "<leader>ra",
          function() require("kulala").run_all() end,
          mode = { "n", "v" },
          ft = "http", -- sets mapping for *.http files only
        },
        ["Replay the last request"] = {
          "<leader>rr",
          function() require("kulala").replay() end,
          ft = { "http", "rest" }, -- sets mapping for specified file types
        },
        ["Paste from cURL"] = {
          "<leader>rC",
          mode = { "n" },
          function() require("kulala").from_curl() end,
          ft = { "http", "rest" }, -- sets mapping for specified file types
        },
        ["Copy as cURL"] = {
          "<leader>rc",
          mode = { "v" },
          function() require("kulala").copy() end,
          ft = { "http", "rest" }, -- sets mapping for specified file types
        },
      },
    },
  }
}
