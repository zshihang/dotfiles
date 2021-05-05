" vim: set foldmethod=marker foldlevel=1:

unlet! skip_defaults_vim
silent! source $VIMRUNTIME/defaults.vim


"------------------------------------------------------------------------------
"------------------------------------------------------------------------------
" ## PREREQUISITES # {{{
"------------------------------------------------------------------------------

if empty(glob('~/.vim/autoload/plug.vim'))
        echoerr "vim-plug is required"
        finish
endif

let google3 = $PWD =~ '^/google'
let s:darwin = has('mac')

let mapleader = ' '
let maplocalleader = ' '


"}}}
"------------------------------------------------------------------------------
"------------------------------------------------------------------------------
" ## PLUGINS # {{{
"------------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

" edit
Plug 'AndrewRadev/splitjoin.vim'
"{{{
  let g:splitjoin_split_mapping = ''
  let g:splitjoin_join_mapping = ''
  nnoremap sj :SplitjoinSplit<cr>
  nnoremap sk :SplitjoinJoin<cr>
"}}}
Plug 'AndrewRadev/switch.vim'
  let g:switch_mapping = "-"
Plug 'brooth/far.vim' " find and replace
"{{{
  nnoremap <silent> <leader>R  :Farr<cr>
  vnoremap <silent> <leader>R  :Farr<cr>
  let g:far#enable_undo=1
"}}}
Plug 'junegunn/vim-after-object'
  autocmd VimEnter * silent! call after_object#enable('=', ':', '#', ' ', '|')
Plug 'junegunn/vim-easy-align'
"{{{
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
  nmap gaa ga_
  xmap <Leader>ga <Plug>(LiveEasyAlign)
"}}}
Plug 'junegunn/vim-journal'
Plug 'Raimondi/delimitMate'
Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }
"{{{
  nnoremap U :MundoToggle<cr>
  if has('python3')
      let g:mundo_prefer_python3 = 1
  endif
"}}}
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat' " . to repeat last command
Plug 'tpope/vim-surround'
Plug 'vim-scripts/ReplaceWithRegister'

" view
Plug 'dhruvasagar/vim-zoom' " <c-w>m
  nmap <silent> <leader>z <Plug>(zoom-toggle)
Plug 'itchyny/lightline.vim'
"{{{
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
    \   'fugitive': '(exists("g:loaded_fugitive") ? fugitive#statusline() : "")',
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
    \}
"}}}
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-journal'
Plug 'junegunn/vim-peekaboo'
Plug 'justinmk/vim-gtfo' " gof, got
Plug 'liuchengxu/vista.vim', { 'on': 'Vista!!'}
"{{{
  inoremap <F9> <esc>:Vista!!<cr>
  nnoremap <F9> :Vista!!<cr>
  nnoremap <silent> <Leader>T :Vista finder fzf:coc<cr>
  let g:vista_keep_fzf_colors = 1
  let g:vista_sidebar_width = 50
  let g:vista_default_executive = 'coc'
  let g:vista_executive_for = {
          \ 'markdown': 'toc',
          \ }
  let g:vista#renderer#enable_icon = 0
"}}}
Plug 'maximbaz/lightline-ale'
Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesEnable' }

" navigate
if s:darwin
  Plug '/usr/local/opt/fzf' " installed fzf using brew
else
  Plug '~/.fzf' " installed fzf using git
