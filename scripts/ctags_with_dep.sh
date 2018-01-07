#!/bin/sh

# https://www.topbug.net/blog/2012/03/17/generate-ctags-files-for-c-slash-c-plus-plus-source-files-and-all-of-their-included-header-files/
# ./ctags_with_dep.sh file1.c file2.c ... to generate a tags file for these files.

gcc -M "$@" | sed -e 's/[\\ ]/\n/g' | \
  sed -e '/^$/d' -e '/\.o:[ \t]*$/d' | \
  ctags -L - --c++-kinds=+p --fields=+iaS --extra=+q
