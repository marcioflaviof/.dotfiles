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
      indent = { enabled = true, animate = { enabled = false } },
      picker = {
        enabled = true,
        layouts = {
          default = {
            layout = {
              box = "vertical",
              backdrop = false,
              row = -1,
              width = 0,
              height = 0.7,
              border = "top",
              title = " {title} {live} {flags}",
              title_pos = "left",
              { win = "input", height = 1, border = "bottom" },
              {
                box = "horizontal",
                { win = "list",    border = "none" },
                { win = "preview", title = "{preview}", width = 0.6, border = "left" },
              },
            }
          }
        }
      },
      quickfile = { enabled = true },
      terminal = {
        win = { style = "float" }
      },
    },
    keys = {
      { "<leader>bd", function() Snacks.bufdelete() end,               desc = "Delete Buffer" },
      { "<leader>gl", function() Snacks.git.blame_line() end,          desc = "Git Blame Line" },
      { "<c-\\>",     function() Snacks.terminal() end,                desc = "Toggle Terminal",          mode = { "n", "i", "t" } },
      { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",           mode = { "n", "t" } },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference",           mode = { "n", "t" } },

      -- picker
      { "<leader>f",  function() Snacks.picker.files() end,            desc = "Find Files" },
      { "<leader>sh", function() Snacks.picker.help() end,             desc = "Help Pages" },
      { "<leader>sg", function() Snacks.picker.grep() end,             desc = "Grep" },
      { "<leader>sw", function() Snacks.picker.grep_word() end,        desc = "Visual selection or word", mode = { "n", "x" } },
      { "<leader>sr", function() Snacks.picker.resume() end,           desc = "Resume" },
      { "<leader>sH", function() Snacks.picker.command_history() end,  desc = "Command History" },
      { "<leader>sq", function() Snacks.picker.qflist() end,           desc = "Quickfix List" },
      { "<leader>so", function() Snacks.picker.recent() end,           desc = "Recent" },
      { "<leader>ss", function() Snacks.picker.lsp_symbols() end,      desc = "LSP Symbols" },
      { "<leader>sk", function() Snacks.picker.keymaps() end,          desc = "Keymaps" },

    },
  }
}
