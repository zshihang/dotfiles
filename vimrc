unlet! skip_defaults_vim
silent! source $VIMRUNTIME/defaults.vim

"------------------------------------------------------------------------------
"------------------------------------------------------------------------------
" ## PLUGINS #
"------------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

" edit
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' " . to repeat last command
Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }
Plug 'terryma/vim-expand-region'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Raimondi/delimitMate'
Plug 'ntpeters/vim-better-whitespace'

" view
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-gtfo'

" navigate
Plug '/usr/local/opt/fzf' " installed fzf using brew
" Plug '~/.fzf' " installed fzf using git
Plug 'junegunn/fzf.vim'

" code
 Plug 'jsfaint/gen_tags.vim'
 Plug 'w0rp/ale'
 Plug 'ervandew/supertab'
 Plug 'tpope/vim-commentary'
 Plug 'michaeljsmith/vim-indent-object' " ai, ii, aI, iI

" vcs
 Plug 'airblade/vim-gitgutter'
 Plug 'tpope/vim-fugitive'

" tools
Plug 'tyru/open-browser.vim'
Plug 'zerowidth/vim-copy-as-rtf'
" Plug 'beloglazov/vim-online-thesaurus' not working now

" appearance
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'

" themes
Plug 'jnurmine/Zenburn'
Plug 'morhetz/gruvbox'
Plug 'AlessandroYorba/Despacio'
Plug 'romainl/Apprentice'
Plug 'junegunn/seoul256.vim'

" c/c++
Plug 'bfrg/vim-cpp-modern', { 'for': ['c', 'cpp'] }
Plug 'lyuts/vim-rtags', { 'for': ['c', 'cpp'] }

" markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'wookayin/vim-typora', { 'for': 'markdown'}

" latex
Plug 'lervag/vimtex', { 'for': 'tex' }

" python
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
Plug 'kh3phr3n/python-syntax'
Plug 'mindriot101/vim-yapf', { 'for': 'python' }

" java
Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }

" golang
Plug 'fatih/vim-go', { 'for': 'go'}

call plug#end()


"------------------------------------------------------------------------------
"------------------------------------------------------------------------------
" ## BASIC #
"------------------------------------------------------------------------------

let mapleader = ' '
let maplocalleader = ' '

" theme
" set background=dark
colo zenburn

" define command group
augroup vimrc
    autocmd!
augroup END

" turn on true color
" if has('termguicolors')
"   let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"   let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"   set termguicolors
" endif

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


"------------------------------------------------------------------------------
"------------------------------------------------------------------------------
" ## KEY MAPPINGS #
"------------------------------------------------------------------------------

nnoremap ; :
nnoremap <leader>; ;
nnoremap 0 ^
cnoremap $v e ~/.vimrc
cnoremap $n e ~/Dropbox/Notes/

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


"------------------------------------------------------------------------------
"------------------------------------------------------------------------------
" ## HANDY SCRIPTS #
"------------------------------------------------------------------------------

" google / lucky
function! s:goog(pat, lucky)
    let q = '"'.substitute(a:pat, '["\n]', ' ', 'g').'"'
    let q = substitute(q, '[[:punct:] ]',
                \ '\=printf("%%%02X", char2nr(submatch(0)))', 'g')
    call system(printf('open "https://www.google.com/search?%sq=%s"',
                \ a:lucky ? 'btnI&' : '', q))
endfunction

nnoremap <leader>? :call <SID>goog(expand("<cWORD>"), 0)<cr>
nnoremap <leader>! :call <SID>goog(expand("<cWORD>"), 1)<cr>
xnoremap <leader>? "gy:call <SID>goog(@g, 0)<cr>gv
xnoremap <leader>! "gy:call <SID>goog(@g, 1)<cr>gv))']')'"'

