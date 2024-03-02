local h_status_ok, harpoon = pcall(require, "harpoon")
if not h_status_ok then
  return
end

local Job = require "plenary.job"

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


harpoon:setup({
  settings = {
    save_on_ui_close = true,
    save_on_toggle = true,
    key = function()
      local branch = get_os_command_output({
        "git",
        "rev-parse",
        "--abbrev-ref",
        "HEAD",
      })[1]

      if branch then
        return vim.loop.cwd() .. "-" .. branch
      else
        return vim.loop.cwd()
      end
    end
  },
})

vim.keymap.set("n", "<leader>hm", function() harpoon:list():append() end)
vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
