" switch tabs using Ctrl+[Left/Right]
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" map undo/redo
nnoremap <C-z> :undo<CR>
nnoremap <C-u> :redo<CR>

" map moving tabs
nnoremap <C-Up> :tabm +1<CR>
nnoremap <C-Down> :tabm -1<CR>

" map switch windows
nnoremap <Tab> <C-w>w

" map scroll up
nnoremap <C-w> <C-u>

" map scroll down
nnoremap <C-s> <C-d>

" map resizing buffers
nnoremap <A-Right> :vertical resize+5<CR>
nnoremap <A-Left> :vertical resize-5<CR>
nnoremap <A-Up> :resize+5<CR>
nnoremap <A-Down> :resize-5<CR>

" map turning off highlighting after search
nnoremap <Esc><Esc> :noh<CR>

" go to mark 'm' (I use that as default). Set it by clicking 'mm'
nnoremap <C-q> :'m<CR>

" mapping for closing the currently open tab
nnoremap <C-c><C-c> :tabclose<CR>

" Ctrl-/ comments/uncomments line(s) in normal and visual mode
nmap <C-_> gcc
vmap <C-_> gc

" comment/uncomment multiple lines in visual mode
xnoremap <C-r> :norm i//<CR>
xnoremap <C-t> :norm 0xx<CR>

" F10 toggles syntastic error/warning checking
" nnoremap <F10> :SyntasticToggleMode<CR>

" Show YCM errors and warnings in location list
nnoremap <F10> :YcmDiags<CR>

" map refreshing cscope db
nnoremap <F12> <ESC>:cs kill -1<CR>
    \ :!cscope-rebuild.sh<CR>
    \ :cs add $CSCOPE_SRC/cscope.out<CR>

" map searching for symbol in all file
nnoremap <F2> :call SplitTab()<CR>
    \ *
    \ :exec("Search ".expand("<cword>"))<CR>

" when finding a definition with csope, open results in a new tab
nnoremap <F3> :call SplitTab()<CR>
    \ *
    \ :exec("cs find s ".expand("<cword>"))<CR>
    \ :copen<CR>

