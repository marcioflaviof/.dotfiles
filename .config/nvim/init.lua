require("user.options")
require("user.breadcrumbs")
require("user.plugins")
require("user.keymaps")
require("user.colorscheme")
require("user.cmp")
require("user.colorizer")
require("user.lsp")
require("user.telescope")
require("user.orgmode")
require("user.treesitter")
require("user.autopairs")
require("user.comment")
require("user.gitsigns")
require("user.nvim-tree")
require("user.feline")
require("user.toggleterm")
require("user.impatient")
require("user.indentline")
require("user.matchup")
require("user.git-blame")
require("user.nvim-webdev-icons")
--[[ require("user.bufferline") ]]
require("user.neotest")
require("user.illuminate")

require("user.lsp.handlers").toggle_format_on_save()
