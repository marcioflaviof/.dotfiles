return {
  {
    'stevearc/oil.nvim',
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-v>"] = "actions.select_vsplit",
          ["<C-h>"] = "actions.select_split",
          ["<C-t>"] = "actions.select_tab",
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-l>"] = "actions.refresh",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["gs"] = "actions.change_sort",
          ["g."] = "actions.toggle_hidden",
          ["g\\"] = "actions.toggle_trash",

          lsp_file_methods = {
            enabled = true,
            timeout_ms = 1000,
            autosave_changes = true,
          }
        },

        use_default_keymaps = false
      })

      vim.keymap.set("n", "-", "<CMD>Oil --float<CR>")
    end,
  },
}
