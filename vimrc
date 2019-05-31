set nocompatible
filetype plugin indent on
let mapleader=" "

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')
Plug 'NLKNguyen/papercolor-theme'
Plug 'Valloric/YouCompleteMe'
Plug 'airblade/vim-gitgutter'
Plug 'chaoren/vim-wordmotion'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jreybert/vimagit'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'klund1/jumpsearch'
Plug 'klund1/vim-switchcase'
Plug 'leafgarland/typescript-vim'
Plug 'tpope/vim-fugitive'
call plug#end()

" YouCompleteMe configuration
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_always_populate_location_list = 1

" vimagit configuration
nnoremap <leader>m :call magit#show_magit('t')<cr>
let g:magit_auto_foldopen=1
let g:magit_default_fold_level=1
let g:magit_default_show_all_files=0
autocmd User VimagitEnterCommit setlocal textwidth=72
autocmd User VimagitLeaveCommit setlocal textwidth=0

" fzf configuration
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

"vim-wordmotion configuration
let g:wordmotion_prefix = '<leader>'

" vim-switchcase configuration
nnoremap <leader>cs :SwitchSnakeCase<cr>
nnoremap <leader>cS :SwitchCapitalSnakeCase<cr>
nnoremap <leader>cc :SwitchCamelCase<cr>
nnoremap <leader>cC :SwitchCapitalCamelCase<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Display Options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax on
set background=dark
colorscheme PaperColor
set cursorline
set scrolloff=3
set showtabline=2
set laststatus=2


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Statusline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! ErrorsMessage()
  let l:number_of_errors = len(getloclist(0))
  if l:number_of_errors == 0
    return ""
  endif
  return "[Errors]"
endfunction

set statusline= " Clear statusline
set statusline+=%f " Filename
set statusline+=\ %m%r%h%q " Modified, Read-Only,
set statusline+=\ %{ErrorsMessage()} " Adds [Errors] tag if there are errors
set statusline+=%= " Right align
set statusline+=%l,%c " Line, collumn
for i in range(10) " Add 10 spaces
  set statusline+=\ 
endfor
set statusline+=%P " Percent of file


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Line Numbering
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use relative line numbers in normal mode and absolute line numbers in insert
" mode.
set number
set rnu
autocmd InsertEnter * setlocal nornu
autocmd InsertLeave * setlocal rnu
autocmd InsertEnter * setlocal nohlsearch
autocmd InsertLeave * setlocal hlsearch lz
inoremap <silent><Esc> <Esc>:nohl<bar>set nolz<CR>
inoremap <silent><C-c> <C-c>:nohl<bar>set nolz<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Movement
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Line movement
nnoremap H ^
vnoremap H ^
nnoremap L $
vnoremap L $

let g:scroll_speed=5

function! ScrollUp()
  if line(".") <= (line("w0")+&scrolloff)
    exec "normal! ".g:scroll_speed."k"
  else
    exec "normal! H"
  endif
endfunction

function! ScrollDown()
  if line(".") >= (line("w$")-&scrolloff)
    exec "normal! ".g:scroll_speed."j"
  else
    exec "normal! L"
  endif
endfunction

" Top/Bottom of screen movement
nnoremap K :call ScrollUp()<cr>
vnoremap K H
nnoremap J :call ScrollDown()<cr>
vnoremap J L

" Tab movement
nnoremap tn gt
nnoremap tp gT
nnoremap tt gt

" Window movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searching
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set hlsearch
set noincsearch
noh
set wildmode=longest:full,full
set wildmenu
set ignorecase
set smartcase
nnoremap ,<space> :noh<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pasting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>p "0p
nnoremap <leader>P "0P
nnoremap <C-p> "+p
inoremap <C-p> <esc>"+pi


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Source and open vimrc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>r :source ~/.vimrc<cr>
nnoremap grc :tabe ~/.vimrc<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Git commit/diff options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd FileType gitcommit set spell
set diffopt+=vertical,filler


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Go-To File
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" gf    - open in buffer
" f     - open in vsplit
" F     - open in split
" <c-f> - open in tab
nnoremap f :vertical wincmd f<cr>
nnoremap F <c-w>f
nnoremap <c-f> <c-w>gf
" goto definition
set tags+=tags;/
nnoremap ]] :vsp <cr><c-w>l:exec("tag ".expand("<cword>"))<cr><c-w>h
nnoremap ]t :tab split <cr>:exec("tag ".expand("<cword>"))<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open related files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" TODO: use vim-projectionist

function! OpenFileVsplit(filename)
  execute 'vs' a:filename
endfunction
function! OpenFileTab(filename)
  execute 'tabe' a:filename
endfunction
function! HeaderFilename()
  return substitute(@%, '\(_test\)\?\.cc$', '\.h', '')
endfunction
function! ImplFilename()
  return substitute(@%, '\(\(_test\)\.cc\|\.h\)$', '\.cc', '')
endfunction
function! TestFilename()
  return substitute(@%, '\.\(h\|cc\)$', '_test\.cc', '')
endfunction
nnoremap gh :call OpenFileVsplit(HeaderFilename())<cr>
nnoremap gcc :call OpenFileVsplit(ImplFilename())<cr>
nnoremap gt :call OpenFileVsplit(TestFilename())<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Goto Error
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" TODO: Make this a plugin

function! PositionIsBefore(pos1, pos2)
  if a:pos1[0] != a:pos2[0]
    return a:pos1[0] < a:pos2[0]
  endif
  return a:pos1[1] < a:pos2[1]
endfunction

function! PositionIsAfter(pos1, pos2)
  if a:pos1[0] != a:pos2[0]
    return a:pos1[0] > a:pos2[0]
  endif
  return a:pos1[1] > a:pos2[1]
endfunction

function! PositionFromLocList(loc)
    return [a:loc.lnum, a:loc.col]
endfunction

function! ShowError(error_number)
  exec a:error_number . "ll"
endfunction

function! ShowNextError()
  let l:loc_list = getloclist(0)
  if len(l:loc_list) == 0
    echom "No Errors!"
    return
  endif
  let l:cursor_pos = [line("."), col(".")]
  let l:index = 1
  while l:index <= len(l:loc_list)
    let l:error_pos = PositionFromLocList(l:loc_list[l:index - 1])
    if PositionIsAfter(l:error_pos, l:cursor_pos)
      call ShowError(l:index)
      return
    endif
    let l:index = l:index + 1
  endwhile
  call ShowError(1)
endfunction

function! ShowPreviousError()
  let l:loc_list = getloclist(0)
  if len(l:loc_list) == 0
    echom "No Errors!"
    return
  endif
  let l:cursor_pos = [line("."), col(".")]
  let l:index = len(l:loc_list)
  while l:index > 0
    let l:error_pos = PositionFromLocList(l:loc_list[l:index - 1])
    if PositionIsBefore(l:error_pos, l:cursor_pos)
      call ShowError(l:index)
      return
    endif
    let l:index = l:index - 1
  endwhile
  call ShowError(len(l:loc_list))
endfunction

nnoremap ge :call ShowNextError()<cr>:ll<cr>
nnoremap gE :call ShowPreviousError()<cr>:ll<cr>
augroup clear_loc_list
  autocmd!
  autocmd BufWinEnter * call setloclist(0, [])
augroup END
