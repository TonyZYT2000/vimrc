" Disable strict vi compatibility!
set nocompatible

" Set correct language
set langmenu=en_US.UTF-8

" Vim-Plug
call plug#begin()
Plug 'elzr/vim-json'
Plug 'tomasr/molokai'
Plug 'ap/vim-css-color'
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-signify'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'joshdick/onedark.vim'
Plug 'raimondi/delimitmate'
Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'
Plug 'wlangstroth/vim-racket'
Plug 'voldikss/vim-translator'
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-smooth-scroll'
Plug 'easymotion/vim-easymotion'
Plug 'skywind3000/vim-terminal-help'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'ivalkeen/nerdtree-execute', { 'on': 'NERDTreeToggle' }
call plug#end()

" Set syntax and color scheme
syntax on
set bg=dark
color molokai
set termguicolors

" Appearance Settings
set nu                         " Line numbers on
"set lbr                        " Automatically break when total width is hit
"set tw=80                      " Set the total width to 80
set ruler                      " Show column and line at bottom
"set nowrap                     " No line wrapping!
set showcmd                    " Show (partial) command in status line.
set showmatch                  " Check matching delims () {} []
set colorcolumn=80             " Put a red line at column 80
set noshowmode                 " Not show current mode
set guioptions=Te              " Keep the copy, cut, save GUI buttons visible
set list                       " Turn on visual spaces/tabs
set listchars=tab:>-           " Make tabs look like >--------
set laststatus=2               " Enable lightline plugin

if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window.
  set lines=30 columns=100
  "set guifont=Sarasa\ Mono\ SC:h14 "Set font
  set guifont=Fira\ Code:h14 "Set font
endif

" Highlight columns over 80 as red
"highlight OverLength ctermbg=red guibg=red

" Function Settings
set fo+=r                      " Support continuing * in C block comments
set ff=unix                    " Unix EOL
set mouse=a                    " Support mouse
set cindent                    " Support C autoindenting of braces, etc.
set hlsearch                   " Highlight search results
set incsearch                  " Increment search
set smartcase                  " Override ignorecase if search contains capital
set ignorecase                 " Make default search not case sensitive
set autoindent                 " Auto indentation
set splitbelow                 " Set sp to split below
set splitright                 " Set vsp to split on right
set noerrorbells               " Turn off error bells (screen flashing)
set tabpagemax=100             " Allow 100 tabs opened instead of 10
set updatetime=100             " Set update time to 100ms
set encoding=utf-8             " Set default encoding to utf-8
set backspace=2                " Fix backspacing in insert mode
set backspace=indent,eol,start " Make backspace work normally
set clipboard^=unnamed,unnamedplus
set fileencodings=utf-8,utf-16,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
                               " Auto detect file encoding

" Key Remap Settings
" Move cursor around with Ctrl+hjkl
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
" Move cursor around with Alt+Shift+hjkl
nnoremap <A-S-H> <C-W>h
nnoremap <A-S-J> <C-W>j
nnoremap <A-S-K> <C-W>k
nnoremap <A-S-L> <C-W>l
" Move between tabs
nnoremap <Leader><Tab> :tabn<CR>
nnoremap <Leader><S-Tab> :tabp<CR>
" Fuzzy file search
nnoremap <silent><C-P> :Files<CR>
" Fix weird gVim bug
nnoremap <S-Esc> :set bg=dark<CR>
" clear search result
nnoremap <silent><CR> :noh<CR><CR>
nnoremap <silent><A-t> :TagbarToggle<CR>
nnoremap <silent><A-e> :NERDTreeToggle<CR>

" Create group so that highlighting extends to multiple vim tabs simultaneously
augroup myMatches
  autocmd!
  au WinEnter,BufEnter *
    \ call clearmatches() |
    "\ call matchadd('OverLength', '\%81v.\+', -1)
augroup END

" Enable filetype detection. Used in the myFileSettings augroup below
filetype plugin on

