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
    "zbirenbaum/copilot.lua",
    cmd = { "Copilot" },
    event = "InsertEnter",
    opts = {
      copilot_node_command = vim.fn.expand("$HOME") .. "/.local/share/mise/installs/node/23.10.0/bin/node",
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 0,
        keymap = {
          accept = "<M-l>",
        }
      },
      copilot_model = "gpt-4o-copilot"
    }
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "gpt-4.1",
              },
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = "copilot",
        },
        inline = {
          adapter = "copilot",
        },
        agent = {
          adapter = "copilot",
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
        },
      }
    }
  }
}
