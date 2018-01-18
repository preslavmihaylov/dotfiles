""" -------------------- VIM CONFIG -------------------------

" enable Man command in vim
runtime ftplugin/man.vim

" change default vim colorscheme
:colorscheme ron

" run make from within vim by using command make
set makeprg=make

" highlight column 110
set colorcolumn=110
highlight ColorColumn ctermbg=darkgray

" show tabs as >---
:set listchars=tab:>-
:set list

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
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" remove trailing spaces on save
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" run vimrc from local directory
set exrc

" custom command for performing search in all source files
command! -nargs=1 Search vimgrep <args> **/*.c **/*.h | cw

""" -------------------- Pathogen CONFIG -------------------------
" start pathogen plugin manager
execute pathogen#infect()

""" -------------------- YouCompleteMe CONFIG -------------------------
"let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
"let g:ycm_auto_trigger = 0
"let g:ycm_key_invoke_completion = '<C-Space>'

""" -------------------- syntastic CONFIG -------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

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
nnoremap <C-a> <C-t>

" map tag expand
nnoremap <C-d> :exec("tag ".expand("<cword>"))<CR>

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

    " add cscope db at start of vim
    exec ':!cscope-rebuild.sh'
    exec 'cs add $CSCOPE_SRC/cscope.out'

    " map refreshing cscope db
    nnoremap <F12> <ESC>:cs kill -1<CR>
        \ :!cscope-rebuild.sh<CR>
        \ :cs add $CSCOPE_SRC/cscope.out<CR>

    nnoremap <F3> :exec("cs find s ".expand("<cword>"))<CR>:copen<CR>
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

" map searching for symbol in all file
nnoremap <F2> :exec("Search ".expand("<cword>"))<CR>

" go to mark 'm' (I use that as default). Set it by clicking 'mm'
nnoremap <C-q> :'m<CR>
