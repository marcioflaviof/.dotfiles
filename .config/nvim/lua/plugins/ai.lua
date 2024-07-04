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

  {
    "nomnivore/ollama.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },

    -- All the user commands added by the plugin
    cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },

    keys = {
      -- Sample keybind for prompt menu. Note that the <c-u> is important for selections to work properly.
      {
        "<leader>oo",
        ":<c-u>lua require('ollama').prompt()<cr>",
        desc = "ollama prompt",
        mode = { "n", "v" },
      },

      -- Sample keybind for direct prompting. Note that the <c-u> is important for selections to work properly.
      {
        "<leader>oG",
        ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
        desc = "ollama Generate Code",
        mode = { "n", "v" },
      },
    },

    opts = {
      model = "llama3",
      url = "http://127.0.0.1:11434",
      serve = {
        on_start = false,
        command = "ollama",
        args = { "serve" },
        stop_command = "pkill",
        stop_args = { "-SIGTERM", "ollama" },
      },

      prompts = {
        Create_Test = {
          prompt =
          "Please create for me a test for the following code, and just send me the test code, no explanation needed: $sel(ection)",
          input_label = "> ",
          action = "display",
        }
      }
    }
  }
}
