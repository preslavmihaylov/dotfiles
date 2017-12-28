""" -------------------- VIM CONFIG -------------------------
" Show line numbers
set number

" Highlight search results
set hlsearch

" tab = 4 spaces
set tabstop=4
" shift+> = 4 spaces
set shiftwidth=4

" keeps indent from previous line
set autoindent

" tab uses spaces
" set expandtab

" toggle paste modes in insert mode
set pastetoggle=<F3>

" remove trailing whitespace from lines and preserve cursor position
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" remove trailing spaces on save
autocmd BufWritePre *.c,*.h :call <SID>StripTrailingWhitespaces()

""" -------------------- Pathogen CONFIG -------------------------
" start pathogen plugin manager
execute pathogen#infect()

" run vimrc from local directory
set exrc

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

""" -------------------- CTags CONFIG -------------------------
" enable ctags
set tags=tags;

""" -------------------- MAPPINGS -------------------------
" switch tabs using Ctrl+[Left/Right]
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" map undo/redo
nnoremap <C-z> :undo<CR>
nnoremap <C-u> :redo<CR>

" map switch windows
nnoremap <Tab> <C-w>w

" map scroll up
nnoremap <C-w> <C-u>

" map scroll down
nnoremap <C-s> <C-d>

" map tag pop
nnoremap <C-a> <C-t>

" map tag expand
nnoremap <C-d> :exec("tag ".expand("<cword>"))<CR>

" map toggling nerd tree
nnoremap <C-p> :NERDTreeToggle<CR>
