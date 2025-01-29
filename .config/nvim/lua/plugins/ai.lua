vim.api.nvim_set_keymap("n", "<Leader>o", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Leader>o", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>",
  { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>",
  { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })


-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
return {
  {
    "Exafunction/codeium.vim",
    config = function()
      vim.keymap.set("i", "<C-a>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true })

      vim.keymap.set("i", "<C-a>", function() return vim.fn["codeium#Accept"]() end, { expr = true, silent = true })
      vim.keymap.set("i", "<C-x>", function() return vim.fn["codeium#Clear"]() end, { expr = true, silent = true })
      vim.keymap.set("i", "<C-]>", function() return vim.fn["codeium#CycleCompletions"](1) end,
        { expr = true, silent = true })

      vim.g.codeium_enabled = true

      vim.g.codeium_filetypes = {
        markdown = false
      }
    end,
    event = "BufEnter",
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves the default Neovim UI
    },
    config = function()
      require("codecompanion").setup({
        config = function()
        end,
        adapters = {
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              schema = {
                model = {
                  default = 'llama3.1'
                }
              }
            })
          end
        },
        strategies = {
          chat = {
            adapter = "ollama",
          },
          inline = {
            adapter = "ollama",
          },
          agent = {
            adapter = "ollama",
          },
        },
        prompt_library = {
          ["Fix Grammar"] = {
            strategy = "chat",
            description = "Fix the english grammar",
            prompts = {
              {
                role = "system",
                content = "You are an experienced english teacher",
              },
              {
                role = "user",
                content = "Can you fix the grammar on this sentence: "
              }
            },
          }
        }
      })
    end,
  }
}
