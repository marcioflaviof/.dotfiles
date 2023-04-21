local builtin = require("telescope.builtin")
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "truncate" },
		hidden = true,
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.3,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},
		file_ignore_patterns = {
			".git/",
			"target/",
			"docs/",
			"vendor/*",
			"%.lock",
			"package%-lock.json",
			"__pycache__/*",
			"%.sqlite3",
			"%.sql",
			"%.ipynb",
			"node_modules/*",
			"%.jpg",
			"%.jpeg",
			"%.png",
			"%.svg",
			"%.otf",
			"%.ttf",
			"%.webp",
			".dart_tool/",
			".github/",
			".gradle/",
			".idea/",
			".vscode/",
			"__pycache__/",
			"build/",
			"gradle/",
			"node_modules/",
			"%.pdb",
			"%.dll",
			"%.class",
			"%.exe",
			"%.cache",
			"%.ico",
			"%.pdf",
			"%.dylib",
			"%.jar",
			"%.docx",
			"%.met",
			"smalljre_*/*",
			".vale/",
			"%.burp",
			"%.mp4",
			"%.mkv",
			"%.rar",
			"%.zip",
			"%.7z",
			"%.tar",
			"%.bz2",
			"%.epub",
			"%.flac",
			"%.tar.gz",
		},
		mappings = {
			n = {
				["q"] = actions.close,
				["<esc>"] = actions.close,
				["dd"] = require("telescope.actions").delete_buffer,
			},
		},
	},
	vimgrep_arguments = {
		"rg",
		"--color=never",
		"--no-heading",
		"--with-filename",
		"--line-number",
		"--column",
		"--smart-case",
		"--hidden",
		-- "--glob=!.git/",
	},
	pickers = {
		live_grep = {
			theme = "dropdown",
			layout_config = {
				width = 0.87,
				height = 0.4,
			},
			-- file_ignore_patterns = { ".test", ".spec" }
		},
		grep_string = {
			theme = "dropdown",
			layout_config = {
				width = 0.87,
				height = 0.4,
			},
			initial_mode = "normal",
			-- file_ignore_patterns = { ".test", ".spec" }
		},
		lsp_references = {
			theme = "dropdown",
			path_display = { "tail" },
			layout_config = {
				width = 0.87,
				height = 0.4,
			},
			file_ignore_patterns = { ".test", ".spec" },
			initial_mode = "normal",
		},
		find_files = {
			theme = "dropdown",
			find_command = { "rg", "--files", "--iglob", "!.git", "--hidden" },
			previewer = false,
			layout_config = {
				horizontal = {
					prompt_position = "top",
					results_width = 0.8,
				},
				vertical = {
					mirror = false,
				},
				width = 0.87,
				height = 0.80,
			},
		},
		buffers = {
			-- 	theme = "dropdown",
			-- 	previewer = false,
			initial_mode = "normal",
		},
		quickfix = {
			theme = "dropdown",
			layout_config = {
				width = 0.87,
				height = 0.4,
			},
			initial_mode = "normal",
			-- file_ignore_patterns = { ".test", ".spec" }
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap("n", "<leader>sw", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, opts)

keymap("n", "<leader>st", function()
	builtin.live_grep()
end, opts)

keymap("n", "<leader>f", builtin.find_files, opts)
keymap("n", "<leader>so", builtin.oldfiles, opts)
keymap("n", "<leader>gb", builtin.git_branches, opts)
keymap("n", "<leader>slr", builtin.lsp_references, opts)
keymap("n", "<leader>sb", builtin.buffers, opts)
keymap("n", "<leader>sq", builtin.quickfix, opts)
-- keymap("n", "gd", builtin.lsp_definitions, opts)

-- Enable telescope fzf native, if installed
pcall(telescope.load_extension, "fzf")
