return {
  {
    'nvim-mini/mini.files',
    version = '*',
    opts = {
      mappings = {
        go_in_plus = '<CR>',
        go_in = 'L',
        go_out = 'H'
      },
      options = {
        use_as_default_explorer = true
      }
    },
    keys = {
      {
        "-",
        function()
          local MiniFiles = require "mini.files"
          local buf_name = vim.api.nvim_buf_get_name(0)
          local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
          MiniFiles.open(path)
          MiniFiles.reveal_cwd()
        end,
        mode = { 'n' }
      },
    }
  },
}
