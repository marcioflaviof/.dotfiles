require('gitblame').setup {
  enabled = false
}
vim.g.gitblame_date_format = "%r"
vim.g.gitblame_message_template = "<summary> • <date> • <author>"
vim.g.gitblame_highlight_group = "LineNr"
