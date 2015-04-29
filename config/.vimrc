""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible

" Enable filetype plugins
set smartindent
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
set autowrite

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set mouse=a

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" When searching try to be smart about cases
set smartcase

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

colorscheme desert
set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
	set guifont=Monospace\ 12
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set tabstop=4
set linebreak
"set textwidth=64
set expandtab
set wrap

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" System interaction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" y yanks to X11 clipboard
"
set clipboard=unnamedplus

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=0
set statusline=%t\ %y\ format:\ %{&ff};\ [%c,%l]
set novisualbell
set number

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ??
set timeout ttimeoutlen=50

" auto close braces
inoremap {<CR>  {<CR>}<Esc>O
inoremap /*<CR>	/*<CR>	<CR>*/<Up><Right>

" fix hash indentation problem in python (i.e. hash should not move to beginning
" of the line automatically)
inoremap # X#

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   === HIGHLIGHT ===

" Set spelling highlight options to something that does not
" burn the eye
highlight clear SpellBad
highlight SpellBad ctermfg=1 cterm=underline
highlight clear SpellCap
highlight SpellCap cterm=underline
highlight clear SpellRare
highlight SpellRare cterm=underline
highlight clear SpellLocal
highlight SpellLocal cterm=underline

" Fold highlight style (same reason as spelling)
highlight clear Folded
highlight Folded ctermfg=cyan guifg=cyan

" set foldmethod=indent
" recursively open fold
" nmap <F1> zO
" recursively close fold
" nmap <F2> zC


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" === FILETYPE SPECIFIC OPTIONS ===

autocmd filetype make   setlocal tw=80
"autocmd filetype go     setlocal tw=64
autocmd filetype c      setlocal tw=80
autocmd filetype cpp    setlocal tw=80
autocmd filetype python setlocal tw=80

autocmd filetype make   setlocal expandtab
autocmd filetype go     setlocal expandtab
autocmd filetype c      setlocal noexpandtab
autocmd filetype cpp    setlocal noexpandtab
autocmd filetype python setlocal expandtab

autocmd BufRead,BufNewFile *.md set filetype=markdown

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" === EXIT ===

" remove excess spaces from line endings on save
autocmd BufWritePre * :%s/\s\+$//e

" go fmt when writing go files
autocmd BufWritePost *.go :!go fmt %
