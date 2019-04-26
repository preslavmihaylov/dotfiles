""" -------------------- Pathogen CONFIG -------------------------

" start pathogen plugin manager
execute pathogen#infect()

""" -------------------- todo-lists CONFIG -------------------------
" don't move items when marked as done
let g:VimTodoListsMoveItems = 0

""" -------------------- incsearch.vim CONFIG -------------------------
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

""" -------------------- YouCompleteMe CONFIG -------------------------
"let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"

" the first option (commented out) disables auto-complete
" the second one, triggers it only on '->' and '.'
" let g:ycm_auto_trigger = 0
let g:ycm_min_num_of_chars_for_completion = 200
let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_server_python_interpreter = 'python3'

" remove annoying preview window appearing on top of vim
let g:ycm_add_preview_to_completeopt = 0
set completeopt-=preview

""" -------------------- ctrl-p CONFIG -------------------------
" default command for starting ctrl-p
let g:ctrlp_map='<c-f>'

" override default command for exiting ctrl-p prompt
let g:ctrlp_prompt_mappings = { 'PrtExit()': ['<c-f>', '<c-c>'],
	\ 'ToggleType(1)': ['c-down>']  }

" ctrl-p search directory is CWD
let g:ctrlp_working_path_mode='w'

" ctrl-p will include dotfiles in its search
let g:ctrlp_show_hidden=1

""" -------------------- NERDTree CONFIG -------------------------
" nerd tree opens files in different tabs
" let g:NERDTreeMapOpenInTab='<ENTER>'

" start NERDTree automatically on startup
" autocmd vimenter * NERDTree

let g:NERDTreeWinSize=50

" if NERDTreeTab is open --> NERDTreeToggle, else NERDTreeFind
function! OpenNERDTree()
    if exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
        NERDTreeToggle
    else
        " finds currently open file in NERDTree
        NERDTreeFind
    endif
endfunction

" map toggling nerd tree
nnoremap <C-p> :call OpenNERDTree()<CR>

""" -------------------- CTags CONFIG -------------------------
" enable ctags
set tags=tags;

" map tag pop
nnoremap <C-a> <C-o>

" map tag expand
nnoremap <C-d> :exec("tag ".expand("<cword>"))<CR>

" map YCM's goto command
" (similar to <C-d>, but works better for header files)
nnoremap <C-e> :YcmCompleter GoTo<CR>

""" -------------------- CScope CONFIG -------------------------
if has('cscope')
    set cscopetag cscopeverbose

    if has('quickfix')
        set cscopequickfix=s-,c-,d-,i-,t-,e-
    endif

    cnoreabbrev csa cs add
    cnoreabbrev csf cs find
    cnoreabbrev csk cs kill
    cnoreabbrev csr cs reset
    cnoreabbrev css cs show
    cnoreabbrev csh cs help

    nnoremap <C-k> :cprev<CR>
    nnoremap <C-l> :cnext<CR>
endif

