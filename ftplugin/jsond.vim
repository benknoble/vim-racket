" Vim filetype plugin
" Language:     Racket (#lang jsond)
" Maintainer:   D. Ben Knoble <ben.knoble+github@gmail.com>
" URL:          https://github.com/benknoble/vim-racket
" Last Change:  2024 May 28

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

" Enable auto begin new comment line when continuing from an old comment line
setlocal comments=:;;;;,:;;;,:;;,:;
setlocal formatoptions+=r

setlocal commentstring=;;\ %s

let b:ale_linter_aliases = ['racket']

" Undo our settings when the filetype changes away from jsond
" (this should be amended if settings/mappings are added above!)
let b:undo_ftplugin =
      \  "setlocal comments< formatoptions<"
      \. " | setlocal commentstring<"
      \. " | unlet! b:ale_linter_aliases"

let &cpo = s:cpo_save
unlet s:cpo_save
