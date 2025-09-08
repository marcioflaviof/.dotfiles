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
			map("<leader>ws", vim.lsp.buf.workspace_symbol, "[W]orkspace [S]ymbols")
			map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
			map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
			map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
			map("gl", function()
				vim.diagnostic.open_float()
			end, "")
			map("K", function()
				vim.lsp.buf.hover({
					border = "single",
					close_events = { "CursorMoved", "BufHidden", "InsertCharPre" },
					focusable = true,
					max_width = 120,
				})
			end, "Hover")

			-- LSP Highlighting
			local client = vim.lsp.get_client_by_id(event.data.client_id)
			if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
				local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.document_highlight,
				})

				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.clear_references,
				})

				vim.api.nvim_create_autocmd("LspDetach", {
					group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
					callback = function(event2)
						vim.lsp.buf.clear_references()
						vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
					end,
				})
			end

			if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
				map("<leader>th", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
				end, "[T]oggle Inlay [H]ints")
			end

			map("gR", function()
				vim.lsp.buf_request(0, "workspace/executeCommand", {
					command = "typescript.findAllFileReferences",
					arguments = { vim.uri_from_bufnr(event.buf) },
				}, function(err, result)
					if result then
						vim.lsp.util.set_qflist(result)
						vim.cmd("copen")
					end
				end)
			end, "File References")

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
