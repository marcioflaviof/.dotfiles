return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      pcall(require("nvim-treesitter.install").update({ with_sync = true }))
    end,
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        ensure_installed = {
          "javascript",
          "typescript",
          "html",
          "css",
          "tsx",
          "org",
          "ruby",
          "lua",
          "embedded_template",
          "markdown",
        },
        sync_install = false,    -- install languages synchronously (only applied to `ensure_installed`)
        ignore_install = { "" }, -- List of parsers to ignore installing
        highlight = {
          enable = true,         -- false will disable the whole extension
          disable = { "org" },   -- list of language that will be disabled
          additional_vim_regex_highlighting = true,
          use_languagetree = true,
        },
        autopairs = {
          enable = true,
        },
        indent = {
          enable = false,
          disable = {
            "python",
            "css",
            "yaml",
            "ruby",
            "eruby"
          }
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            node_decremental = "<c-backspace>",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ic"] = "@class.inner",
              ["ac"] = "@class.outer",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = "@function.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
            }
          }

        },
        matchup = {
          enable = true,
          enable_quotes = true,
        },

      })
    end,
  },
  { "nvim-treesitter/playground", lazy = true },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      require('ts_context_commentstring').setup {
        enabled_autocmd = false,
        languages = {
          typescript = '// %s'
        }
      }
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        enable = true,
        max_lines = 3,
      })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = "nvim-treesitter/nvim-treesitter"
  },
}
