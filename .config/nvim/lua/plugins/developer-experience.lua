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
      require("illuminate").configure({})
    end
  },
  "junegunn/vim-slash",
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
  },
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
    opts = {
      -- In which modes mappings from this `config` should be created
      modes = { insert = true, command = false, terminal = false },

      -- Global mappings. Each right hand side should be a pair information, a
      -- table with at least these fields (see more in |MiniPairs.map|):
      -- - <action> - one of 'open', 'close', 'closeopen'.
      -- - <pair> - two character string for pair to be used.
      -- By default pair is not inserted after `\`, quotes are not recognized by
      -- `<CR>`, `'` does not insert pair after a letter.
      -- Only parts of tables can be tweaked (others will use these defaults).
      mappings = {
        [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
        ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
        ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },
        ["["] = {
          action = "open",
          pair = "[]",
          neigh_pattern = ".[%s%z%)}%]]",
          register = { cr = false },
          -- foo|bar -> press "[" -> foo[bar
          -- foobar| -> press "[" -> foobar[]
          -- |foobar -> press "[" -> [foobar
          -- | foobar -> press "[" -> [] foobar
          -- foobar | -> press "[" -> foobar []
          -- {|} -> press "[" -> {[]}
          -- (|) -> press "[" -> ([])
          -- [|] -> press "[" -> [[]]
        },
        ["{"] = {
          action = "open",
          pair = "{}",
          -- neigh_pattern = ".[%s%z%)}]",
          neigh_pattern = ".[%s%z%)}%]]",
          register = { cr = false },
          -- foo|bar -> press "{" -> foo{bar
          -- foobar| -> press "{" -> foobar{}
          -- |foobar -> press "{" -> {foobar
          -- | foobar -> press "{" -> {} foobar
          -- foobar | -> press "{" -> foobar {}
          -- (|) -> press "{" -> ({})
          -- {|} -> press "{" -> {{}}
        },
        ["("] = {
          action = "open",
          pair = "()",
          -- neigh_pattern = ".[%s%z]",
          neigh_pattern = ".[%s%z%)]",
          register = { cr = false },
          -- foo|bar -> press "(" -> foo(bar
          -- foobar| -> press "(" -> foobar()
          -- |foobar -> press "(" -> (foobar
          -- | foobar -> press "(" -> () foobar
          -- foobar | -> press "(" -> foobar ()
        },
        -- Single quote: Prevent pairing if either side is a letter
        ['"'] = {
          action = "closeopen",
          pair = '""',
          neigh_pattern = "[^%w\\][^%w]",
          register = { cr = false },
        },
        -- Single quote: Prevent pairing if either side is a letter
        ["'"] = {
          action = "closeopen",
          pair = "''",
          neigh_pattern = "[^%w\\][^%w]",
          register = { cr = false },
        },
        -- Backtick: Prevent pairing if either side is a letter
        ["`"] = {
          action = "closeopen",
          pair = "``",
          neigh_pattern = "[^%w\\][^%w]",
          register = { cr = false },
        },
      },
    },
  },
  {
    'echasnovski/mini.operators',
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
