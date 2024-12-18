local options = {
  expandtab = true,          -- convert tabs to spaces
  shiftwidth = 2,            -- the number of spaces inserted for each indentation
  smartindent = true,        -- make indenting smarter again

  clipboard = "unnamedplus", -- allows neovim to access the system clipboard

  hlsearch = false,          -- highlight all matches on previous search pattern
  incsearch = true,

  ignorecase = true, -- ignore case in search patterns
  mouse = "a",       -- allow the mouse to be used in neovim

  tabstop = 2,       -- insert 2 spaces for a tab
  cursorline = true, -- highlight the cursor line
  -- cursorlineopt = "number",
  number = true,     -- set numbered lines
  updatetime = 200,  -- faster completion (4000ms default)

  scrolloff = 8,
  sidescrolloff = 8,

  backup = false,                                  -- creates a backup file
  cmdheight = 1,                                   -- more space in the neovim command line for displaying messages
  completeopt = { "menu", "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 2,                                -- so that `` is visible in markdown files
  fileencoding = "utf-8",                          -- the encoding written to a file
  -- spelllang = "en",
  pumheight = 10,                                  -- pop up menu height
  showmode = false,                                -- we don't need to see things like -- INSERT -- anymore
  showtabline = 0,                                 -- always show tabs
  smartcase = true,                                -- smart case
  splitbelow = true,                               -- force all horizontal splits to go below current window
  splitright = true,                               -- force all vertical splits to go to the right of current window
  termguicolors = true,                            -- set term gui colors (most terminals support this)
  timeoutlen = 500,                                -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                                 -- enable persistent undo
  laststatus = 3,
  showcmd = false,
  relativenumber = true,          -- set relative numbered lines
  numberwidth = 2,                -- set number column width to 2 {default 4}
  -- colorcolumn = "80",
  wrap = true,                    -- display lines as one long line

  guifont = "JetBrains Mono:h16", -- the font used in graphical neovim applications
}

for k, v in pairs(options) do
  vim.opt[k] = v
end


vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
-- vim.cmd([[set spell]])
