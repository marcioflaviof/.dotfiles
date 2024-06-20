local autocmd = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup

local yank_group = ag("HighlightYank", {})

-- jbuilder as ruby
autocmd("BufRead", {
  pattern = { "*.jbuilder" },
  callback = function()
    vim.schedule(function()
      vim.api.nvim_command("set ft=ruby")
    end)
  end,
})


autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ 'r', 'o' })
  end,
})


-- GROUPS:
local disable_node_modules_eslint_group = ag("DisableNodeModulesEslint", { clear = true })

autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "**/node_modules/**", "node_modules", "/node_modules/*" },
  callback = function()
    vim.diagnostic.enable(false)
  end,
  group = disable_node_modules_eslint_group,
})
