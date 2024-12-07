return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = false },
    statuscolumn = { enabled = false },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    quickfile = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        wo = { wrap = true } -- Wrap notifications
      }
    },
    terminal = {
      win = { style = "float" }
    }
  },
  keys = {
    { "<leader>bd",  function() Snacks.bufdelete() end,               desc = "Delete Buffer" },
    { "<leader>gl",  function() Snacks.git.blame_line() end,          desc = "Git Blame Line" },
    { "<c-/>",       function() Snacks.terminal() end,                desc = "Toggle Terminal", mode = { "n", "i" } },
    { "<c-_>",       function() Snacks.terminal() end,                desc = "which_key_ignore" },
    { "]]",          function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",  mode = { "n", "t" } },
    { "[[",          function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference",  mode = { "n", "t" } },
  },
}
