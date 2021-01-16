" switch tabs using Ctrl+[Left/Right]
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" map Ctrl+u to redo
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

" map turning off highlighting after search and closing quickfix window
nnoremap <Esc><Esc> :noh<CR>:ccl<CR>

" mapping for closing the currently open tab
nnoremap <C-c><C-c> :tabclose<CR>

" Ctrl-/ comments/uncomments line(s) in normal and visual mode.
" Doesn't work on mac. Use Ctrl-_ instead.
nmap <C-_> gcc
vmap <C-_> gc

nnoremap <C-f> :GFiles<CR>
nnoremap <C-g> :AgNoFiles<CR>

" paste image from clipboard on C-k
autocmd FileType markdown nmap <buffer><silent> <C-k> :call mdip#MarkdownClipboardImage()<CR>

" fugitive.vim mappings
nmap <leader>gb :Gblame<CR>
nmap <leader>gr :Gread<CR>
nmap <leader>gw :Gwrite<CR>
nmap <leader>gd :tabe<CR>:Gdiffsplit<CR>
nmap <leader>gs :tabe<CR>:Gstatus<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gl :tabe %<CR>:Glog -- %<CR>

" create custom mappings for Go files
autocmd BufEnter *.go nmap <leader>t  <Plug>(go-test)
autocmd BufEnter *.go nmap <leader>tt <Plug>(go-test-func)
autocmd BufEnter *.go nmap <leader>c  <Plug>(go-coverage-toggle)
autocmd BufEnter *.go nmap <leader>i  <Plug>(go-info)
autocmd BufEnter *.go nmap <leader>ii  <Plug>(go-implements)
autocmd BufEnter *.go nmap <leader>ci  <Plug>(go-describe)
autocmd BufEnter *.go nmap <leader>cc  <Plug>(go-callers)
autocmd BufEnter *.go nmap <leader>cs  <Plug>(go-callstack)

nmap <leader>r <Plug>(coc-rename)
nmap <leader>d :CocDiagnostics<CR>
nmap <leader>cr  <Plug>(coc-references)

" map tag pop and push for all files
nmap <C-a> <C-o>
nmap <C-d> <Plug>(coc-definition)
