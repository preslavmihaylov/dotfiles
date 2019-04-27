""" -------------------- Pathogen -------------------------

" start pathogen plugin manager
execute pathogen#infect()
execute pathogen#helptags()

""" -------------------- vim-commentary -------------------------
autocmd FileType cpp setlocal commentstring=//\ %s

""" -------------------- todo-lists -------------------------
" don't move items when marked as done
let g:VimTodoListsMoveItems = 0

""" -------------------- incsearch.vim -------------------------
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

""" -------------------- YouCompleteMe -------------------------
"let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"

" the first option (commented out) disables auto-complete
" the second one, triggers it only on '->' and '.'
" let g:ycm_auto_trigger = 0
" let g:ycm_min_num_of_chars_for_completion = 200
let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_server_python_interpreter = 'python3'

" remove annoying preview window appearing on top of vim
let g:ycm_add_preview_to_completeopt = 0
set completeopt-=preview

" blacklist certain filetypes from plugin
let g:ycm_filetype_blacklist = {
    \ 'vim': 1
    \}

""" -------------------- ctrl-p -------------------------
" default command for starting ctrl-p
let g:ctrlp_map='<c-f>'

" override default command for exiting ctrl-p prompt
let g:ctrlp_prompt_mappings = { 'PrtExit()': ['<c-f>', '<c-c>'],
	\ 'ToggleType(1)': ['c-down>']  }

" ctrl-p search directory is CWD
let g:ctrlp_working_path_mode='w'

" ctrl-p will include dotfiles in its search
let g:ctrlp_show_hidden=1

""" -------------------- nerdtree -------------------------
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

""" -------------------- ctags -------------------------
" enable ctags
set tags=tags;

" map tag pop
nnoremap <C-a> <C-o>

" map tag expand
nnoremap <C-d> :exec("tag ".expand("<cword>"))<CR>

" map YCM's goto command
" (similar to <C-d>, but works better for header files)
nnoremap <C-e> :YcmCompleter GoTo<CR>

""" -------------------- cscope -------------------------
if has('cscope')
    " set cscopetag cscopeverbose

    " if has('quickfix')
    "     set cscopequickfix=s-,c-,d-,i-,t-,e-
    " endif

    " cnoreabbrev csa cs add
    " cnoreabbrev csf cs find
    " cnoreabbrev csk cs kill
    " cnoreabbrev csr cs reset
    " cnoreabbrev css cs show
    " cnoreabbrev csh cs help

    " nnoremap <C-k> :cprev<CR>
    " nnoremap <C-l> :cnext<CR>
endif

""" -------------------- gutentags -------------------------
" enable gtags module
let g:gutentags_modules = ['ctags', 'gtags_cscope']

" config project root markers.
let g:gutentags_project_root = ['.root']

" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')

" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1

""" -------------------- tagbar -------------------------

let g:tagbar_autoclose = 0
let g:tagbar_width = 43

autocmd BufEnter *.cpp nested :TagbarOpen
autocmd BufEnter *.c nested :TagbarOpen
autocmd BufEnter *.py nested :TagbarOpen

