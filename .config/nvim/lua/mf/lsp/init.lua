local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("mf.lsp.lsp-installer")
require("mf.lsp.handlers").setup()
