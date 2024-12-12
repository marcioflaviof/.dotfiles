return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local builtin = require("telescope.builtin")
      local actions = require("telescope.actions")

      require('telescope').setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "truncate" },
          hidden = true,
          preview = {
            highlight_limit = 0.5, -- MB
          },
          file_ignore_patterns = {
            ".git/.*",
            "%.lock",
            'package-lock.json',
            "node%_modules/.*",
          },
          mappings = {
            n = {
              ["q"] = actions.close,
              ["<esc>"] = actions.close,
              ["dd"] = require("telescope.actions").delete_buffer,
            },
          },
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--glob=!.git/",
        },
        pickers = {
          lsp_references = {
            theme = "ivy",
            layout_config = {
              horizontal = {
                prompt_position = "top",
                results_width = 0.8,
              },
              height = 0.7,
            },
            path_display = { 'truncate' },
            file_ignore_patterns = { ".test", ".spec", "node%_modules/.*", },
            initial_mode = "normal",
            show_line = false
          },
          find_files = {
            theme = "ivy",
            hidden = true,
            previewer = false,
            layout_config = {
              horizontal = {
                prompt_position = "top",
                results_width = 0.8,
              },
              height = 0.7,
            },
          },
          quickfix = {
            theme = "ivy",
            layout_config = {
              horizontal = {
                prompt_position = "top",
                results_width = 0.8,
              },
              height = 0.7,
            },
            initial_mode = "normal",
          },
          resume = {
            initial_mode = "normal",
          },
        },
        extensions = {
          fzf = {},
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })

      local opts = { noremap = true, silent = true }
      local keymap = vim.keymap.set


      keymap("n", "<leader>f", builtin.find_files, opts)
      keymap("n", "<leader>so", builtin.oldfiles, opts)
      keymap("n", "<leader>gb", builtin.git_branches, opts)
      keymap("n", "<leader>slr", builtin.lsp_references, opts)
      keymap("n", "<leader>sq", builtin.quickfix, opts)
      keymap("n", "<leader>sr", "<cmd>lua require('telescope.builtin').resume()<cr>", opts)
      keymap("n", "<leader>sw", builtin.grep_string, opts)
      keymap("n", "<leader>sb", builtin.buffers, opts)
      keymap("n", "<leader>sm", builtin.marks, opts)
      keymap("n", "<leader>sh", builtin.help_tags, opts)


      require('custom/telescope/multigrep').setup()
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("ui-select")

      local colors = require("catppuccin.palettes").get_palette()
      local TelescopeColor = {
        TelescopeMatching = { fg = colors.flamingo },
        TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },

        TelescopePromptPrefix = { bg = colors.surface0 },
        TelescopePromptNormal = { bg = colors.surface0 },
        TelescopeResultsNormal = { bg = colors.mantle },
        TelescopePreviewNormal = { bg = colors.mantle },
        TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
        TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
        TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
        TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
        TelescopeResultsTitle = { fg = colors.mantle },
        TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
      }

      for hl, col in pairs(TelescopeColor) do
        vim.api.nvim_set_hl(0, hl, col)
      end
    end
  },

  "nvim-telescope/telescope-ui-select.nvim",
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

}