" a.vim
function! s:a(cmd)
  let name = expand('%:r')
  let ext = tolower(expand('%:e'))
  let sources = ['c', 'cc', 'cpp', 'cxx']
  let headers = ['h', 'hh', 'hpp', 'hxx']
  for pair in [[sources, headers], [headers, sources]]
    let [set1, set2] = pair
    if index(set1, ext) >= 0
      for h in set2
        let aname = name.'.'.h
        for a in [aname, toupper(aname)]
          if filereadable(a)
            execute a:cmd a
            return
          end
        endfor
      endfor
    endif
  endfor
endfunction
command! A call s:a('e')
command! AV call s:a('botright vertical split')

" theme switcher
function! s:colors(...)
endfunction
function! s:rotate_colors()
  if !exists('s:colors')
    let s:colors = filter(map(filter(split(globpath(&rtp,
                   \                                'colors/*.vim'),
                   \                       "\n"),
                   \                 'v:val !~ "^/usr/"'),
                   \          'fnamemodify(v:val, ":t:r")'),
                   \      '!a:0 || stridx(v:val, a:1) >= 0')
  endif
  let name = remove(s:colors, 0)
  call add(s:colors, name)
  execute 'colorscheme' name
  redraw
  echo name
endfunction
nnoremap <silent> <F8> :call <SID>rotate_colors()<cr>


"------------------------------------------------------------------------------
"------------------------------------------------------------------------------
" ## PLUGIN SETTINGS #
"------------------------------------------------------------------------------

" @open-browser
let g:netrw_nogx = 1
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" @python-syntax
let g:python_highlight_all = 1

" @tagbar
inoremap <F9> <esc>:TagbarToggle<cr>
nnoremap <F9> :TagbarToggle<cr>
let g:tagbar_sort = 0

" @ale
let g:ale_python_flake8_options = '--ignore=E501,E402,E226'
let g:ale_lint_on_text_changed = 'never'
let g:ale_set_signs = 0
let g:ale_set_loclist = 0
let g:ale_set_balloons = -2
let g:ale_echo_msg_format = '[%linter%]: %s'
nmap <silent> <leader>p <Plug>(ale_previous_wrap)
nmap <silent> <leader>n <Plug>(ale_next_wrap)

" @vim-markdown
"let g:vim_markdown_folding_style_pythonic = 1
    "let g:vim_markdown_folding_level = 6
let g:vim_markdown_folding_disabled = 1
au BufRead,BufNewFile *.md setlocal wrap

" @vim-gen_tags
let g:loaded_gentags#gtags = 1
let g:gen_tags#blacklist = ['$HOME']

" @vim-go
let g:go_fmt_autosave = 0
autocmd FileType go inoremap <c-n> <c-x><c-o>

" @fzf.vim
nnoremap <silent> <Leader><Leader> :Files<cr>
nnoremap <silent> <Leader>C        :Colors<cr>
nnoremap <silent> <Leader><Enter>  :Buffers<cr>
nnoremap <silent> <Leader>l        :Lines<cr>
nnoremap <silent> <Leader>ag       :Ag <c-r><c-w><cr>
nnoremap <silent> <leader>ag       :Ag <c-r><c-a><cr>
xnoremap <silent> <leader>ag       y:Ag <c-r>"<cr>
nnoremap <silent> <Leader>`        :Marks<cr>

" @vim-mundo
set undofile
set undodir=~/.vim/undo
nnoremap U :MundoToggle<cr>
if has('python3')
    let g:mundo_prefer_python3 = 1
endif

" @vim-better-whitespace
nnoremap <leader>W :StripWhitespace<cr>
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
      \             ['fugitive', 'readonly', 'filename', 'modified'] ],
      \   'right': [ [ 'lineinfo' ], ['percent'],  ['linter_errors', 'linter_warnings'] ]
      \ },
      \ 'tabline': {
      \   'left': [ [ 'tabs' ] ],
      \   'right': [ [ 'close' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"x":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}',
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())',
      \ },
      \  'component_expand': {
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \ },
      \  'component_type': {
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }

