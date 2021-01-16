" Uber stuff
let $USE_SYSTEM_GO=1

" integrate vim clipboard with system clipboard
set clipboard+=unnamedplus

" quickfix window is always at the bottom
autocmd FileType qf wincmd J

" enable native vim spell checker
set spell spelllang=en_us

" new splits open below the current window
set splitbelow

" don't use swap files. Does more evil than good.
set noswapfile

" enable cooler colors
set termguicolors

" Always show status line
set laststatus=2

" Save file when building with make/GoBuild
set autowrite

" Can use mouse while working
set mouse=a

" Format status line to show current file
set statusline=\ %f

" line number of cursor blinks
set cursorline

" Format status line to include CWD
" set statusline+=\ \ CWD:%{getcwd()}

" reload file if changed from outside
au FocusGained,BufEnter * :checktime

" run make from within vim by using command make
set makeprg=make

" highlight column 110
set colorcolumn=110
highlight ColorColumn ctermbg=darkgray

" show tabs as >---
" set listchars=tab:>-
" set list

" Show line numbers
set number

" display title of current file in terminal title bar
set title

" tab = 4 spaces
set tabstop=4

" shift+> = 4 spaces
set shiftwidth=4

" tab uses spaces
set expandtab

" case insensitive search
set ignorecase

" Always show tab line
set showtabline=2

" remove trailing spaces on save
autocmd BufWritePre *.cpp :call StripTrailingWhitespaces()
autocmd BufWritePre *.c :call StripTrailingWhitespaces()
autocmd BufWritePre *.py :call StripTrailingWhitespaces()

" add html syntax highlighting for gohtml files
autocmd BufNewFile,BufRead *.gohtml   set syntax=html
