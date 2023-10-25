local lsp_zero = require('lsp-zero')
local lspzero_utils = require("user.lsp.settings.utils")

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
    vim.lsp.buf.definition({ on_list = lspzero_utils.on_list })
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
require('lspconfig').lua_ls.setup(lua_opts)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    "cssls",
    "html",
    "jsonls",
    "lua_ls",
    -- "yamlls",
    "solargraph",
    -- "ruby_ls",
    -- "tailwindcss",
    "prismals",
    "svelte"
  },
  handlers = {
    lsp_zero.default_setup,
    tsserver = lsp_zero.noop,
    lua_ls = require('lspconfig').lua_ls.setup(lua_opts)
  },
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

--- NULL LS
local null_ls = require("null-ls")

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatters = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  sources = {
    formatters.prettierd,
    formatters.erb_format,

    diagnostics.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file({ ".eslintrc.js" })
      end,
    }),

    -- diagnostics.rubocop.with({
    --   condition = function(utils)
    --     return utils.root_has_file({ ".rubocop.yml" })
    --   end,
    --   command = "bundle",
    --   args = vim.list_extend({ "exec", "rubocop" }, null_ls.builtins.diagnostics.rubocop._opts.args),
    -- }),
  },
})
