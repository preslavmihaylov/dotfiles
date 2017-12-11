
" remove trailing whitespace from lines and preserve cursor position
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun


" Show line numbers
set number

" Highlight search results
set hlsearch

" tab = 4 spaces
set tabstop=4
" shift+> = 4 spaces
set shiftwidth=4

" keeps indent from previous line
set autoindent

" tab uses spaces
" set expandtab

" toggle paste modes in insert mode
set pastetoggle=<F3>

" remove trailing spaces on save
autocmd BufWritePre *.c,*.h :call <SID>StripTrailingWhitespaces()

" switch tabs using Ctrl+[Left/Right]
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
