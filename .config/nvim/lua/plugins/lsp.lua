local function filter(arr, fn)
  if type(arr) ~= "table" then
    return arr
  end

  local filtered = {}
  for k, v in pairs(arr) do
    if fn(v, k, arr) then
      table.insert(filtered, v)
    end
  end

  return filtered
end

local function filterReactDTS(value)
  return string.match(value.filename, "react/index.d.ts") == nil
end

local function on_list(options)
  local items = options.items
  if #items > 1 then
    items = filter(items, filterReactDTS)
  end

  vim.fn.setqflist({}, " ", { title = options.title, items = items, context = options.context })
  vim.api.nvim_command("cfirst") -- or maybe you want 'copen' instead of 'cfirst'
end

return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    -- Main LSP Configuration
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", opts = {} },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Useful status updates for LSP.
      { "j-hui/fidget.nvim",       opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      'saghen/blink.cmp'
    },
    config = function()
      local Snacks = require("snacks")

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("gd", function()
            vim.lsp.buf.definition({ on_list = on_list })
          end, "[G]oto [D]efinition")

          map("<leader>lr", function() Snacks.picker.lsp_references() end, "[L]sp [R]eferences")
          map("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
          map("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
          map("<leader>ds", vim.lsp.buf.document_symbol, "[D]ocument [S]ymbols")
          map("<leader>ws", vim.lsp.buf.workspace_symbol, "[W]orkspace [S]ymbols")
          map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
          map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
          map("gl", function() vim.diagnostic.open_float() end, "")

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup =
                vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
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

          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "[T]oggle Inlay [H]ints")
          end
        end,
      })

      local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
      local diagnostic_signs = {}
      for type, icon in pairs(signs) do
        diagnostic_signs[vim.diagnostic.severity[type]] = icon
      end
      vim.diagnostic.config({ signs = { text = diagnostic_signs } })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

      local servers = {
        lua_ls = {
          -- cmd = { ... },
          -- filetypes = { ... },
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              diagnostics = { disable = { "missing-fields" } },
            },
          },
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "html",
        "jsonls",
        "lua_ls",
        "flake8",
        -- "ruby_lsp",
        { 'solargraph', version = '0.51.1' },
        "emmet_ls"
      })
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("typescript-tools").setup({
        settings = {
          separate_diagnostic_server = true,
          publish_diagnostic_on = "insert_leave",
          tsserver_max_memory = "auto",
          tsserver_plugins = {},
          tsserver_format_options = {},
          tsserver_file_preferences = {
            includeInlayParameterNameHints = "all",
            includeCompletionsForModuleExports = true,
            quotePreference = "auto",
          },
          -- expose_as_code_action = { 'organize_imports', 'remove_unused_imports', 'fix_all' },
          expose_as_code_action = 'all'
        },

        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      })
    end,
    event = "VeryLazy",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    keys = {
      { "<leader>lo", "<cmd>TSToolsOrganizeImports<CR>",     desc = "Organize imports",      mode = { 'n' } },
      { "<leader>lu", "<cmd>TSToolsRemoveUnusedImports<CR>", desc = "Remove unused imports", mode = { 'n' } },
      { "<leader>li", "<cmd>TSToolsAddMissingImports<CR>",   desc = "Add missing imports",   mode = { 'n' } },
    }
  },
  {
    'folke/trouble.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = {
      { "<leader>xx", function() require("trouble").toggle("diagnostics") end },
      { "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end },
      { "gR",         function() require("trouble").toggle("lsp_references") end },
    }
  },
}
