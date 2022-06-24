-- n, v, i, t = mode names

local function termcodes(str)
   return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local M = {}

M.general = {

   i = {
      -- go to normal mode
      ["jk"] = { "<C-c>", "normal mode" },
   },

   n = {

      ["<leader>h"] = { "<cmd> noh <CR>", "  no highlight" },

      ["<A-j>"] = { "<Esc>:m .+1<CR>==gi", " move text down" },
      ["<A-k>"] = { "<Esc>:m .-2<CR>==gi", " move text up" },

      -- switch between windows
      ["<C-h>"] = { "<C-w>h", " window left" },
      ["<C-l>"] = { "<C-w>l", " window right" },
      ["<C-j>"] = { "<C-w>j", " window down" },
      ["<C-k>"] = { "<C-w>k", " window up" },

      -- save
      ["<C-s>"] = { "<cmd> w <CR>", "﬚  save file" },

      -- Copy all
      -- ["<C-c>"] = { "<cmd> %y+ <CR>", "  copy whole file" },

      -- git
      ["<leader>gl"] = { ":Gitsigns blame_line<CR>", "  blame line" },

      -- Copy path
      ["<F4>"] = { ':let @+ = fnamemodify(expand("%"), ":~:.")<CR>', "copy relative path" },
      ["<F5>"] = { ":let @+ = expand('%:p')<CR>", "copy absolute path" },

      -- update nvchad
      ["<leader>uu"] = { "<cmd> :NvChadUpdate <CR>", "  update nvchad" },

      ["<leader>tt"] = {
         function()
            require("base46").toggle_theme()
         end,

         "   toggle theme",
      },
   },

   v = {
      -- move text
      ["<A-j>"] = { ":m .+1<CR>==", "move text down" },
      ["<A-k>"] = { ":m .-2<CR>==", "move text up" },
   },

   x = {
      ["J"] = { ":move '>+1<CR>gv-gv", "move text down" },
      ["K"] = { ":move '<-2<CR>gv-gv", "move text up" },
   },

   t = {
      ["<C-h>"] = { termcodes, "<C-\\><C-N><C-w>h", "   escape terminal mode" },
      ["<C-j>"] = { termcodes, "<C-\\><C-N><C-w>j", "   escape terminal mode" },
      ["<C-k>"] = { termcodes, "<C-\\><C-N><C-w>k", "   escape terminal mode" },
      ["<C-l>"] = { termcodes, "<C-\\><C-N><C-w>l", "   escape terminal mode" },
   },
}

M.bufferline = {

   n = {
      -- cycle through buffers
      ["<S-l"] = { "<cmd> BufferLineCycleNext <CR>", "  cycle next buffer" },
      ["<S-h>"] = { "<cmd> BufferLineCyclePrev <CR>", "  cycle prev buffer" },

      -- close buffer + hide terminal buffer
      ["<leader>c"] = {
         function()
            require("core.utils").close_buffer()
         end,
         "   close buffer",
      },
   },
}

M.comment = {

   -- toggle comment in both modes
   n = {
      ["<leader>/"] = {
         function()
            require("Comment.api").toggle_current_linewise()
         end,

         "蘒  toggle comment",
      },
   },

   v = {
      ["<leader>/"] = {
         "<ESC><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>",
         "蘒  toggle comment",
      },
   },
}

M.lspconfig = {
   -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

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

      -- ["li"] = {
      --    function()
      --       vim.lsp.buf.implementation()
      --    end,
      --    "   lsp implementation",
      -- },

      ["<leader>ls"] = {
         function()
            vim.lsp.buf.signature_help()
         end,
         "   lsp signature_help",
      },

      -- ["<leader>D"] = {
      --    function()
      --       vim.lsp.buf.type_definition()
      --    end,
      --    "   lsp definition type",
      -- },

      ["<leader>lr"] = {
         function()
            require("nvchad.ui.renamer").open()
         end,
         "   lsp rename",
      },

      -- ["<leader>ca"] = {
      --    function()
      --       vim.lsp.buf.code_action()
      --    end,
      --    "   lsp code_action",
      -- },

      -- ["gr"] = {
      --    function()
      --       vim.lsp.buf.references()
      --    end,
      --    "   lsp references",
      -- },

      ["gl"] = {
         function()
            vim.diagnostic.open_float()
         end,
         "   floating diagnostic",
      },

      -- ["[d"] = {
      --    function()
      --       vim.diagnostic.goto_prev()
      --    end,
      --    "   goto prev",
      -- },

      -- ["d]"] = {
      --    function()
      --       vim.diagnostic.goto_next()
      --    end,
      --    "   goto_next",
      -- },

      -- ["<leader>q"] = {
      --    function()
      --       vim.diagnostic.setloclist()
      --    end,
      --    "   diagnostic setloclist",
      -- },

      ["<leader>lf"] = {
         function()
            vim.lsp.buf.formatting()
         end,
         "   lsp formatting",
      },

      -- ["<leader>wa"] = {
      --    function()
      --       vim.lsp.buf.add_workspace_folder()
      --    end,
      --    "   add workspace folder",
      -- },

      -- ["<leader>wr"] = {
      --    function()
      --       vim.lsp.buf.remove_workspace_folder()
      --    end,
      --    "   remove workspace folder",
      -- },

      -- ["<leader>wl"] = {
      --    function()
      --       print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      --    end,
      --    "   list workspace folders",
      -- },
   },
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
   },
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

      -- ["<A-h>"] = {
      --    function()
      --       require("nvterm.terminal").toggle "horizontal"
      --    end,
      --    "   toggle horizontal term",
      -- },

      -- ["<A-v>"] = {
      --    function()
      --       require("nvterm.terminal").toggle "vertical"
      --    end,
      --    "   toggle vertical term",
      -- },
   },

   n = {
      -- toggle in normal mode
      ["<C-t>"] = {
         function()
            require("nvterm.terminal").toggle "float"
         end,
         "   toggle floating term",
      },

      -- ["<A-h>"] = {
      --    function()
      --       require("nvterm.terminal").toggle "horizontal"
      --    end,
      --    "   toggle horizontal term",
      -- },

      -- ["<A-v>"] = {
      --    function()
      --       require("nvterm.terminal").toggle "vertical"
      --    end,
      --    "   toggle vertical term",
      -- },
   },
}

M.whichkey = {
   n = {
      ["<leader>wK"] = {
         function()
            vim.cmd "WhichKey"
         end,
         "   which-key all keymaps",
      },
      ["<leader>wk"] = {
         function()
            local input = vim.fn.input "WhichKey: "
            vim.cmd("WhichKey " .. input)
         end,
         "   which-key query lookup",
      },
   },
}

M.blankline = {
   n = {
      ["<leader>bc"] = {
         function()
            local ok, start = require("indent_blankline.utils").get_current_context(
               vim.g.indent_blankline_context_patterns,
               vim.g.indent_blankline_use_treesitter_scope
            )

            if ok then
               vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
               vim.cmd [[normal! _]]
            end
         end,

         "  Jump to current_context",
      },
   },
}

return M