" Group all file indentation settings together.
augroup myFileSettings
  autocmd!

  " Tab settings for C files
  au FileType c set expandtab     " turn tabs into spaces visually
  au FileType c set shiftwidth=4  " set width of < and > cmd to 4 spaces
  au FileType c set softtabstop=4 " pressing tab inserts 4 spaces

  " Tab settings for bash file
  au FileType sh set expandtab     " turn tabs into spaces visually
  au FileType sh set shiftwidth=2  " set width of < and > cmd to 2 spaces
  au FileType sh set softtabstop=2 " pressing tab inserts 2 spaces

  " Tab settings for C++ files, C/C++ header files
  au FileType cpp set expandtab     " turn tabs into spaces visually
  au FileType cpp set shiftwidth=4  " set width of < and > cmd to 4 spaces
  au FileType cpp set softtabstop=4 " pressing tab inserts 4 spaces

  " Tab settings for vim file
  au FileType vim set expandtab     " turn tabs into spaces visually
  au FileType vim set shiftwidth=2  " set width of < and > cmd to 2 spaces
  au FileType vim set softtabstop=2 " pressing tab inserts 2 spaces

  " Tab settings for Java files
  au FileType java set expandtab     " turn tabs into spaces visually
  au FileType java set shiftwidth=4  " set width of < and > cmd to 4 spaces
  au FileType java set softtabstop=4 " pressing tab inserts 4 spaces

  " No expansion at all for Makefiles
  au FileType make set tabstop=8     " tab size as 8 spaces
  au FileType make set noexpandtab   " keep tabs as tabs
  au FileType make set shiftwidth=8  " set width of < and > cmd to 8 spaces
  au FileType make set softtabstop=8 " pressing tab inserts 8 spaces

  " Tab settings for Python files
  au FileType python set expandtab     " turn tabs into spaces visually
  au FileType python set shiftwidth=4  " set width of < and > cmd to 4 spaces
  au FileType python set softtabstop=4 " pressing tab inserts 4 spaces

  " Tab settings for scheme file
  au FileType scheme set expandtab     " turn tabs into spaces visually
  au FileType scheme set shiftwidth=2  " set width of < and > cmd to 2 spaces
  au FileType scheme set softtabstop=2 " pressing tab inserts 2 spaces

  " Tab settings for Markdown file
  au FileType markdown set expandtab     " turn tabs into spaces visually
  au FileType markdown set shiftwidth=4  " set width of < and > cmd to 4 spaces
  au FileType markdown set softtabstop=4 " pressing tab inserts 4 spaces

augroup END

" Plugin Settings

" Lightline Status Line Customization
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch' ],
      \             [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" Signify Settings
let g:signify_skip_filetype = { 'markdown': 1 }

" EasyMotion Settings
let g:EasyMotion_smartcase = 1  " Enable smartcase for characters
let g:EasyMotion_do_mapping = 0 " Disable default key mappings
let g:EasyMotion_use_smartsign_us = 1 " Enable smartcase for signs
" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
" <Leader>w to move to a word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
" <Leader>L to move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
" <Leader>h/j/k/l to avoid repeating h/j/k/l
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
" Use EasyMotion in search mode
" map  / <Plug>(easymotion-sn)
" omap / <Plug>(easymotion-tn)

" Translator Settings
" Echo translation in the cmdline
let g:translator_default_engines=['google', 'youdao']
nmap <silent> <Leader>tt <Plug>Translate
vmap <silent> <Leader>tt <Plug>TranslateV
" Display translation in a window
nmap <silent> <Leader>tw <Plug>TranslateW
vmap <silent> <Leader>tw <Plug>TranslateWV
" Replace the text with translation
nmap <silent> <Leader>tr <Plug>TranslateR
vmap <silent> <Leader>tr <Plug>TranslateRV

"Smooth Scroll Settings
nnoremap <silent> <C-Y> :call smooth_scroll#up(1, 3, 1)<CR>
nnoremap <silent> <C-E> :call smooth_scroll#down(1, 3, 1)<CR>
nnoremap <silent> <C-U> :call smooth_scroll#up(&scroll, 36, 2)<CR>
nnoremap <silent> <C-D> :call smooth_scroll#down(&scroll, 36, 2)<CR>
nnoremap <silent> <C-B> :call smooth_scroll#up(&scroll*2, 36, 4)<CR>
nnoremap <silent> <C-F> :call smooth_scroll#down(&scroll*2, 36, 4)<CR>
