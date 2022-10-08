local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local yank_group = augroup("HighlightYank", {})

-- Put stories from storybook as markdown files
autocmd("BufRead", {
  pattern = { "*.stories.mdx", "*.stories.md" },
  callback = function()
    vim.schedule(function()
      vim.api.nvim_command("set ft=tsx")
    end)
  end,
})

autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 40,
    })
  end
})

vim.api.nvim_exec([[
augroup MyColors
	autocmd!
	autocmd ColorScheme * highlight LineNr guifg=#5081c0   | highlight CursorLineNR guifg=#FFba00
augroup END
]], false)
