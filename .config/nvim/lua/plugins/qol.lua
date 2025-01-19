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
      picker = {
        enabled = true,
        layout = {
          preview = "main",
          preset = "ivy",
        },
      },
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
      { "<c-\\>",     function() Snacks.terminal() end,                desc = "Toggle Terminal",          mode = { "n", "i", "t" } },
      { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",           mode = { "n", "t" } },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference",           mode = { "n", "t" } },

      -- picker
      { "<leader>f",  function() Snacks.picker.files() end,            desc = "Find Files" },
      { "<leader>sh", function() Snacks.picker.help() end,             desc = "Help Pages" },
      { "<leader>sg", function() Snacks.picker.grep() end,             desc = "Grep" },
      { "<leader>sw", function() Snacks.picker.grep_word() end,        desc = "Visual selection or word", mode = { "n", "x" } },
      { "<leader>sH", function() Snacks.picker.command_history() end,  desc = "Command History" },
      { "<leader>sq", function() Snacks.picker.qflist() end,           desc = "Quickfix List" },
      { "<leader>so", function() Snacks.picker.recent() end,           desc = "Recent" },
      { "<leader>ss", function() Snacks.picker.lsp_symbols() end,      desc = "LSP Symbols" },
      { "<leader>sk", function() Snacks.picker.keymaps() end,          desc = "Keymaps" },


      -- keymap("n", "<leader>f", builtin.find_files, opts)
      -- keymap("n", "<leader>so", builtin.oldfiles, opts)
      -- keymap("n", "<leader>gb", builtin.git_branches, opts)
      -- keymap("n", "<leader>slr", builtin.lsp_references, opts)
      -- keymap("n", "<leader>sq", builtin.quickfix, opts)
      -- keymap("n", "<leader>sr", "<cmd>lua require('telescope.builtin').resume()<cr>", opts)
      -- keymap("n", "<leader>sw", builtin.grep_string, opts)
      -- keymap("n", "<leader>sb", builtin.buffers, opts)
      -- keymap("n", "<leader>sm", builtin.marks, opts)
      -- keymap("n", "<leader>sh", builtin.help_tags, opts)

    },
  }
}
