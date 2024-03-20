return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    'marilari88/neotest-vitest',
    'haydenmeade/neotest-jest',
    'nvim-neotest/neotest-plenary',
    "olimorris/neotest-rspec",
    "nvim-neotest/nvim-nio"
  },

  config = function()
    require("neotest").setup({
      ft = { "typescript", "javascript", 'typescriptreact', 'javascriptreact' },

      adapters = {
        require("neotest-plenary"),
        require('neotest-vitest'),
        require('neotest-jest')({
          jestCommand = "npm run test --",
          jestConfigFile = "jest.config.ts",
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        }),

        require("neotest-rspec")
      },
    })

    -- tests

    local keymap = vim.api.nvim_set_keymap

    keymap("n", "<leader>tc", '<cmd>lua require("neotest").run.run()<CR>', { noremap = true })
    keymap("n", "<leader>tl", '<cmd>lua require("neotest").run.run_last()<CR>', { noremap = true })
    keymap("n", "<leader>tf", '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', { noremap = true })
    keymap("n", "<leader>ts", '<cmd>lua require("neotest").summary.toggle()<CR>', { noremap = true })
    keymap("n", "<leader>to", '<cmd>lua require("neotest").output_panel.toggle()<CR>', { noremap = true })
    keymap("n", "<leader>toc", '<cmd>lua require("neotest").output_panel.clear()<CR>', { noremap = true })
  end
}
