local RemoveComments = function()
  local ts         = vim.treesitter
  local bufnr      = vim.api.nvim_get_current_buf()
  local ft         = vim.bo[bufnr].filetype
  local lang       = ts.language.get_lang(ft) or ft

  local ok, parser = pcall(ts.get_parser, bufnr, lang)
  if not ok then return vim.notify("No parser for " .. ft, vim.log.levels.WARN) end

  local tree   = parser:parse()[1]
  local root   = tree:root()
  local query  = ts.query.parse(lang, "(comment) @comment")

  local ranges = {}
  for _, node in query:iter_captures(root, bufnr, 0, -1) do
    table.insert(ranges, { node:range() })
  end

  table.sort(ranges, function(a, b)
    if a[1] == b[1] then return a[2] < b[2] end
    return a[1] > b[1]
  end)

  for _, r in ipairs(ranges) do
    vim.api.nvim_buf_set_text(bufnr, r[1], r[2], r[3], r[4], {})
  end
end

vim.api.nvim_create_user_command("RemoveComments", RemoveComments, {})

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
          "ruby",
          "lua",
          "embedded_template",
          "markdown",
        },
        highlight = {
          enable = true,                    -- false will disable the whole extension
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            node_decremental = "<c-backspace>",
          },
        },
        matchup = {
          enable = true,
          enable_quotes = true,
        },

      })
    end,
  },
  {
    "folke/ts-comments.nvim",
    opts = { lang = { sql = '-- %s' } },
    event = "VeryLazy",
    enabled = true,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      enable = true,
      max_lines = 3,
    }
  },
}
