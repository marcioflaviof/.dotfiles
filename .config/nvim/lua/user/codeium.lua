vim.g.codeium_enabled = true

local status_ok, codeium = pcall(require, "codeium")
if not status_ok then
	return
end

require("codeium").setup({})

-- vim.g.codeium_filetypes = {
--   ["bash"] = false,
--   ["typescript"] = true,
-- }
