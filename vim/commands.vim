
" remove trailing whitespace from lines and preserve cursor position
function! StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" Toggle between displaying/hiding tabs
function! ShowTabsToggle()
    set listchars=tab:>-
    set list!
endfun

command! -nargs=0 ShowTabsToggle :call ShowTabsToggle()

" Make Ag (Ctrl-G) not include filenames in search output
command! -bang -nargs=* AgNoFiles call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

