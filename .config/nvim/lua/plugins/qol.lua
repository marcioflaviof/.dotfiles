function _G.set_terminal_keymaps()
  local opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
end
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      scroll = { enabled = true },
      indent = { enabled = true, animate = { enabled = false } },
      dashboard = { enabled = false },
      statuscolumn = { enabled = false },
      notifier = {
        enabled = false,
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
      },
    },
    keys = {
      { "<leader>bd", function() Snacks.bufdelete() end,               desc = "Delete Buffer" },
      { "<leader>gl", function() Snacks.git.blame_line() end,          desc = "Git Blame Line" },
      { "<c-\\>",     function() Snacks.terminal() end,                desc = "Toggle Terminal", mode = { "n", "i", "t" } },
      { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",  mode = { "n", "t" } },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference",  mode = { "n", "t" } },
    },
  }
}
