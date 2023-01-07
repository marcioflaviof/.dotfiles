local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatters = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

-- local conditional = function(fn)
-- 	local utils = require("null-ls.utils").make_conditional_utils()
-- 	return fn(utils)
-- end

-- https://github.com/prettier-solidity/prettier-plugin-solidity
null_ls.setup({
	debug = false,
	sources = {
		formatters.prettierd,
		formatters.stylua,

		diagnostics.eslint_d.with({
			condition = function(utils)
				return utils.root_has_file({ ".eslintrc.js" })
			end,
		}),

		diagnostics.rubocop.with({
			condition = function(utils)
				return utils.root_has_file({ ".rubocop.yml" })
			end,
			command = "bundle",
			args = vim.list_extend({ "exec", "rubocop" }, null_ls.builtins.diagnostics.rubocop._opts.args),
		}),
	},
})
