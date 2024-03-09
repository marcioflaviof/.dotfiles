return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    'marilari88/neotest-vitest',
    'haydenmeade/neotest-jest',
    'nvim-neotest/neotest-plenary',
    "olimorris/neotest-rspec",
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
  end
}
