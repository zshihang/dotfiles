"------------------------------------------
" ##### plugins
call plug#begin('~/.vim/plugged')

" development tools
Plug 'w0rp/ale'
Plug 'ervandew/supertab'
Plug 'majutsushi/tagbar'
Plug 'justinmk/vim-dirvish'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug '/usr/local/opt/fzf' " install fzf using brew
" Plug '~/.fzf' " install fzf using git
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'ludovicchabant/vim-gutentags'
Plug 'jmcantrell/vim-virtualenv'
Plug 'tyru/open-browser.vim'

" edit tools
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'sjl/gundo.vim'
Plug 'terryma/vim-expand-region'
Plug 'michaeljsmith/vim-indent-object'
Plug 'Raimondi/delimitMate'
Plug 'ntpeters/vim-better-whitespace'
Plug 'nathanaelkane/vim-indent-guides'

" markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'wookayin/vim-typora', { 'for': 'markdown'}

" latex
Plug 'lervag/vimtex', { 'for': 'tex' }

" python
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
Plug 'hdima/python-syntax', { 'for': 'python' }
Plug 'mindriot101/vim-yapf', { 'for': 'python' }

" java
Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }

" go
Plug 'fatih/vim-go', { 'for': 'go'}

" color schemes
Plug 'jnurmine/Zenburn'

call plug#end()

