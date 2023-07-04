local status_ok, comment = pcall(require, "Comment")
if not status_ok then
	return
end

local ts_ok, ts_configs = pcall(require, "nvim-treesitter.configs")
if not ts_ok then
	return
end

ts_configs.setup({
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})

comment.setup({
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})
