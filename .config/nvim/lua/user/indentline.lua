local status_ok, indent_blankline = pcall(require, "ibl")
if not status_ok then
  return
end


indent_blankline.setup({
  scope = {
    enabled = true,
    show_start = false,
    show_end = false,
    highlight = { "Function" },
    include = {
      node_type = {
        ["*"] = { "*" }
      }
    }

  },
  indent = {
    char = "▏",
  },
  exclude = {
    filetypes = {
      "help",
      "dashboard",
      "neogitstatus",
      "NvimTree",
      "Trouble"
    }
  }
})
