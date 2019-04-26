" duplicate current tab into a new tab
function! SplitTab()
    let l = line(".")
    let c = col(".")
    :tabe %
    call cursor(l, c)
endfun

" remove trailing whitespace from lines and preserve cursor position
function! StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" custom command for performing search in all source files
command! -nargs=1 Search vimgrep <args> **/*.c **/*.cpp **/*.h **/*.json | cw

" find-replace current word under cursor with given parameter
command! -nargs=1 ReplaceWith :exec("%s/\\<".expand("<cword>")."\\>/<args>/gc")
