return {
  {
    -- Autocompletion
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',

    -- use a release tag to download pre-built binaries
    version = '*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        per_filetype = {
          sql = { 'snippets', 'dadbod', 'buffer' },
        },
        providers = {
          lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
          dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        }
      },

      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
        menu = {
          draw = {
            columns = { { 'item_idx' }, { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },

            -- look like cmp
            -- columns = {
            --   { "item_idx", "label", "label_description", gap = 1 }, { "kind" }
            -- },
            components = {
              item_idx = {
                text = function(ctx) return ctx.idx == 10 and '0' or ctx.idx >= 10 and ' ' or tostring(ctx.idx) end,
                highlight = 'BlinkCmpItemIdx' -- optional, only if you want to change its color
              }
            }

          }
        }
      },

      keymap = {
        preset = 'default',
        ['<C-l>'] = { 'snippet_forward', 'fallback' },
        ['<C-h>'] = { 'snippet_backward', 'fallback' },
        ['<C-1>'] = { function(cmp) cmp.accept({ index = 1 }) end },
        ['<C-2>'] = { function(cmp) cmp.accept({ index = 2 }) end },
        ['<C-3>'] = { function(cmp) cmp.accept({ index = 3 }) end },
        ['<C-4>'] = { function(cmp) cmp.accept({ index = 4 }) end },
        ['<C-5>'] = { function(cmp) cmp.accept({ index = 5 }) end },
        ['<C-6>'] = { function(cmp) cmp.accept({ index = 6 }) end },
        ['<C-7>'] = { function(cmp) cmp.accept({ index = 7 }) end },
        ['<C-8>'] = { function(cmp) cmp.accept({ index = 8 }) end },
        ['<C-9>'] = { function(cmp) cmp.accept({ index = 9 }) end },
        ['<C-0>'] = { function(cmp) cmp.accept({ index = 10 }) end },
      }
    },
    opts_extend = { "sources.default" }
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
      floating_window = false,
      hint_scheme = "Comment",
      hint_prefix = " ",
    },
  },
}
