local utils = require("plugins.lsp.utils")
local M = {}

function M.setup()
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
		callback = function(event)
			local map = function(keys, func, desc, mode)
				mode = mode or "n"
				vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
			end

			local Snacks = require("snacks")

			map("gd", function()
				vim.lsp.buf.definition({ on_list = utils.on_list })
			end, "[G]oto [D]efinition")
			map("<leader>lr", function()
				Snacks.picker.lsp_references()
			end, "[L]sp [R]eferences")
			map("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
			map("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
			map("<leader>ds", vim.lsp.buf.document_symbol, "[D]ocument [S]ymbols")
			map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
			map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
			map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
			map("gl", function()
				vim.diagnostic.open_float()
			end, "")
			map("K", function()
				vim.lsp.buf.hover({
					-- border comes from the global 'winborder'
					close_events = { "CursorMoved", "BufHidden", "InsertCharPre" },
					focusable = true,
					max_width = 120,
				})
			end, "Hover")

			-- Reference highlighting is vim-illuminate's job; its `lsp` provider
			-- issues the same textDocument/documentHighlight request this block
			-- used to, so doing it here as well was duplicated work.
			local client = vim.lsp.get_client_by_id(event.data.client_id)

			if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
				map("<leader>th", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
				end, "[T]oggle Inlay [H]ints")
			end

			map("<leader>lR", function()
				vim.lsp.buf_request(0, "workspace/executeCommand", {
					command = "typescript.findAllFileReferences",
					arguments = { vim.uri_from_bufnr(event.buf) },
				}, function(err, result)
					if result then
						vim.lsp.util.set_qflist(result)
						vim.cmd("copen")
					end
				end)
			end, "[L]sp File [R]eferences")

			map("<leader>lo", function()
				vim.lsp.buf.code_action({
					context = { only = { "source.organizeImports" } },

					apply = true,
				})
			end, "Organize Imports")

			map("<leader>li", function()
				vim.lsp.buf.code_action({
					context = { only = { "source.addMissingImports.ts" } },
					apply = true,
				})
			end, "Add Missing Imports")

			map("<leader>lu", function()
				vim.lsp.buf.code_action({
					context = { only = { "source.removeUnused.ts" } },
					apply = true,
				})
			end, "Remove Unused Imports")

			map("<leader>lO", function()
				vim.lsp.buf.code_action({
					context = { only = { "source.fixAll.ts" } },
					apply = true,
				})
			end, "Fix All Diagnostics")
		end,
	})
end

return M
