""" -------------------- Pathogen -------------------------
" Plugin manager for vim

" start pathogen plugin manager
execute pathogen#infect()
execute pathogen#helptags()

""" -------------------- vim-commentary -------------------------
" Comment-uncomment line for any language

" override default comment style for cpp files
autocmd FileType cpp setlocal commentstring=//\ %s

""" -------------------- todo-lists -------------------------
" Todo list plugin. Supports *.todo files

" don't move items when marked as done
let g:VimTodoListsMoveItems = 0

""" -------------------- incsearch.vim -------------------------
" Highlight search results while typing

map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" stop results highlighting after cursor moves
let g:incsearch#auto_nohlsearch = 1

""" -------------------- YouCompleteMe -------------------------
" Auto-complete engine supporting multiple languages

"let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"

" disable YCM on startup
" let g:loaded_youcompleteme = 0

" the first option (commented out) disables auto-complete
" the second one, triggers it only on '->' and '.'
" let g:ycm_auto_trigger = 0
" let g:ycm_min_num_of_chars_for_completion = 200
let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_server_python_interpreter = 'python3'

" remove annoying preview window appearing on top of vim
let g:ycm_add_preview_to_completeopt = 0
set completeopt-=preview

" Enter closes the completion window
let g:ycm_key_list_stop_completion = ['<CR>']

" blacklist certain filetypes from plugin
" let g:ycm_filetype_blacklist = {
"     \ 'vim': 1
"     \}

""" -------------------- nerdtree -------------------------
" Project explorer for vim

" nerd tree opens files in different tabs
" let g:NERDTreeMapOpenInTab='<ENTER>'

" start NERDTree automatically on startup
" autocmd vimenter * NERDTree

let g:NERDTreeWinSize=40

let NERDTreeShowHidden=1

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

""" -------------------- fzf-vim -------------------------
" Fuzzy-finder for vim

set rtp+=~/.fzf

" Customize fzf colors to match colorscheme
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, { 'options': ['--color', 'fg:252,bg:233,hl:#ff8787,fg+:252,bg+:235,hl+:#ff0000,info:0,prompt:161,spinner:135,pointer:135,marker:118'] }, <bang>0)

""" -------------------- gutentags -------------------------
" Auto-generate ctags file without user intervention

" enable ctags
set tags=tags;

" enable gtags module
let g:gutentags_modules = ['ctags']

" additionally enable cscope when working on c/cpp source files
autocmd FileType cpp let g:gutentags_modules = ['ctags', 'gtags_cscope']
autocmd FileType c let g:gutentags_modules = ['ctags', 'gtags_cscope']

" config project root markers.
let g:gutentags_project_root = ['.root']

" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')

" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1

""" -------------------- tagbar -------------------------
" Source file outline based on ctags-generated files

let g:tagbar_autoclose = 0
let g:tagbar_width = 43

autocmd BufEnter *.cpp nested :TagbarOpen
autocmd BufEnter *.c nested :TagbarOpen
autocmd BufEnter *.py nested :TagbarOpen
autocmd BufEnter *.go nested :TagbarOpen
autocmd BufEnter *.js nested :TagbarOpen

""" -------------------- vim-jsx-pretty -------------------------
" Syntax highlighting for JSX (JS+HTML templating syntax)

""" -------------------- vim-prettier -------------------------
" Auto-format plugin for html/css/js/etc.js files

" run prettier on autosave
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

""" -------------------- ALE -------------------------
" Generic Linters aggregator

let g:ale_linters = {
\   'sh': [],
\   'bash': [],
\   'python': [],
\   'javascript': ['eslint'],
\   'typescript': ['tslint'],
\   'go': ['golint'],
\   'vue': ['eslint']
\}

""" -------------------- vim-airline -------------------------
" cooler status line for vim

" enable smarter tab line
let g:airline#extensions#tabline#enabled = 1

" use vim-airline molokai theme
let g:airline_theme='molokai'

" don't show open buffers in tabline. Doesn't show closed tabs as well
let g:airline#extensions#tabline#show_buffers = 0

" enable ALE integration
let g:airline#extensions#ale#enabled = 1

""" -------------------- vim-go -------------------------
" Batteries-included plugin for Golang

" all errors are shown in the quickfix window
let g:go_list_type = "quickfix"

" automatically add import paths when saving file
"let g:go_fmt_command = "goimports"

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

" let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck']
" let g:go_metalinter_autosave_enabled = ['vet', 'errcheck']
" let g:go_metalinter_autosave = 1

" run go imports on file save
let g:go_fmt_command = "goimports"

" don't jump to errors after metalinter is invoked
let g:go_jump_to_error = 0

" default metalinter is deprecated. Change to better alternative
let g:go_metalinter_command='golangci-lint'

" use gopls for go to definition and get info commands
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" vim-go debug: show shell commands being executed
" let g:go_debug=['shell-commands']

" automatically show GoInfo output
" let g:go_auto_type_info = 1

" automatically highlight variable your cursor is on
let g:go_auto_sameids = 1

" adjust quickfix window height
let g:go_list_height = 8

" terminal opens as a horizontal split below the main window
let g:go_term_mode = "split above"

" More verbose output on failed tests in quickfix window
let g:go_test_show_name = 1

