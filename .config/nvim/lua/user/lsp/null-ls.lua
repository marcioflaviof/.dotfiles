local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end


-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local conditional = function(fn)
  local utils = require("null-ls.utils").make_conditional_utils()
  return fn(utils)
end

-- https://github.com/prettier-solidity/prettier-plugin-solidity
-- npm install --save-dev prettier prettier-plugin-solidity
null_ls.setup({
  debug = false,
  sources = {
    -- formatting.prettier,
    formatting.prettierd,
    diagnostics.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file({ '.eslintrc.js' })
      end
    }),

    conditional(function(utils)
      return utils.root_has_file("Gemfile")
          and null_ls.builtins.formatting.rubocop.with({
            command = "bundle",
            args = vim.list_extend(
              { "exec", "rubocop", "-a" },
              null_ls.builtins.formatting.rubocop._opts.args
            ),
          })
          or null_ls.builtins.formatting.rubocop
    end),

    conditional(function(utils)
      return utils.root_has_file("Gemfile")
          and null_ls.builtins.diagnostics.rubocop.with({
            command = "bundle",
            args = vim.list_extend(
              { "exec", "rubocop" },
              null_ls.builtins.diagnostics.rubocop._opts.args
            ),
          })
          or null_ls.builtins.diagnostics.rubocop
    end),
  },
})
