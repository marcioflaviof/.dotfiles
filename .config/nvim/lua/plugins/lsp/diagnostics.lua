local M = {}

function M.setup()
	local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
	local diagnostic_signs = {}
	for type, icon in pairs(signs) do
		diagnostic_signs[vim.diagnostic.severity[type]] = icon
	end

	-- No virtual_text here: tiny-inline-diagnostic renders diagnostics and
	-- disables it anyway, so setting it up first was pure churn.
	vim.diagnostic.config({
		signs = { text = diagnostic_signs },
		severity_sort = true,
	})
end

return M
