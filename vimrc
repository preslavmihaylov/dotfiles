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

" switch tabs using Ctrl+[Left/Right]
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
