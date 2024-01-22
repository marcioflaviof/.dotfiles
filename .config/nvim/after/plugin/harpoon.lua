local h_status_ok, harpoon = pcall(require, "harpoon")
if not h_status_ok then
  return
end

harpoon:setup({
  settings = {
    save_on_ui_close = true,
    save_on_toggle = true
  },
})

vim.keymap.set("n", "<leader>hm", function() harpoon:list():append() end)
vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
