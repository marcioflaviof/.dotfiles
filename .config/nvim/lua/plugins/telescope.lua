return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
      'nvim-lua/plenary.nvim',
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    config = function()
      local builtin = require("telescope.builtin")
      local lga_actions = require("telescope-live-grep-args.actions")
      local actions = require("telescope.actions")

      require('telescope').setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "truncate" },
          hidden = true,
          preview = {
            highlight_limit = 1, -- MB
          },
          file_ignore_patterns = {
            "bundle/.*",
            'coverage/.*',
            ".git/.*",
            ".next/.*",
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
        pickers = {
          grep_string = {
            theme = "ivy",
            layout_config = {
              horizontal = {
                prompt_position = "top",
                results_width = 0.8,
              },
              height = 0.7,
            },
            initial_mode = "normal",
            file_ignore_patterns = { ".test", ".spec" },
          },
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
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
          },
          live_grep_args = {
            theme = "ivy",
            auto_quoting = true,
            layout_config = {
              horizontal = {
                prompt_position = "top",
                results_width = 0.8,
              },
              height = 0.7,
            },
            mappings = {
              i = {
                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                ["<C-t>"] = lga_actions.quote_prompt({ postfix = " --iglob !**tests**" }),
              },
            }
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })

      local opts = { noremap = true, silent = true }
      local keymap = vim.keymap.set

      keymap("n", "<leader>sg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", opts)

      keymap("n", "<leader>f", builtin.find_files, opts)
      keymap("n", "<leader>so", builtin.oldfiles, opts)
      keymap("n", "<leader>gb", builtin.git_branches, opts)
      keymap("n", "<leader>slr", builtin.lsp_references, opts)
      keymap("n", "<leader>sq", builtin.quickfix, opts)
      keymap("n", "<leader>sr", "<cmd>lua require('telescope.builtin').resume()<cr>", opts)
      keymap("n", "<leader>sw", builtin.grep_string, opts)
      keymap("n", "<leader>sb", builtin.buffers, opts)

      require("telescope").load_extension("live_grep_args")
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("ui-select")
    end
  },

  "nvim-telescope/telescope-ui-select.nvim",
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

}
