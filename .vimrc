set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

""
" Display Options
syntax enable
colorscheme molokai
set number
set so=3

""
" Movement remapping
nnoremap j gj
nnoremap k gk
nnoremap J L
nnoremap K H
nnoremap H ^
nnoremap L $
nnoremap <c-j> <c-y>
nnoremap <c-k> <c-e>

""
" Change leader + leader commands
let mapleader=","
inoremap <leader>. <esc>
nnoremap <leader>p "0p
nnoremap <leader>P "0P

""
" Search options
set hlsearch
noh
nnoremap <leader><space> :noh<cr>
set wildmenu
set ic
set smartcase

""
" Split window options
nnoremap <leader>w <c-w>

""
" Enable mouse
set mouse=a

""
" Airline Options
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'luna'

""
" File specific options
au BufWritePost *.tex call PdfLatex()
au FileType tex set spell

function! PdfLatex()
  silent !latexmk -pdf -interaction=nonstopmode % > .pdflatex_log
  redraw!
  if v:shell_error
    !cat .pdflatex_log
  endif
endfunction

""
" Spellcheck shortcuts
nnoremap <leader>s ms[sz=1<cr>`s
inoremap <leader>s <esc>ms[sz=1<cr>`sa

""
" Tabs
set tabstop=2
set softtabstop=0 expandtab
set shiftwidth=2
