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

" Pin the fzf window at the bottom
let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.3, 'xoffset': 0, 'yoffset': 100 } }

""" -------------------- vim-airline -------------------------
" cooler status line for vim

" enable smarter tab line
let g:airline#extensions#tabline#enabled = 1

" use vim-airline molokai theme
" let g:airline_theme='gruvbox'

" don't show open buffers in tabline. Doesn't show closed tabs as well
let g:airline#extensions#tabline#show_buffers = 0

" don't show open buffers. Adds too much noise
let g:airline#extensions#tabline#show_splits = 0

""" -------------------- md-img-paste.vim ---------------
" Let's you pate images from clipboard to markdown file

" there are some defaults for image directory and image name, you can change them
let g:mdip_imgdir = 'images'
let g:mdip_imgname = 'image'

""" -------------------- vim-go -------------------------
" Batteries-included plugin for Golang

" disable all linters as that is taken care of by coc.nvim
let g:go_diagnostics_enabled = 0
let g:go_metalinter_enabled = []

" don't jump to errors after metalinter is invoked
let g:go_jump_to_error = 0

" run go imports on file save
let g:go_fmt_command = "goimports"

" disable gofmt on save because coc-go takes care of that
let g:go_fmt_autosave = 0


" vim-go debug: show shell commands being executed
" let g:go_debug=['shell-commands']

" automatically show GoInfo output
" let g:go_auto_type_info = 1

" automatically highlight variable your cursor is on
let g:go_auto_sameids = 0

" enable syntax highlighting
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1

""" -------------------- vimspector -------------------------
" Vim Debugger

let g:vimspector_enable_mappings = 'HUMAN'

nmap <leader>vl :call vimspector#Launch()<CR>
nmap <leader>vr :VimspectorReset<CR>
nmap <leader>ve :VimspectorEval
nmap <F7> :call vimspector#Continue()<CR>

" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval

" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval

let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-go', 'CodeLLDB', 'vscode-node-debug2' ]

""" -------------------- tagbar -------------------------
" Show code outline

nmap <F2> :TagbarToggle<CR>

" set updatetime=500
