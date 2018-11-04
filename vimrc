""" -------------------- VIM CONFIG -------------------------
" Integrate vim with tmux
set term=xterm-256color

" show row & col in bottom-right of the screen
set ruler

" Always show status line
set laststatus=2

" Can use mouse while working
set mouse=a

" Format status line to show CWD and line/column
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" reload file if changed when changing buffers
au FocusGained,BufEnter * :checktime

" Search moves to matched string while typing
set incsearch

" Update file when updated from outside
" set autoread

" backspace works as normal
set backspace=2

" Enable syntax highlighting
:syntax on

" enable Man command in vim
runtime ftplugin/man.vim

" change default vim colorscheme
:colorscheme elflord

" run make from within vim by using command make
set makeprg=make

" highlight column 110
set colorcolumn=110
highlight ColorColumn ctermbg=darkgray

" show tabs as >---
set listchars=tab:>-
set list

" Show line numbers
set number

" display title of current file in terminal title bar
set title

" Highlight search results
set hlsearch

" tab = 4 spaces
set tabstop=4
" shift+> = 4 spaces
set shiftwidth=4

" keeps indent from previous line
set autoindent

" tab uses spaces
set expandtab

" case insensitive search
set ignorecase

" Always show tab line
set showtabline=2

" toggle paste modes in insert mode
set pastetoggle=<F4>

" remove trailing whitespace from lines and preserve cursor position
function! SplitTab()
    let l = line(".")
    let c = col(".")
    :tabe %
    call cursor(l, c)
endfun

function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" remove trailing spaces on save
"autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" run vimrc from local directory
set exrc

""" -------------------- Custom commands -------------------------
" custom command for performing search in all source files
command! -nargs=1 Search vimgrep <args> **/*.c **/*.cpp **/*.h **/*.json | cw

" find-replace current word under cursor with given parameter
command! -nargs=1 ReplaceWith :exec("%s/\\<".expand("<cword>")."\\>/<args>/gc")

""" -------------------- Pathogen CONFIG -------------------------
" start pathogen plugin manager
execute pathogen#infect()

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

""" -------------------- syntastic CONFIG -------------------------
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" default python interpreter is python3
" let g:syntastic_python_python_exec = '/usr/bin/python3'

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

""" -------------------- MAPPINGS -------------------------
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

nnoremap <C-c><C-c> :tabclose<CR>

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

