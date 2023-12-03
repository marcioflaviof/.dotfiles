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