endif
Plug 'junegunn/fzf.vim'
"{{{

  nnoremap <silent> <Leader><Leader> :Files<cr>
  nnoremap <silent> <Leader>C        :Commands<cr>
  nnoremap <silent> <Leader><Enter>  :Buffers<cr>
  nnoremap <silent> <Leader>L        :Lines<cr>
  nnoremap <silent> <Leader>ag       :Ag <c-r><c-w><cr>
  nnoremap <silent> <leader>AG       :Ag <c-r><c-a><cr>
  xnoremap <silent> <leader>ag       y:Ag <c-r>"<cr>
  nnoremap <silent> <Leader>rg       :Rg <c-r><c-w><cr>
  nnoremap <silent> <leader>RG       :Rg <c-r><c-a><cr>
  xnoremap <silent> <leader>rg       y:Rg <c-r>"<cr>
  nnoremap <silent> <Leader>`        :Marks<cr>

  function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let options = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    let options = fzf#vim#with_preview(options, 'right', 'ctrl-/')
    call fzf#vim#grep(initial_command, 1, options, a:fullscreen)
  endfunction

  command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

  inoremap <expr> <c-x><c-t> fzf#complete('tmuxwords.rb --all-but-current --scroll 500 --min 5')
  imap <c-x><c-k> <plug>(fzf-complete-word)
  imap <c-x><c-f> <plug>(fzf-complete-path)
  inoremap <expr> <c-x><c-d> fzf#vim#complete#path('blsd')
  imap <c-x><c-j> <plug>(fzf-complete-file-ag)
  imap <c-x><c-l> <plug>(fzf-complete-line)
"}}}
Plug 'junegunn/vim-slash'
"{{{
  if has('timers')
    noremap <expr> <plug>(slash-after) slash#blink(2, 50)
  endif
"}}}

" code
Plug 'google/vim-jsonnet'
Plug 'honza/vim-snippets'
Plug 'michaeljsmith/vim-indent-object' " ai, ii, ai, ii
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'w0rp/ale', {'tag': 'v2.7.0'}
"{{
  let g:ale_python_flake8_options = '--ignore=E501,E402,E226'
  let g:ale_set_loclist = 0
  let g:ale_echo_msg_format = '[%linter%]: %s'
  let g:ale_linters_explicit = 1
  let g:ale_linters = {'go': ['gofmt']}
  let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'dart': ['dartfmt'],
    \ 'haskell': ['brittany'],
    \ 'python': ['isort', 'yapf'],
    \ 'ocaml': ['ocamlformat', 'ocp-indent']
    \}
  if !google3
    let g:ale_fixers.markdown = ['prettier']
    let g:ale_fixers.go = ['gofmt', 'goimports']
    let g:ale_fixers.java = ['google_java_format']
  endif
  let g:ale_fix_on_save = 1
  nmap <silent> <leader>k <Plug>(ale_previous_wrap)
  nmap <silent> <leader>j <Plug>(ale_next_wrap)
"}}}

" vcs
Plug 'junegunn/gv.vim'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
"{{{
  nmap     <Leader>g :Gstatus<CR>gg<c-n>
  nnoremap <Leader>d :Gdiff<CR>
"}}}
Plug 'tpope/vim-rhubarb'
Plug 'rhysd/git-messenger.vim'

" themes
Plug 'AlessandroYorba/Despacio'
Plug 'jnurmine/Zenburn'
Plug 'junegunn/seoul256.vim'
Plug 'morhetz/gruvbox'
Plug 'romainl/Apprentice'

" markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
"{{{
  let g:vim_markdown_folding_disabled = 1
  au BufRead,BufNewFile *.md setlocal wrap
"}}}
Plug 'wookayin/vim-typora', { 'for': 'markdown'}

" latex
Plug 'lervag/vimtex', { 'for': 'tex' }

Plug 'dart-lang/dart-vim-plugin'

Plug 'tpope/vim-sensible'

call plug#end()

" @coc
"{{{
if has_key(g:plugs, 'coc.nvim')
  inoremap <silent><expr> <c-n> coc#refresh()
  inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<tab>"


  function! s:show_documentation()
    if (index(['vim', 'help'], &filetype) >= 0)
      execute 'h' expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  nnoremap <silent> K :call <SID>show_documentation()<CR>

  augroup coc-config
    autocmd!
    autocmd VimEnter * nmap <silent> [g <Plug>(coc-diagnostic-prev)
    autocmd VimEnter * nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " conflic with vim-slash
    autocmd VimEnter * nmap <silent> gd <Plug>(coc-definition)
    autocmd VimEnter * nmap <silent> gy <Plug>(coc-type-definition)
    autocmd VimEnter * nmap <silent> gi <Plug>(coc-implementation)
    autocmd VimEnter * nmap <silent> gr <Plug>(coc-references)

    autocmd VimEnter * nmap <leader>rn <Plug>(coc-rename)

    autocmd VimEnter * xmap <leader>f  <Plug>(coc-format-selected)
    autocmd VimEnter * nmap <leader>f  <Plug>(coc-format-selected)
  augroup END

  call coc#add_extension(
    \ 'coc-css',
    \ 'coc-html',
    \ 'coc-json',
    \ 'coc-solargraph',
    \ 'coc-tsserver',
    \ 'coc-omnisharp',
    \ 'coc-clangd',
    \ 'coc-flutter',
    \ 'coc-java',
    \ 'coc-pyright',
    \ 'coc-sh',
    \ 'coc-snippets',
    \ 'coc-todolist',
    \)
  call coc#config('languageserver', {
    \ "ocaml": {
    \   "command": "opam",
    \     "args": ["config", "exec", "--", "ocamllsp"],
    \     "filetypes": ["ocaml", "reason"],
    \ },
    \ "haskell": {
    \   "command": "hie-wrapper",
    \     "args": ["--lsp"],
    \       "rootPatterns": [
    \         "stack.yaml",
    \         "cabal.config",
    \         "package.yaml",
    \       ],
    \       "filetypes": [
    \         "hs",
    \         "lhs",
    \         "haskell",
    \       ],
    \       "initializationOptions": {
    \         "languageServerHaskell": {
    \           "hlintOn": "true",
    \         }
    \       },
    \ },
    \ "golang": {
    \   "command": "gopls",
    \   "rootPatterns": ["go.mod"],
    \   "disableWorkspaceFolders": "true",
    \   "filetypes": ["go"]
    \ },
    \})
  call coc#config('python', {
    \ 'venvFolders': ['.venv'],
    \})
endif
"}}}

"}}}
"------------------------------------------------------------------------------
"------------------------------------------------------------------------------
" ## BASIC # {{{
"------------------------------------------------------------------------------

" theme
colo seoul256

" define command group
augroup vimrc
    autocmd!
augroup END

set clipboard=unnamed           " global clipboard
set cmdheight=2
set colorcolumn=80
set completeopt=menuone,preview
set cursorline
set diffopt=filler,vertical
set expandtab
set foldlevelstart=99           " start editing with no folds closed
set hidden                      " buffers become hidden when abandoned
set ignorecase smartcase        " ignore case when searching
set lazyredraw                  " do not update the display while executing macros
set modeline
set modelines=1
set nojoinspaces
set list
set listchars=tab:\|\ ,
set noshowmode                  " do not show what mode because we already have statusline
set nostartofline
set number
set shiftround                  " round indent to multiple of shiftwidth when indenting with '<' and '>'
set shiftwidth=2                " number of spaces to use for each step of (auto)indent
set shortmess=aIT               " short message
set showcmd                     " shows visual selection info
set showmatch                   " show matching parenthesis
set softtabstop=2               " when using <BS>, two spaces are considered a tab
set tabstop=2                   " a tab is four spaces
set timeoutlen=500              " time in milliseconds that is waited for a key code or mapped key sequence to complete
set visualbell

" tmp files
set backupdir=/tmp//,.
set directory=/tmp//,.
set undodir=/tmp,.
set undofile

" mouse
silent! set ttymouse=xterm2
set mouse=a

" helpdoc in tab
function! s:helptab()
  if &buftype == 'help'
    wincmd T
    nnoremap <buffer> q :q<cr>
  endif
endfunction
autocmd vimrc BufEnter *.txt call s:helptab()

" }}}
"------------------------------------------------------------------------------
"------------------------------------------------------------------------------
" ## LANG SETTINGS # {{{
"------------------------------------------------------------------------------

autocmd FileType go setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType cpp setlocal shiftwidth=4 tabstop=4 softtabstop=4

" }}}
"------------------------------------------------------------------------------
"------------------------------------------------------------------------------
" ## KEY MAPPINGS # {{{
"------------------------------------------------------------------------------

noremap <C-f> <C-d>
noremap <C-b> <C-u>

nnoremap ; :
nnoremap <leader>; ;
nnoremap 0 ^
nnoremap <leader>v :e ~/.vimrc
nnoremap <leader>n :e ~/workplace/notes/

" prefix scroll in commands
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>

" escape
inoremap jk <Esc>
xnoremap jk <Esc>
cnoremap jk <C-c>
inoremap kj <Esc>
xnoremap kj <Esc>
cnoremap kj <C-c>

" tag
nnoremap <C-]> g<C-]>
nnoremap g[ :pop<cr>

" jumplist
nnoremap jo <C-o>
nnoremap ji <C-i>

" save
inoremap <C-s>     <C-O>:update<cr>
nnoremap <C-s>     :update<cr>
nnoremap <leader>s :update<cr>
nnoremap <leader>w :update<cr>

" open new line below and above current line
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

" quit
inoremap <C-q>     <esc>:q<cr>
nnoremap <C-q>     :q<cr>
vnoremap <C-q>     <esc>
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

" loclist
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz
nnoremap <leader>c :cclose<bar>lclose<cr>

" buffer
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" tabs
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>
nnoremap <tab>   <C-w>w
nnoremap <S-tab> <C-w>W

" markdown headings
nnoremap <leader>1 m`yypVr=``
nnoremap <leader>2 m`yypVr-``
nnoremap <leader>3 m`^i### <esc>``4l
nnoremap <leader>4 m`^i#### <esc>``5l
nnoremap <leader>5 m`^i##### <esc>``6l

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

