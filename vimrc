let mapleader=" "


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin(stdpath('config') . '/plugged')

" Copilot
Plug 'github/copilot.vim'

" Code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
set hidden
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Map <tab> for trigger completion, completion confirm, snippet expand and jump
inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#_select_confirm() :
  \ coc#expandableOrJumpable() ?
  \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

inoremap <silent><expr> <C-s> "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>"


" Use `[e` and `]e` to navigate diagnostics
nmap <silent> [w <Plug>(coc-diagnostic-prev)
nmap <silent> ]w <Plug>(coc-diagnostic-next)
nmap <silent> [e <Plug>(coc-diagnostic-prev-error)
nmap <silent> ]e <Plug>(coc-diagnostic-next-error)

command! Rename exec "normal <Plug>(coc-rename)"

" Remap keys for gotos
nmap <silent> gd :call CocAction('jumpDefinition', 'vsplit')<cr>
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gh :vs<cr>:CocCommand clangd.switchSourceHeader<cr>
nmap <silent> gcc :vs<cr>:CocCommand clangd.switchSourceHeader<cr>
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
nmap <silent> <c-i> :call CocActionAsync('doHover')<cr>

" Build, Run, etc.
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
let g:asyncrun_open = 6
let g:asyncrun_rootmarks = ['.git']
let g:asynctasks_term_pos = 'right'
nmap <silent> <c-b>p :AsyncTask project-build<cr>
nmap <silent> <c-b><c-b> :AsyncTask file-build<cr>
nmap <silent> <c-b>f :AsyncTask file-build<cr>
nmap <silent> <c-b>r :AsyncTask file-build-run<cr>
command! Run AsyncTask file-build-run

" Code formatting
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
augroup autoformat_settings
  autocmd FileType c,cpp,cuda AutoFormatBuffer clang-format
  autocmd FileType javascript,typescript,javascriptreact,typescriptreact AutoFormatBuffer prettier
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType html,css,sass,scss,less AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  " autocmd FileType python AutoFormatBuffer "black -l 79"
  autocmd FileType rust AutoFormatBuffer rustfmt
  autocmd FileType sh,zsh AutoFormatBuffer shfmt
augroup END

" make window navigation work with tmux
Plug 'christoomey/vim-tmux-navigator'

