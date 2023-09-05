local lsp = require("lsp-zero").preset({})

local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()
require("luasnip.loaders.from_vscode").lazy_load()

local luasnip = require("luasnip")
luasnip.filetype_extend("typescriptreact", { "javascript" })

-- CMP
cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip", max_item_count = 3 },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" },
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})

lsp.setup_nvim_cmp({
  mapping = {
    ["<C-n>"] = cmp_action.luasnip_supertab(),
    ["<C-p>"] = cmp_action.luasnip_shift_supertab(),
    -- `Enter` key to confirm completion
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    -- Ctrl+Space to trigger completion menu
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<Tab>"] = cmp_action.luasnip_supertab(),
    ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
  },
})

-- LSP

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
  lsp.buffer_autoformat()

  vim.keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", { buffer = true })
end)

lsp.format_on_save({
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    ["null-ls"] = { "javascript", "typescript", "lua" },
  },
})

lsp.ensure_installed({
  -- "tsserver",
  "cssls",
  "html",
  "jsonls",
  "lua_ls",
  -- "yamlls",
  "solargraph@0.13.2",
  -- "ruby_ls@0.1.0",
  -- "tailwindcss",
  "rust_analyzer",
  "prismals",
})

lsp.skip_server_setup({ "tsserver" })

lsp.nvim_workspace()

--- NULL LS

local null_ls = require("null-ls")

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatters = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  sources = {
    formatters.prettierd,
    formatters.stylua,
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

lsp.setup()