" make Y behave like other capitals
nnoremap Y y$

" qq to record, Q to replay
nnoremap Q @q

nnoremap <leader>h :PlugHelp<cr>

" }}}
"------------------------------------------------------------------------------
"------------------------------------------------------------------------------
" ## SCRIPTS # {{{
"------------------------------------------------------------------------------

" :PlugHelp
function! s:plug_help_sink(line)
  let dir = g:plugs[a:line].dir
  for pat in ['doc/*.txt', 'README.md']
    let match = get(split(globpath(dir, pat), "\n"), 0, '')
    if len(match)
      execute 'tabedit' match
      return
    endif
  endfor
  tabnew
  execute 'Explore' dir
endfunction

command! PlugHelp call fzf#run(fzf#wrap({
  \ 'source': sort(keys(g:plugs)),
  \ 'sink':   function('s:plug_help_sink')}))

" ?/!
function! s:goog(pat, lucky)
  let q = '"'.substitute(a:pat, '["\n]', ' ', 'g').'"'
  let q = substitute(q, '[[:punct:] ]',
       \ '\=printf("%%%02X", char2nr(submatch(0)))', 'g')
  call system(printf('open "https://www.google.com/search?%sq=%s"',
                   \ a:lucky ? 'btnI&' : '', q))
endfunction

