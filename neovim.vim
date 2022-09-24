if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-surround'

Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }

Plug 'editorconfig/editorconfig-vim'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'edkolev/tmuxline.vim'

Plug 'tpope/vim-commentary'

" Themes
Plug 'marko-cerovac/material.nvim'

Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'HerringtonDarkholme/yats.vim/', { 'for': 'typescript' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'keith/swift.vim', { 'for': 'swift' }
Plug 'cstrahan/vim-capnp', { 'for': 'capnp' }

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}

" Plug 'dense-analysis/ale'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'neovim/nvim-lspconfig'
call plug#end()

" Automatically install plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

" Use dedicated virtualenv for neovim
let g:python3_host_prog = '~/.pyenv/versions/neovim/bin/python'

set background=dark
set expandtab
set shiftwidth=2
set softtabstop=2
set number
set clipboard+=unnamedplus
set autoread
set statusline+=%#warningmsg#
set statusline+=%*
set mouse=a

" Theme
if (has("termguicolors"))
 set termguicolors
endif
syntax enable

let g:material_style = "palenight"
colorscheme material

" Airline theme
" let g:airline_theme='oceanicnext'
let g:airline_powerline_fonts=1
let g:jsx_ext_required = 0

" Airline top tab/buffer bar
let g:airline#extensions#tabline#enabled=1
" Only show filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_nr_show = 1

set undodir=~/.config/vim/undodir
set undofile

nnoremap <F4> :NvimTreeToggle<CR>

" disable f1 help
nmap <F1> <nop>

" fzf config
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" ctrl-p fzf
nnoremap <C-P> :Files<CR>

" navigate windows from all pane types
:tnoremap <A-h> <C-\><C-N><C-w>h
:tnoremap <A-j> <C-\><C-N><C-w>j
:tnoremap <A-k> <C-\><C-N><C-w>k
:tnoremap <A-l> <C-\><C-N><C-w>l
:inoremap <A-h> <C-\><C-N><C-w>h
:inoremap <A-j> <C-\><C-N><C-w>j
:inoremap <A-k> <C-\><C-N><C-w>k
:inoremap <A-l> <C-\><C-N><C-w>l
:nnoremap <A-h> <C-w>h
:nnoremap <A-j> <C-w>j
:nnoremap <A-k> <C-w>k
:nnoremap <A-l> <C-w>l

lua require('setup')
