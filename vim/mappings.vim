" switch tabs using Ctrl+[Left/Right]
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" map YCM's goto command
" (similar to <C-d>, but works better for header files)
nnoremap <C-e> :YcmCompleter GoTo<CR>

" map undo/redo
nnoremap <C-z> :undo<CR>
nnoremap <C-u> :redo<CR>

" map find/replace with vim-over
nmap <C-r> :OverCommandLine<CR>%s/

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

" map closing quickfix window
" nnoremap <F1> :ccl<CR>
autocmd BufEnter *.go nmap <F1>  :GoDeclsDir<CR>

" create custom mappings for Go files
autocmd BufEnter *.go nmap <leader>b  :<C-u>call BuildGoFiles()<CR>
autocmd BufEnter *.go nmap <leader>r  <Plug>(go-run)
autocmd BufEnter *.go nmap <leader>t  <Plug>(go-test)
autocmd BufEnter *.go nmap <leader>tt <Plug>(go-test-func)
autocmd BufEnter *.go nmap <leader>c  <Plug>(go-coverage-toggle)
autocmd BufEnter *.go nmap <leader>q  <Plug>(go-alternate-edit)
autocmd BufEnter *.go nmap <leader>i  <Plug>(go-info)
autocmd BufEnter *.go nmap <leader>d  <Plug>(go-doc)
autocmd BufEnter *.go nmap <leader>ci  <Plug>(go-describe)
autocmd BufEnter *.go nmap <leader>cr  <Plug>(go-referrers)
autocmd BufEnter *.go nmap <leader>cc  <Plug>(go-callers)
autocmd BufEnter *.go nmap <leader>cs  <Plug>(go-callstack)
autocmd BufEnter *.go nmap <leader>l  <Plug>(go-lint)

" map tag pop and push
autocmd BufEnter * nnoremap <C-a> <C-o>
autocmd BufEnter * nnoremap <C-d> :exec("tag ".expand("<cword>"))<CR>

" remap tag expand/pop commands for go files to use vim-go alternatives
autocmd BufEnter *.go nmap <C-a>  :GoDefPop<CR>
autocmd BufEnter *.go nmap <C-d>  :GoDef<CR>
autocmd BufEnter *.go nmap <leader>s  :GoDefStack<CR>

" map searching for symbol in all files
nnoremap <F2> :call SplitTab()<CR>
    \ *
    \ :exec("Search ".expand("<cword>"))<CR>

" when finding a definition with cscope, open results in a new tab
nnoremap <F3> :call SplitTab()<CR>
    \ *
    \ :exec("cs find s ".expand("<cword>"))<CR>
    \ :copen<CR>

