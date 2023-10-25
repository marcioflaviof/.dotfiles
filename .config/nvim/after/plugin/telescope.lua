local builtin = require("telescope.builtin")
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local lga_actions = require("telescope-live-grep-args.actions")
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
    preview = {
      highlight_limit = 1, -- MB
    },
    file_ignore_patterns = {
      "bundle/*",
      "coverage/*",
      ".git/",
      ".next/",
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
      file_ignore_patterns = { ".spec" },
    },
    grep_string = {
      theme = "dropdown",
      layout_config = {
        width = 0.87,
        height = 0.4,
      },
      initial_mode = "normal",
      file_ignore_patterns = { ".test", ".spec" },
    },
    lsp_references = {
      theme = "dropdown",
      path_display = { 'truncate' },
      layout_config = {
        width = 0.87,
        height = 0.4,
      },
      file_ignore_patterns = { ".test", ".spec" },
      initial_mode = "normal",
      show_line = false
    },
    find_files = {
      theme = "dropdown",
      hidden = true,
      find_command = {
        "rg",
        "--files",
        "--hidden",
        "--iglob",
        "!**/.git/*",
        "--no-ignore-vcs"
      },
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
    quickfix = {
      theme = "dropdown",
      layout_config = {
        width = 0.87,
        height = 0.4,
      },
      initial_mode = "normal",
    },
    resume = {
      initial_mode = "normal",
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
    },
    live_grep_args = {
      theme = "dropdown",
      auto_quoting = true,
      layout_config = {
        width = 0.87,
        height = 0.4,
      },
      mappings = {
        i = {
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
        },
      }
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({}),
    },
  },
})

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap("n", "<leader>sg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", opts)

keymap("n", "<leader>f", builtin.find_files, opts)
keymap("n", "<leader>so", builtin.oldfiles, opts)
keymap("n", "<leader>gb", builtin.git_branches, opts)
keymap("n", "<leader>slr", builtin.lsp_references, opts)
keymap("n", "<leader>sq", builtin.quickfix, opts)
keymap("n", "<leader>sr", "<cmd>lua require('telescope.builtin').resume()<cr>", opts)
keymap("n", "<leader>sw", builtin.grep_string, opts)
keymap("n", "<leader>sb", builtin.buffers, opts)

pcall(telescope.load_extension, "live_grep_args")
require('telescope').load_extension('fzf')
require("telescope").load_extension("ui-select")
