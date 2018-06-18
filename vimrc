unlet! skip_defaults_vim
silent! source $VIMRUNTIME/defaults.vim

"------------------------------------------
" ##### plugins
call plug#begin('~/.vim/plugged')

" minimal setting
Plug 'tpope/vim-sensible'

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
" ##### BASIC

let mapleader = ' '
let maplocalleader = ' '

" define command group
augroup vimrc
      autocmd!
augroup END

set number
set nomodeline
set autoindent
set smartindent
set lazyredraw                  " do not update the display while executing macros
set laststatus=2                " always show statusline
set showcmd                     " shows visual selection info
set visualbell t_vb=            " no beeping
set backspace=indent,eol,start
set timeoutlen=500              " time in milliseconds that is waited for a key code or mapped key sequence to complete
set shortmess=aIT               " short message
set hlsearch
set incsearch
set hidden                      " buffers become hidden when abandoned
set ignorecase                  " ignore case when searching
set smartcase
set wildmenu
set wildmode=full
set tabstop=4                   " a tab is four spaces
set shiftwidth=4                " number of spaces to use for each step of (auto)indent
set expandtab                   " use the appropriate number of spaces to insert a tab
set smarttab                    " insert blanks according to shiftwidth
set scrolloff=9
set encoding=utf-8
set virtualedit=block           " allow virtual editing only in visual block mode
set nolist                      " do not show invisible characters
set nojoinspaces
set diffopt=filler,vertical
set autoread
set clipboard=unnamed           " global clipboard
set foldlevelstart=99           " start editing with no folds closed
set completeopt=menuone,preview
silent! set cryptmethod=blowfish2
set noshowmode                  " do not show what mode because we already have statusline
set history=500                 " allow more history remembered
set softtabstop=4               " when using <BS>, four spaces are considered a tab
set shiftround                  " round indent to multiple of shiftwidth when indenting with '<' and '>'
set showmatch                   " show matching parenthesis
set matchtime=2                 " tenths of a second to show the matching paren
set complete-=i                 " dont scan the current and included files
set colorcolumn=80
set nostartofline
set directory=/tmp//,.
set backupdir=/tmp//,.
set undodir=/tmp//,.
silent! set ttymouse=xterm2
set mouse=a


"------------------------------------------
" ##### key mappings

nnoremap ; :
nnoremap <leader>; ;
nnoremap 0 ^
cnoremap $v e ~/.vimrc

" save
inoremap <C-s>     <C-O>:update<cr>
nnoremap <C-s>     :update<cr>
nnoremap <leader>s :update<cr>
nnoremap <leader>w :update<cr>

" open new line below and above current line
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

" quit
inoremap <C-Q>     <esc>:q<cr>
nnoremap <C-Q>     :q<cr>
vnoremap <C-Q>     <esc>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>Q :qa!<cr>

" movement in insert mode
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>a
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-^> <C-o><C-^>

" quickfix
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz

" buffer
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" for scratch
map <leader>e :e ~/workplace/tmp/buffer.md<cr>

" fasten scrolling
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

" move lines
nnoremap <silent> <C-k> :move-2<cr>
nnoremap <silent> <C-j> :move+<cr>
nnoremap <silent> <C-h> <<
nnoremap <silent> <C-l> >>
xnoremap <silent> <C-k> :move-2<cr>gv
xnoremap <silent> <C-j> :move'>+<cr>gv
xnoremap <silent> <C-h> <gv
xnoremap <silent> <C-l> >gv
xnoremap < <gv
xnoremap > >gv


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

