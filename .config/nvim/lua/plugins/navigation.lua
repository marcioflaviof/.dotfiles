Job = require "plenary.job"

return {
  {
    "tpope/vim-projectionist",
    config = function()
      vim.g.projectionist_heuristics = {
        ["*"] = {
          ["src/*.tsx"] = {
            alternate = "src/{dirname}/__tests__/{basename}.test.tsx",
            type = "source"
          },
          ['src/**/__tests__/*.test.tsx'] = {
            alternate = "src/{dirname}/{basename}.tsx",
            type = "test"
          },
          ["src/*.ts"] = {
            alternate = "src/{dirname}/__tests__/{basename}.test.ts",
            type = "source"
          },
          ['src/**/__tests__/*.test.ts'] = {
            alternate = "src/{dirname}/{basename}.ts",
            type = "test"

          },

          ["app/initializers/*.js"] = {
            type = "initializer"
          },
          ["app/models/*.js"] = {
            type = "model",
            alternate = "app/adapters/{}.js"
          },
          ["app/adapters/*.js"] = {
            type = "adapter",
            alternate = "app/serializers/{}.js"
          },
          ["app/serializers/*.js"] = {
            type = "serializer",
            alternate = "app/models/{}.js"
          },
          ["app/services/*.js"] = {
            type = "service"
          },
          ["app/routes/*.js"] = {
            type = "route",
            alternate = "app/controllers/{}.js"
          },
          ["app/controllers/*.js"] = {
            type = "controller",
            alternate = "app/templates/{}.hbs"
          },
          ["app/templates/*.hbs"] = {
            type = "template",
            alternate = "app/routes/{}.js"
          },
          ["app/components/*.js"] = {
            type = "component",
            alternate = "app/templates/components/{}.hbs"
          },
          ["app/components/*/component.js"] = {
            type = "component",
            alternate = "app/components/{}/template.hbs"
          },
          ["app/templates/components/*.hbs"] = {
            type = "ctemplate",
            alternate = "app/components/{}.js"
          }
        }
      }

      vim.keymap.set('n', '<leader>al', '<CMD>A<CR>')
    end,
  },
  {
    "tpope/vim-rails",
    ft = { "ruby", "eruby", "slim", "yaml", "yml" },
    config = function()
      vim.keymap.set('n', '<leader>rl', '<CMD>R<CR>')
    end
  },
  {
    "cbochs/grapple.nvim",
    keys = {
      { "<leader>hm", "<cmd>Grapple toggle<cr>",         mode = { 'n' } },
      { "<leader>h",  "<cmd>Grapple toggle_tags<cr>",    mode = { 'n' } },
      { "<leader>1",  "<cmd>Grapple select index=1<cr>", mode = { 'n' } },
      { "<leader>2",  "<cmd>Grapple select index=2<cr>", mode = { 'n' } },
      { "<leader>3",  "<cmd>Grapple select index=3<cr>", mode = { 'n' } },
      { "<leader>4",  "<cmd>Grapple select index=4<cr>", mode = { 'n' } },
    },
    opts = {
      scope = 'git_branch'
    },
    cmd = "Grapple",
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          -- default options: exact mode, multi window, all directions, with a backdrop
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    },
    config = function()
      require("flash").setup({
        labels = "ASDFGHJKLQWERTYUIOPZXCVBNM",
      })
    end,
  },
}
