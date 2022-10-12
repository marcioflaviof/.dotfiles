local status_ok, typescript = pcall(require, "typescript")
if not status_ok then
  return
end


local function attach_navic(client, bufnr)
  vim.g.navic_silence = true
  local status_ok_navic, navic = pcall(require, "nvim-navic")
  if not status_ok_navic then
    return
  end

  navic.attach(client, bufnr)
end

typescript.setup({
  disable_commands = false, -- prevent the plugin from creating Vim commands
  debug = false, -- enable debug logging for commands
  eslint_bin = "eslint_d", -- use eslint_d if possible!
  import_on_completion_timeout = 5000,
  server = {

    on_attach = function(client, bufnr)
      attach_navic(client, bufnr)

      if client.name == "tsserver" or client.name == "typescript" then
        client.server_capabilities.document_formatting = false

        vim.keymap.set("n", "<leader>lu", function()
          local ts = require("typescript").actions
          ts.removeUnused({ sync = true })
          --[[ vim.wait(1000) ]]
          --[[ ts.organizeImports({ sync = true }) ]]
        end)
      end
    end,
  },
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, ...)
  local client = vim.lsp.get_client_by_id(ctx.client_id)

  if client and client.name == "tsserver" then
    result.diagnostics = vim.tbl_filter(function(diagnostic)
      return not diagnostic.message:find("File is a CommonJS module; it may be converted to an ES module.")
    end, result.diagnostics)
  end

  return vim.lsp.diagnostic.on_publish_diagnostics(nil, result, ctx, ...)
end
