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
        styles = {
          -- sidebars = "transparent",
          -- floats = "transparent",
        },
        on_highlights = function(hl, colors)
          hl["@tag.builtin.tsx"] = {
            fg = colors.red,
          }
          hl["@tag.builtin.javascript"] = {
            fg = colors.red,
          }
          hl["CmpItemKindVariable"] = {
            fg = colors.magenta,
            bg = colors.none
          }
        end,
      })
    end
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        -- transparent_background = true,
        styles = {
          comments = { "italic" },
          keywords = { "italic" },
          types = { "bold" },
        }
      })
    end
  },
}
