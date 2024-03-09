return {
  {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup({
        filetypes = { "scss", "css", "lua", "typescriptreact", "typescript", "ruby", "javascript", 'svelte' },
        user_default_options = {
          tailwind = true,
          rgb_fn   = true, -- CSS rgb() and rgba() functions
          hsl_fn   = true, -- CSS hsl() and hsla() functions
          names    = false,
          css      = true,
          -- virtualtext = "■",
          mode     = "background", -- virtualtext | background
        },
      })
    end
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({

        transparent = false,
        style = "night",
        -- styles = {
        --   sidebars = "transparent",
        --   floats = "transparent",
        -- },
        on_highlights = function(hl, colors)
          hl.CursorLineNr = {
            fg = colors.orange,
            bold = true,
          }
          hl.LineNr = {
            fg = colors.blue0,
          }
          hl["@constructor.tsx"] = {
            fg = colors.red,
          }
        end,
      })

      vim.cmd("colorscheme tokyonight")
    end
  },
  {
    "EdenEast/nightfox.nvim",
    config = function()
      require("nightfox").setup({
        options = {
          transparent = false,

          styles = {
            comments = "italic",
            keywords = "italic",
            types = "bold",
          }
        }
      })
    end
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        transparent_background = false,
        styles = {
          comments = { "italic" },
          keywords = { "italic" },
          types = { "bold" },
        }
      })
    end
  },

  "kchmck/vim-coffee-script",
}
