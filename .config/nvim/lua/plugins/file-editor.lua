return {
  {
    'echasnovski/mini.files',
    version = '*',
    opts = {
      mappings = {
        go_in_plus = '<CR>',
        go_in = 'L',
        go_out = 'H'
      },
      use_as_default_explorer = true
    },
    keys = {
      {
        "-",
        function()
          local MiniFiles = require "mini.files"
          local buf_name = vim.api.nvim_buf_get_name(0)
          local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
          MiniFiles.open(path)
          MiniFiles.reveal_cwd()
        end,
        mode = { 'n' }
      },
    }
  },
  -- {
  --   'stevearc/oil.nvim',
  --   config = function()
  --     require("plugins.file-editor").setup({
  --       default_file_explorer = true,
  --       keymaps = {
  --         ["g?"] = "actions.show_help",
  --         ["<CR>"] = "actions.select",
  --         ["<C-v>"] = "actions.select_vsplit",
  --         ["<C-h>"] = "actions.select_split",
  --         ["<C-t>"] = "actions.select_tab",
  --         ["<C-p>"] = "actions.preview",
  --         ["<C-c>"] = "actions.close",
  --         ["<C-l>"] = "actions.refresh",
  --         ["-"] = "actions.parent",
  --         ["_"] = "actions.open_cwd",
  --         ["`"] = "actions.cd",
  --         ["~"] = "actions.tcd",
  --         ["gs"] = "actions.change_sort",
  --         ["g."] = "actions.toggle_hidden",
  --         ["g\\"] = "actions.toggle_trash",
  --
  --         lsp_file_methods = {
  --           enabled = true,
  --           timeout_ms = 1000,
  --           autosave_changes = true,
  --         }
  --       },
  --
  --       use_default_keymaps = false
  --     })
  --
  --     vim.keymap.set("n", "-", "<CMD>Oil --float<CR>")
  --   end,
  -- },
}
