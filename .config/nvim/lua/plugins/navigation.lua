Job = require "plenary.job"

local function get_os_command_output(cmd, cwd)
  if type(cmd) ~= "table" then return {} end
  local command = table.remove(cmd, 1)
  local stderr = {}
  local stdout, ret = Job:new({
    command = command,
    args = cmd,
    cwd = cwd,
    on_stderr = function(_, data) table.insert(stderr, data) end,
  }):sync()
  return stdout, ret, stderr
end

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
    "ThePrimeagen/harpoon",
    branch = 'harpoon2',
    config = function()
      local h_status_ok, harpoon = pcall(require, "harpoon")
      if not h_status_ok then
        return
      end

      harpoon:setup({
        settings = {
          save_on_ui_close = true,
          save_on_toggle = true,
        },
      })

      vim.keymap.set("n", "<leader>hm", function() harpoon:list():add() end)
      vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
      vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
    end,
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
