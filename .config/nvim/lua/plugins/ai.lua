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
      prompt_library = {
        ["Ruby on Rails Expert"] = {
          strategy = "chat",
          description = "Professional Ruby and Ruby on Rails developer for code review, debugging, and best practices.",
          prompts = {
            {
              role = "system",
              content =
              "You are a senior Ruby and Ruby on Rails developer. You write idiomatic, secure, and maintainable Ruby code, follow Rails conventions, and provide clear, concise explanations.",
            },
            {
              role = "user",
              content = "Please review or help with the following Ruby/Rails code or question: "
            }
          },
        },
        ["React Frontend Specialist"] = {
          strategy = "chat",
          description =
          "Professional React and JavaScript frontend specialist for code review, debugging, and best practices.",
          prompts = {
            {
              role = "system",
              content =
              "You are a senior frontend developer specializing in React and modern JavaScript. You write clean, efficient, and accessible code, follow best practices, and provide clear, actionable feedback.",
            },
            {
              role = "user",
              content = "Please review or help with the following React/JavaScript code or question: "
            }
          },
        },
      },
    }
  }
}
