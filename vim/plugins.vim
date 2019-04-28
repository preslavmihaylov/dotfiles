""" -------------------- Pathogen -------------------------

" start pathogen plugin manager
execute pathogen#infect()
execute pathogen#helptags()

""" -------------------- delimitMate -------------------------
let delimitMate_backspace = 1

""" -------------------- vim-commentary -------------------------
" override default comment style for cpp files
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
" let g:ycm_filetype_blacklist = {
"     \ 'vim': 1
"     \}

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

let g:NERDTreeWinSize=40

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

""" -------------------- gutentags -------------------------
" enable ctags
set tags=tags;

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
autocmd BufEnter *.go nested :TagbarOpen

""" -------------------- vim-go -------------------------
" all errors are shown in the quickfix window
let g:go_list_type = "quickfix"

" automatically add import paths when saving file
let g:go_fmt_command = "goimports"

" enable syntax highlighting
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1

" enable go metalinter
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1

" automatically show GoInfo output
" let g:go_auto_type_info = 1

" automatically highlight variable your cursor is on
let g:go_auto_sameids = 1

" adjust quickfix window height
let g:go_list_height = 8

let g:go_term_mode = "split above"
