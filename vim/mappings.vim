" switch tabs using Ctrl+[Left/Right]
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" map tag pop
nnoremap <C-a> <C-o>

" map tag expand
nnoremap <C-d> :exec("tag ".expand("<cword>"))<CR>

" map YCM's goto command
" (similar to <C-d>, but works better for header files)
nnoremap <C-e> :YcmCompleter GoTo<CR>

" map undo/redo
nnoremap <C-z> :undo<CR>
nnoremap <C-u> :redo<CR>

" map moving tabs
nnoremap <C-Up> :tabm +1<CR>
nnoremap <C-Down> :tabm -1<CR>

" map switch windows
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>h

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

" map C-k/C-l to traverse quickfix window
nnoremap <C-k> :cprev<CR>
nnoremap <C-l> :cnext<CR>

" create custom mappings for Go files
autocmd FileType go nmap <leader>b  :<C-u>call BuildGoFiles()<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <leader>tt <Plug>(go-test-func)
autocmd FileType go nmap <leader>c  <Plug>(go-coverage-toggle)
autocmd FileType go nmap <leader>q  <Plug>(go-alternate-edit)
autocmd FileType go nmap <leader>i  <Plug>(go-info)
autocmd FileType go nmap <leader>d  <Plug>(go-doc)
autocmd FileType go nmap <leader>ci  <Plug>(go-describe)
autocmd FileType go nmap <leader>cr  <Plug>(go-referrers)
autocmd FileType go nmap <leader>cc  <Plug>(go-callers)
autocmd FileType go nmap <leader>cs  <Plug>(go-callstack)

" remap tag expand/pop commands for go files to use vim-go alternatives
autocmd FileType go nmap <C-a>  :GoDefPop<CR>
autocmd FileType go nmap <C-d>  :GoDef<CR>
autocmd FileType go nmap <leader>s  :GoDefStack<CR>

" map searching for symbol in all file
nnoremap <F2> :call SplitTab()<CR>
    \ *
    \ :exec("Search ".expand("<cword>"))<CR>

" when finding a definition with csope, open results in a new tab
nnoremap <F3> :call SplitTab()<CR>
    \ *
    \ :exec("cs find s ".expand("<cword>"))<CR>
    \ :copen<CR>