" Fuzzy finding
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
let g:fzf_action = {
  \ 'ctrl-o': 'edit',
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_buffers_jump = 1
let g:fzf_layout = { 'down': '10%' }
nnoremap <leader>f :Files<cr>
nnoremap <leader>o :Buffers<cr>

" Moving through words
Plug 'chaoren/vim-wordmotion'
let g:wordmotion_prefix = '<leader>'

" CamelCase -> snake_case, etc.
Plug 'klund1/vim-switchcase'
nnoremap <leader>cs :SwitchSnakeCase<cr>
nnoremap <leader>cS :SwitchCapitalSnakeCase<cr>
nnoremap <leader>cc :SwitchCamelCase<cr>
nnoremap <leader>cC :SwitchCapitalCamelCase<cr>

" Colorscheme
Plug 'EdenEast/nightfox.nvim'
Plug 'NLKNguyen/papercolor-theme'
let g:PaperColor_Theme_Options = {
 \  'theme': {
 \    'default.dark': {
 \      'override': {
 \        'diffdelete_fg':['#808080', ''],
 \        'diffdelete_bg':['#3a3a3a', ''],
 \      }
 \    }
 \  }
 \}

" Git
Plug 'tpope/vim-fugitive'
Plug 'sindrets/diffview.nvim'

" Searching
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'jremmen/vim-ripgrep'
let g:rg_command = 'rg --hidden --vimgrep -S'

" Rust
Plug 'rust-lang/rust.vim'

" Better * behavior
Plug 'haya14busa/vim-asterisk'
map * <Plug>(asterisk-z*)
map # <Plug>(asterisk-z#)
map g* <Plug>(asterisk-zg*)
map g# <Plug>(asterisk-zg#)

" CamelCase spellcheck
" Plug 'kamykn/spelunker.vim'
" Plug 'kamykn/popup-menu.nvim'
" set nospell

" Typescript
Plug 'leafgarland/typescript-vim'
let g:typescript_indent_disable = 1

" WGSL
Plug 'DingDean/wgsl.vim'

call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Display Options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

colorscheme PaperColor
" colorscheme carbonfox
set cursorline

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Statusline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set statusline= " Clear statusline
set statusline+=%f " Filename
set statusline+=\ %m%r%h%q " Modified, Read-Only,
set statusline+=\ %{coc#status()}%{get(b:,'coc_current_function','')} " CoC status
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
autocmd TermEnter * setlocal nonumber nornu
autocmd TermLeave * setlocal number rnu

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pasting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>p "0p
nnoremap <leader>P "0P
nnoremap <C-p> "+p
inoremap <C-p> <esc>"+pi
nnoremap <C-y> "+y
vnoremap <C-y> "+y

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searching
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set wildmode=longest:full,full
set wildmenu
set ignorecase
set smartcase
nnoremap ,<space> :noh<cr>

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
  let l:original_line = line(".")
  exec "normal! H"
  if l:original_line == line(".")
    exec "normal! ".g:scroll_speed."k"
  endif
endfunction

function! ScrollDown()
  let l:original_line = line(".")
  exec "normal! L"
  if l:original_line == line(".")
    exec "normal! ".g:scroll_speed."j"
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

tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4
set shiftwidth=4
set expandtab

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" For-Each-Window commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

command! W windo w
command! Q windo q
command! WQ windo wq

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Source and open config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>r :source ~/.config/nvim/init.vim<cr>
nnoremap grc :tabe ~/.config/nvim/init.vim<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Number Manipulation
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap + <c-a>
nnoremap - <c-x>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text wrapping
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd FileType txt,tex set tw=80
autocmd FileType txt,tex set fo+=a

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Terminal
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

tnoremap <silent> <esc><esc> <c-\><c-n>
if has('nvim')
  autocmd TermClose * call feedkeys("\<c-\>\<c-n>")
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Reflow
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! Reflow(start_line, end_line)

  silent! exec a:end_line.','.a:end_line.'yank x'
  let end_line_text=@x

  let start = string(a:start_line)
  let end = string(a:end_line - 1)

  let modified_lines=0

  if (end_line_text =~ '^\s*//\+.*')
    silent! exec start.','.end.'s:\n\s*//\+::g'
    let modified_lines=1
  elseif (end_line_text =~ '^\s*".*')
    silent! exec start.','.end.'s/"\s*\n\s*"//g'
    let modified_lines=1
  elseif (end_line_text =~ '^\s*''.*')
    silent! exec start.','.end.'s/''\s*\n\s*''//g'
    let modified_lines=1
  endif

  if (modified_lines)
    silent! exec a:start_line.','.a:start_line.'FormatLines'
  endif
endfunction

function! ReflowRange() range 
  call Reflow(a:firstline, a:lastline)
endfunction

function! ReflowOpfunction(type)
  call Reflow(line("'['"), line("']'"))
endfunction

nnoremap <c-x> :set opfunc=ReflowOpfunction<cr>g@
vnoremap <c-x> :call ReflowRange()<cr>

function! ToggleComment(start_line, end_line)
  silent! exec a:start_line.','.a:start_line.'yank x'
  let start_line_text=@x
  let range=string(a:start_line).','.string(a:end_line)
  if (start_line_text =~ '^\s*///\? \?')
    silent! exec range.'s:^\s*\zs///\? \?::'
  else
    let indent = indent(a:start_line)
    silent! exec range.'s:^\s\{,'.indent.'}\zs\ze:// :'
  endif
endfunction

function! ToggleCommentRange() range 
  call ToggleComment(a:firstline, a:lastline)
endfunction

function! ToggleCommentOpfunction(type)
  call ToggleComment(line("'['"), line("']'"))
endfunction


nnoremap <c-c><c-c> :call ToggleComment(line('.'), line('.'))<cr>
nnoremap <c-c> :set opfunc=ToggleCommentOpfunction<cr>g@
vnoremap <c-c> :call ToggleCommentRange()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Templates
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! GetParentDirectories()
  let path=substitute(expand('%:p'), "[^/]*$", "", "")
  let paths=[]
  while (len(path) > 0)
    call add(paths, path)
    let path = substitute(path, "[^/]*/$", "", "")
  endwhile
  return paths
endfunction

function! ReadFromTemplate()
  for path in GetParentDirectories()
    let template_file = path . '.template_generator'
    if filereadable(template_file)
      exec "0r !".template_file." %:p"
      return
    endif
  endfor
endfunction

autocmd! BufNewFile * call ReadFromTemplate()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Merge conflict resolution
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! DiffGetFromRight()
  let window=winnr()
  exec "wincmd l"
  let bufname = bufname()
  exec window."wincmd w"
  exec "diffget ".bufname
  exec "diffupdate"
endfunction

function! DiffGetFromLeft()
  let window=winnr()
  exec "wincmd h"
  let bufname = bufname()
  exec window."wincmd w"
  exec "diffget ".bufname
  exec "diffupdate"
endfunction

nnoremap <c-g>l :call DiffGetFromRight()<cr>
nnoremap <c-g>h :call DiffGetFromLeft()<cr>

function! ToggleDiff()
  if &diff == 0
    windo diffthis
    windo set scrollbind
    windo set cursorbind
  else
    windo diffoff
    windo set noscrollbind
    windo set nocursorbind
  endif
endfunction

nnoremap <c-d> :call ToggleDiff()<cr>
nnoremap <c-g>d :Gvdiffsplit<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fix syntax highlighting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufEnter * :syntax sync fromstart

