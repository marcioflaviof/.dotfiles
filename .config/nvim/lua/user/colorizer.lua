local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
  return
end

colorizer.setup({
  filetypes = { "scss", "css", "lua", "typescriptreact", "typescript", "ruby", "javascript", 'svelte' },
  user_default_options = {
    tailwind = true,
    rgb_fn   = true, -- CSS rgb() and rgba() functions
    hsl_fn   = true, -- CSS hsl() and hsla() functions
    names    = false,
    css      = true,
    -- virtualtext = "■",
    mode     = "background", -- virtualtext | background
  },
})
