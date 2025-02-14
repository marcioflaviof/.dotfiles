return {
  {
    'catgoose/nvim-colorizer.lua',
    event = "BufReadPre",
    opts = {
      RRGGBBAA = true, -- #RRGGBBAA hex codes
      AARRGGBB = true, -- 0xAARRGGBB hex codes
      rgb_fn = true,   -- CSS rgb() and rgba() functions
      hsl_fn = true,   -- CSS hsl() and hsla() functions
      tailwind = true
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({

        style = "night",
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
        end,
      })
    end
  },
}
