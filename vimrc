
" remove trailing whitespace from lines and preserve cursor position
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" start pathogen plugin manager
execute pathogen#infect()

" syntastic options
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" run vimrc from local directory
set exrc

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

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

set tags=tags;

" map scroll up
nnoremap <C-a> <C-u>

" map scroll down
nnoremap <C-d> <C-d>

" map tag pop
nnoremap <C-s> <C-t>

" map tag expand
nnoremap <C-w> :exec("tag ".expand("<cword>"))<CR>

