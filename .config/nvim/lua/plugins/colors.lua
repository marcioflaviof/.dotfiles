return {
  {
    'catgoose/nvim-colorizer.lua',
    event = "BufReadPre",
    opts = {
      RRGGBBAA = true, -- #RRGGBBAA hex codes
      AARRGGBB = true, -- 0xAARRGGBB hex codes
      rgb_fn = true,   -- CSS rgb() and rgba() functions
      hsl_fn = true,   -- CSS hsl() and hsla() functions
      tailwind = true,
      user_default_options = {
        names = false,
      }
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      on_colors = function(colors)
        colors.comment = "#6272a4"
      end,
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
        hl["SnacksIndentScope"] = {
          fg = colors.purple
        }
        hl["LineNrAbove"] = {
          fg = colors.comment
        }
        hl["LineNrBelow"] = {
          fg = colors.comment
        }
      end,
    }
  },
}
