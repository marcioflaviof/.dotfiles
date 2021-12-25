set scrolloff=8
set number
set tabstop=4 softtabstop=4
set shiftwidth=2
set expandtab
set smartindent
set termguicolors
set nohlsearch
set autoread
set completeopt-=preview

" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

call plug#begin('~/.vim/plugged')
" Fuzzy finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Auto pairs generate
" Plug 'jiangmiao/auto-pairs'

" Navigation tree
Plug 'preservim/nerdtree'

" Js & Ruby Completions
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Ruby
Plug 'vim-ruby/vim-ruby'

" Git in vim
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'

" Better syntax support
Plug 'sheerun/vim-polyglot'

" Theme and colors
Plug 'navarasu/onedark.nvim'
Plug 'norcalli/nvim-colorizer.lua'
call plug#end()

" This was from the colorscheme section
lua require'colorizer'.setup()
colorscheme onedark
set background=dark

" Our remaps
let mapleader = " "

" Open file tree
nnoremap <leader>pv :NERDTreeToggle<CR>

" Rebuff init.vim
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>

" Search with fzf
nnoremap <C-p> :Telescope find_files<CR>
nnoremap <leader>ag :Telescope grep_string<CR>
nnoremap <leader>pf :Telescope buffers<CR>

" Save with ctrl + s
:nmap <c-s> :w<CR>
:imap <c-s> <Esc>:w<CR>a

" Save to buffer
vnoremap <leader>y "+y

" move 1 line down
vnoremap J :m '>+1<CR>gv=gv

" move 1 line above
vnoremap K :m '<-2<CR>gv=gv

nnoremap Y y$

" Vim fugitive remaps
nmap <leader>gs :G<CR>

" Format file
nmap <leader>f <Plug>(coc-format)

" Go to definition
nmap <leader>gd <Plug>(coc-definition)

" Coc Configs
let g:coc_global_extensions = ['coc-solargraph', 'coc-json', 'coc-tsserver', 'coc-prettier', 'coc-python', 'coc-vimlsp']

" Setup Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile


