local M = {}

function M.setup()
	local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
	local diagnostic_signs = {}
	for type, icon in pairs(signs) do
		diagnostic_signs[vim.diagnostic.severity[type]] = icon
	end

	vim.diagnostic.config({
		signs = { text = diagnostic_signs },
		virtual_text = {
			prefix = "●",
			spacing = 4,
			source = "if_many",
		},
	})
end

return M
