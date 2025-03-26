return {
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      ui = {
        enable = false
      },
      attachments = {
        img_folder = 'Attachments',
      },
      workspaces = {
        {
          name = "personal",
          path = "~/Documents/Obsidian",
        },
        {
          name = "no-vault",
          path = function()
            -- alternatively use the CWD:
            -- return assert(vim.fn.getcwd())
            return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
          end,
          overrides = {
            notes_subdir = vim.NIL, -- have to use 'vim.NIL' instead of 'nil'
            new_notes_location = "current_dir",
            templates = {
              folder = vim.NIL,
            },
            disable_frontmatter = true,
          },
        },
      },

    },
  }
}
