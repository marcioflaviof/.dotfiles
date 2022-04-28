local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

telescope.load_extension("media_files")
telescope.load_extension("fzy_native")
telescope.load_extension("project")

telescope.setup({
	defaults = {
		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		},
		project = {
			base_dirs = {
				{ path = "/home/Documents/Stack/stack-shops-client" },
				{ path = "~/home/Documents/Stack/stack-shops" },
				{ path = "~/home/Documents/Stack/stack-api" },
				{ path = "~/home/Documents/Stack/stack-admin" },
			},
		},
	},
	hidden = true,
	pickers = {
		find_files = {
			hidden = true,
		},
	},
	file_ignore_patters = { "node_modules/*", ".git" },
})
