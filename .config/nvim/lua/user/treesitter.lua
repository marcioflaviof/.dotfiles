local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = "all",
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = true,
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = true, disable = { "python", "css", "yaml" } },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	autotag = {
		enable = true,
	},
	rainbow = {
		enable = true,
		extended_mode = false,
		colors = {
			"#7AA2F7",
			"#BB9AF7",
			"#2AC3DE",
			-- "Cornsilk",
			-- "Salmon",
			-- "LawnGreen",
		},
		-- disable = { "tsx", "jsx", "html" },
	},
})
