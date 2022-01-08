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
set mouse=a

" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

set guifont=Fira\ Code:h12


call plug#begin('~/.vim/plugged')
"JSX highlight
Plug 'maxmellon/vim-jsx-pretty'
Plug 'HerringtonDarkholme/yats.vim'

" Telescope
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Comments
Plug 'tpope/vim-commentary'

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

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Theme and colors
Plug 'morhetz/gruvbox'
Plug 'ful1e5/onedark.nvim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'norcalli/nvim-colorizer.lua'

" Icons
Plug 'ryanoasis/vim-devicons'
call plug#end()

" This was from the colorscheme section
lua require'colorizer'.setup()
colorscheme gruvbox
set background=dark

" Lua scripts
lua require("mf")

" Our remaps
let mapleader = " "

" NERDTree show hidden
let NERDTreeShowHidden=1

" Open file tree
nnoremap <leader>pv :NERDTreeToggle<CR>

" Rebuff init.vim
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>

" Search with fzf
nnoremap <C-p> :Telescope find_files<CR>
nnoremap <leader>ag :Telescope live_grep<CR>
nnoremap <leader>pf :Telescope buffers<CR>

" Save with ctrl + s
:nmap <c-s> :w<CR>
:imap <c-s> <Esc>:w<CR>a

" Save and paste buffer
vnoremap <leader>y "+y
noremap <leader>p "+p

" Copy relative path
noremap <silent> <F4> :let @+ = expand("%")<CR>

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

" Force suggestions
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Open html in firefox
nnoremap <F10> :exe ':silent !firefox %'<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Coc Configs
let g:coc_global_extensions = ['coc-solargraph', 'coc-json', 'coc-tsserver', 'coc-prettier', 'coc-python', 'coc-vimlsp', 'coc-tabnine']

" Setup Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Set font adjust size
let s:fontsize = 12
function! AdjustFontSize(amount)
  let s:fontsize = s:fontsize+a:amount
  :execute "GuiFont! Consolas:h" . s:fontsize
endfunction

" In normal mode, pressing numpad's+ increases the font
noremap <kPlus> :call AdjustFontSize(1)<CR>
noremap <kMinus> :call AdjustFontSize(-1)<CR>

" In insert mode, pressing ctrl + numpad's+ increases the font
inoremap <C-kPlus> <Esc>:call AdjustFontSize(1)<CR>a
inoremap <C-kMinus> <Esc>:call AdjustFontSize(-1)<CR>a