set background=dark
set t_Co=256
colorscheme zenburn
set t_ZH=[3m
set t_ZR=[23m
highlight Comment cterm=italic


"------------------------------------------
" ##### general

set nocompatible
let mapleader = ","
let g:mapleader = ","
set nomodeline                  " disable modeline
set autoread                    " automatically reload files changed outside of Vim
set wildmenu
"set wildmode=list:full          " list all matches and complete first match when more than one match
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif
set nobackup                    " no backup files
set nowritebackup               " do not backup before overwriting a file
set noswapfile                  " do not write annoying intermediate swap files
set ignorecase                  " ignore case when searching
set smartcase
set showcmd                     " shows visual selection info
set magic                       " the special characters that can be used in search patterns
set noerrorbells                " no error bell
set visualbell t_vb=            " no beeping
set timeoutlen=500              " time in milliseconds that is waited for a key code or mapped key sequence to complete
if has("gui_macvim")            " no annoying sound on errors
    autocmd GUIEnter * set vb t_vb=
endif
set history=500                 " allow more history remembered
set clipboard=unnamed           " global clipboard
set completeopt=menu


"------------------------------------------
" ##### edit

set noshowmode                  " do not show what mode because we already have statusline
set tabstop=4                   " a tab is four spaces
set shiftwidth=4                " number of spaces to use for each step of (auto)indent
set expandtab                   " use the appropriate number of spaces to insert a tab
set softtabstop=4               " when using <BS>, four spaces are considered a tab
set smarttab                    " insert blanks according to shiftwidth
set shiftround                  " round indent to multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " autoindent on
set copyindent                  " copy the indentation of the existing lines when autoindenting a new line
set showmatch                   " show matching parenthesis
set matchtime=2                 " tenths of a second to show the matching paren
set virtualedit=all             " allow the cursor to go in to invalid place
set gdefault                    " all matches in a line are substituted instead of one
set foldenable                  " enable folding
set foldcolumn=1                " add a fold column

"------------------------------------------
" ##### UI

set scrolloff=9                 " nine number of screen lines to keep above and below the cursor
set relativenumber              " show relative line number
set number                      " show line number
set ruler                       " show cursor position
set cmdheight=2                 " two lines for the command-line
set hidden                      " buffers become hidden when abandoned
set hlsearch                    " highlight all matches
set incsearch                   " show matches as typing
set textwidth=500               " at most 500 chars a line
set linebreak                   " wrap long lines
set nowrap                      " do not wrap lines
set nolist                      " do not show invisible characters
set lazyredraw                  " do not update the display while executing macros
set encoding=utf8
set laststatus=2                " always show statusline
set guifont=Hack:h12,Menlo:h12
set switchbuf=usetab
set ambiwidth=double            " must have for unicode
set conceallevel=2              " conceal except current line


"------------------------------------------
" ##### mapping

nmap <leader>w :w!<cr>
inoremap ii <esc>
" fasten entering command
nnoremap ; :
nnoremap <leader>; ;
" remap search
map <space> /
map <c-space> ?
" stop highlighing of matches
map <silent> <leader><cr> :nohlsearch<cr>
" buffer mannagement
map <leader>q :bd!<CR>
map <leader>ba :bufdo bd<cr>
map <leader>bh :bprevious<cr>
map <leader>bl :bnext<cr>
" tab management
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>th :tabprevious<cr>
map <leader>tl :tabnext<cr>
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
" toggle between last accessed tab and current one
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()
" remap
map 0 ^
" for scratch
map <leader>e :e ~/workplace/tmp/buffer.md<cr>
" no gui elements
set guioptions=
" command line
cno $v e ~/.vimrc
" toggle show/hide invisible chars
nnoremap <leader>i :set list!<cr>
" fasten scrolling
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>
nnoremap <leader>b Oimport pdb; pdb.set_trace()<Esc>
" move lines
nnoremap gj :m .+1<CR>==
nnoremap gk :m .-2<CR>==
vnoremap gj :m '>+1<CR>gv=gv
vnoremap gk :m '<-2<CR>gv=gv


"------------------------------------------
" ##### plugins settings

" @tagbar
nmap <F8> :TagbarToggle<CR>

" @open-browser
let g:netrw_nogx = 1
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" @ale
let g:ale_python_flake8_options = '--ignore=E501,E402,E226'
let g:ale_lint_on_text_changed = 'never'
let g:ale_set_signs = 0
let g:ale_set_loclist = 0
let g:ale_set_balloons = -2
let g:ale_statusline_format = ['E:%d', 'W:%d', '']
let g:ale_echo_msg_format = '[%linter%]: %s'
nmap <silent> <leader>p <Plug>(ale_previous_wrap)
nmap <silent> <leader>n <Plug>(ale_next_wrap)

" @vim-markdown
"let g:vim_markdown_folding_style_pythonic = 1
"let g:vim_markdown_folding_level = 6
let g:vim_markdown_folding_disabled = 1
au BufRead,BufNewFile *.md setlocal wrap

" @vim-go
let g:go_fmt_autosave = 0
autocmd FileType go inoremap <c-n> <c-x><c-o>

" @virtualenv
let g:virtualenv_stl_format = '(%n)'

" @python-syntax
let python_highlight_all = 1

" @nerdtree
let g:NERDTreeWinPos = "right"
let g:NERDTreeWinSize=35
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>

" @fzf.vim
map <c-p> :Files<cr>
map <c-b> :Buffers<cr>
map <c-t> :BTags<cr>
map <c-l> :BLines<cr>

" @gundo
nnoremap <leader>u :GundoToggle<CR>
if has('python3')
    let g:gundo_prefer_python3 = 1
endif

" @vim-better-whitespace
nnoremap <leader>W :StripWhitespace<CR>
" autocmd BufEnter * EnableStripWhitespaceOnSave

" @jedi-vim
let g:jedi#completions_command = "<c-n>"
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = 2
let g:jedi#usages_command = ""
let g:jedi#popup_select_first = 0

" @gutentags
 let g:gutentags_project_root = ['build.xml']
 let g:gutentags_cache_dir = "~/.tagsfiles/"

" @vim-javacomplete2
autocmd FileType java setlocal omnifunc=javacomplete#Complete
autocmd FileType java inoremap <c-n> <c-x><c-o>

" @vim-yapf
nnoremap <leader>y :Yapf<cr>
" let g:yapf_style = "google"

" @lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['fugitive', 'readonly', 'filename', 'modified', 'virtualenv', 'gutentags'] ],
      \   'right': [ [ 'lineinfo' ], ['percent'],  ['linter_errors', 'linter_warnings', 'linter_ok'] ]
      \ },
      \ 'tabline': {
      \   'left': [ [ 'tabs' ] ],
      \   'right': [ [ 'close' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"x":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}',
      \   'virtualenv': '%{virtualenv#statusline()}',
      \   'gutentags': '%{gutentags#statusline()}',
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())',
      \ },
      \  'component_expand': {
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ },
      \  'component_type': {
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }

