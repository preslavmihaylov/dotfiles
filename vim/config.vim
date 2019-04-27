" integrate vim clipboard with system clipboard
set clipboard+=unnamedplus

" quickfix window is always at the bottom
autocmd FileType qf wincmd J

" new splits open below the current window
set splitbelow

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

" Format status line to include CWD
" set statusline+=\ \ CWD:%{getcwd()}

" Format status line to include row,col + percent through file
set statusline+=\ %=%(%l,%c%V\ %=\ %P%)

" reload file if changed from outside
au FocusGained,BufEnter * :checktime

" Enable syntax highlighting
syntax on

" change default vim colorscheme
colorscheme molokai

" override default colors for YouCompleteMe window for more contrast
highlight Pmenu guibg=#918F8F guifg=#000000
highlight PmenuSel guibg=#2B2929 guifg=#FFFFFF

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

" toggle paste modes in insert mode
set pastetoggle=<F4>

" remove trailing spaces on save
autocmd BufWritePre *.cpp :call StripTrailingWhitespaces()
autocmd BufWritePre *.c :call StripTrailingWhitespaces()
autocmd BufWritePre *.py :call StripTrailingWhitespaces()
autocmd BufWritePre *.js :call StripTrailingWhitespaces()
autocmd BufWritePre *.go :call StripTrailingWhitespaces()

" enable blinking cursor in nvim
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175
