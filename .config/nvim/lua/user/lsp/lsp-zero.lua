local lsp_zero = require('lsp-zero')

---@diagnostic disable-next-line: unused-local
lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr, preserve_mappings = false })
  lsp_zero.buffer_autoformat()

  if client.name == 'svelte' then
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = { "*.js", "*.ts" },
      callback = function(ctx)
        client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
      end,
    })
  end
end)

lsp_zero.format_on_save({
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    ["null-ls"] = { "javascript", "typescript", "ruby" },
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
    -- "solargraph",
    "ruby_ls",
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
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
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
    formatters.rustfmt,

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
