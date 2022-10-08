local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup({
  ensure_installed = { "javascript", "typescript", "html", "tsx", "org", "ruby", "lua", "css" },
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "org" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  autopairs = {
    enable = true,
  },
  indent = { enable = true, disable = { "python", "css", "yaml" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  autotag = {
    enable = true,
  },
})
