return {
  {
    "Exafunction/codeium.vim",
    config = function()
      vim.keymap.set("i", "<C-a>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true })

      vim.g.codeium_enabled = true
    end,
    event = "BufEnter"
  },

}
