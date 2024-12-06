-- MATCHUP

vim.g.matchup_enabled = 1
-- vim.g.matchup_matchparen_enabled = 0
vim.g.matchup_surround_enabled = 1

-- UFO

vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

return {
  { "andymass/vim-matchup", lazy = false, },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('ibl').setup({
        scope = {
          enabled = true,
          show_start = false,
          show_end = false,
          highlight = { "Function" },
          include = {
            node_type = {
              ["*"] = { "*" }
            }
          }

        },
        indent = {
          char = "▏",
        },
        exclude = {
          filetypes = {
            "help",
            "dashboard",
            "neogitstatus",
            "NvimTree",
            "Trouble"
          }
        }
      })
    end
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = 'kevinhwang91/promise-async',
    config = function()
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (' 󰁂 %d '):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, 'MoreMsg' })
        return newVirtText
      end

      require("ufo").setup({
        fold_virt_text_handler = handler,
        close_fold_kinds_for_ft = {
          default = { "imports", "comment" }
        },
        provider_selector = function()
          return { "treesitter", "indent" }
        end,
      })

      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
    end
  },
  {
    "windwp/nvim-ts-autotag",
    opts = {}
  },
  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure({
        filetypes_denylist = {
          'dirbuf',
          'dirvish',
          'fugitive',
          'toggleterm',
          'oil'
        }
      })
    end
  },
  "junegunn/vim-slash",
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
  },
  "moll/vim-bbye", -- better buffer close
  {
    'echasnovski/mini.ai',
    version = '*',
    opts = {}

  },
  {
    'echasnovski/mini.surround',
    version = '*',
    opts = {
      n_lines = 60,
      search_method = 'cover_or_next'
    }
  },
  {
    'echasnovski/mini.pairs',
    version = '*',
    opts = {}
  },
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    'stevearc/quicker.nvim',
    event = "FileType qf",
    opts = {},
  }
}