nnoremap <leader>? :call <SID>goog(expand("<cWORD>"), 0)<cr>
nnoremap <leader>! :call <SID>goog(expand("<cWORD>"), 1)<cr>

" :A
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
endfunction command! A call s:a('e') command! AV call s:a('botright vertical split')

" :HL hignlight group
function! s:hl()
  echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), '/')
endfunction
command! HL call <SID>hl()

" :Todo
function! s:todo() abort
  let entries = []
  for cmd in ['git grep -niI -e TODO -e FIXME -e XXX 2> /dev/null',
            \ 'grep -rniI -e TODO -e FIXME -e XXX * 2> /dev/null']
    let lines = split(system(cmd), '\n')
    if v:shell_error != 0 | continue | endif
    for line in lines
      let [fname, lno, text] = matchlist(line, '^\([^:]*\):\([^:]*\):\(.*\)')[1:3]
      call add(entries, { 'filename': fname, 'lnum': lno, 'text': text })
    endfor
    break
  endfor

  if !empty(entries)
    call setqflist(entries)
    copen
  endif
endfunction
command! Todo call s:todo()

" connect to chrome
if s:darwin
  function! s:connect_chrome(bang)
    augroup connect-chrome
      autocmd!
      if !a:bang
        autocmd BufWritePost <buffer> call system(join([
        \ "osascript -e 'tell application \"Google Chrome\"".
        \               "to tell the active tab of its first window\n",
        \ "  reload",
        \ "end tell'"], "\n"))
      endif
    augroup END
  endfunction
  command! -bang ConnectChrome call s:connect_chrome(<bang>0)
endif

" <F8>
function! s:colors(...)
  return filter(map(filter(split(globpath(&rtp, 'colors/*.vim'), "\n"),
        \                  'v:val !~ "^/usr/"'),
        \           'fnamemodify(v:val, ":t:r")'),
        \       '!a:0 || stridx(v:val, a:1) >= 0')
endfunction
function! s:rotate_colors()
  if !exists('s:colors')
    let s:colors = s:colors()
  endif
  let name = remove(s:colors, 0)
  call add(s:colors, name)
  execute 'colorscheme' name
  redraw
  echo name
endfunction
nnoremap <silent> <F8> :call <SID>rotate_colors()<cr>

" :NL (prepend line number)
command! -range=% -nargs=1 NL
  \ <line1>,<line2>!nl -w <args> -s '. ' | perl -pe 's/^.{<args>}..$//'

" :Count appearances
command! -nargs=1 Count execute printf('%%s/%s//gn', escape(<q-args>, '/')) | normal! ``


" }}}
"------------------------------------------------------------------------------
"------------------------------------------------------------------------------
" ## LOCAL # {{{
"------------------------------------------------------------------------------
so $HOME/.vimrc.local
if google3
  so $HOME/.vimrc.google
endif


" }}}
