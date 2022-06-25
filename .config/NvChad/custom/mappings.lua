local M = {}

M.general = {
  i = {
    -- go to normal mode
    ["jk"] = { "<C-c>", "normal mode" },
  },

  n = {
    ["<leader>h"] = { "<cmd> noh <CR>", "  no highlight" },

    -- git
    ["<leader>gl"] = { ":Gitsigns blame_line<CR>", "  blame line" },

    -- Copy path
    ["<F4>"] = { ':let @+ = fnamemodify(expand("%"), ":~:.")<CR>', "copy relative path" },
    ["<F5>"] = { ":let @+ = expand('%:p')<CR>", "copy absolute path" },
  },

  x = {
    ["J"] = { ":move '>+1<CR>gv-gv", "move text down" },
    ["K"] = { ":move '<-2<CR>gv-gv", "move text up" },
  },
}

M.bufferline = {
  n = {
    -- cycle through buffers
    ["<S-l"] = { "<cmd> BufferLineCycleNext <CR>", "  cycle next buffer" },
    ["<S-h>"] = { "<cmd> BufferLineCyclePrev <CR>", "  cycle prev buffer" },
  }
}

M.lspconfig = {

  n = {
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "   lsp declaration",
    },

    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "   lsp definition",
    },

    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "   lsp hover",
    },

    ["<leader>lr"] = {
      function()
        require("nvchad.ui.renamer").open()
      end,
      "   lsp rename",
    },

  }
}

M.nvimtree = {
  n = {
    -- toggle
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "   toggle nvimtree" },

    ["l"] = {
      function()
        require("nvim-tree.config").nvim_tree_callback "edit"
      end,
      "   lsp rename",
    },

    ["h"] = {
      function()
        require("nvim-tree.config").nvim_tree_callback "close_node"
      end,
      "   lsp rename",
    },
  }
}

M.telescope = {
  n = {
    -- find
    ["<leader>f"] = { "<cmd> Telescope find_files <CR>", "  find files" },
    -- ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "  find all" },
    ["<leader>st"] = { "<cmd> Telescope live_grep <CR>", "   live grep" },
    ["<leader>sf"] = { "<cmd> Telescope buffers <CR>", "  find buffers" },

    -- ["<leader>tk"] = { "<cmd> Telescope keymaps <CR>", "   show keys" },

    -- git
    ["<leader>gb"] = { "<cmd> Telescope git_branches <CR>", "   git branches" },

    -- theme switcher
    ["<leader>sc"] = { "<cmd> Telescope themes <CR>", "   nvchad themes" },
  },
}

M.nvterm = {
  t = {
    -- toggle in terminal mode
    ["<C-t>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "   toggle floating term",
    },

  },

  n = {
    -- toggle in normal mode
    ["<C-t>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "   toggle floating term",
    },
  }
}


return M
