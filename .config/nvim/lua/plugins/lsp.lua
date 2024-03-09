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
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    config = function()
      local lsp_zero = require('lsp-zero')

      local luasnip = require("luasnip")
      luasnip.filetype_extend("typescriptreact", { "javascript", "typescript" })

      require('luasnip.loaders.from_vscode').lazy_load()

      lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.buffer_autoformat()
        lsp_zero.default_keymaps({ buffer = bufnr, preserve_mappings = false })

        if client.name == 'svelte' then
          vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = { "*.js", "*.ts" },
            callback = function(ctx)
              client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
            end,
          })

          vim.api.nvim_create_autocmd({ "BufWrite" }, {
            pattern = { "+page.server.ts", "+page.ts", "+layout.server.ts", "+layout.ts" },
            command = "LspRestart svelte",
          })
        end
        local opts = { noremap = true, silent = true }

        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

        local bufopts = { noremap = true, silent = true, buffer = bufnr }

        vim.keymap.set("n", "gd", function()
          vim.lsp.buf.definition({ on_list = on_list })
        end, bufopts)
      end)


      lsp_zero.format_on_save({
        format_opts = {
          async = false,
          timeout_ms = 10000,
        },
        servers = {
          ["null-ls"] = { "javascript", "typescript", "ruby", "typescriptreact", "javascriptreact", "markdown" },
        }
      })
      -- MASON
      local lua_opts = lsp_zero.nvim_lua_ls()

      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = {
          "cssls",
          "html",
          "jsonls",
          "lua_ls",
          -- "yamlls",
          -- "solargraph",
          "ruby_ls",
          "eslint",
          -- "tailwindcss",
          -- "prismals",
          -- "svelte",
          -- "tsserver",
          "emmet_language_server"
        },
        handlers = {
          lsp_zero.default_setup,
          tsserver = lsp_zero.noop,
          lua_ls = require('lspconfig').lua_ls.setup(lua_opts),
        }
      })

      -- CMP

      local cmp = require('cmp')
      local cmp_action = require('lsp-zero').cmp_action()

      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        snippet = {
          expand = function(args)
            require 'luasnip'.lsp_expand(args.body)
          end
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip", max_item_count = 3 },
          { name = "buffer" },
          { name = "nvim_lua" },
          { name = "path" },
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp_action.luasnip_supertab(),
          ["<C-p>"] = cmp_action.luasnip_shift_supertab(),
          -- `Enter` key to confirm completion
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          -- Ctrl+Space to trigger completion menu
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<Tab>"] = cmp_action.luasnip_supertab(),
          ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
        }),
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' }
            }
          }
        })
      })

      --- NULL LS
      local null_ls = require("null-ls")

      local formatters = null_ls.builtins.formatting
      local diagnostics = null_ls.builtins.diagnostics

      null_ls.setup({
        sources = {
          formatters.prettierd,
          -- formatters.erb_format,

          -- diagnostics.eslint_d.with({
          --   condition = function(utils)
          --     return utils.root_has_file({ ".eslintrc.js" })
          --   end,
          -- }),

          -- diagnostics.rubocop.with({
          --   condition = function(utils)
          --     return utils.root_has_file({ ".rubocop.yml" })
          --   end,
          --   command = "bundle",
          --   args = vim.list_extend({ "exec", "rubocop" }, null_ls.builtins.diagnostics.rubocop._opts.args),
          -- }),
        },
      })
    end,
  },


  'neovim/nvim-lspconfig',
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "nvimtools/none-ls.nvim",
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
          expose_as_code_action = 'all',
        },

        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      })
    end,
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- snippets
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",

      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-cmdline",
    },
  },

  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require 'lsp_signature'.setup({
        floating_window = false,
        hint_scheme = "Comment",
        hint_prefix = " ",
      })
    end
  },
}
