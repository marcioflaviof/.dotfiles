return {
  {
    "Exafunction/codeium.vim",
    config = function()
      vim.keymap.set("i", "<C-a>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true })

      vim.g.codeium_enabled = true
    end,
    event = "BufEnter",
    commit = "289eb724e5d6fab2263e94a1ad6e54afebefafb2"
  },

}
