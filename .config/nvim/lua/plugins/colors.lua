return {
  {
    "echasnovski/mini.hipatterns",
    recommended = true,
    desc = "Highlight colors in your code. Also includes Tailwind CSS support.",
    config = function()
      local hipatterns = require('mini.hipatterns')

      hipatterns.setup({
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end,
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
          hl["SnacksIndentScope"] = {
            fg = colors.purple
          }
        end,
      })
    end
  },
}
