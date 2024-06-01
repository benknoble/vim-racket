" Vim indent file
" Language:             Zuo
" Maintainer:           D. Ben Knoble <ben.knoble+github@gmail.com>
" URL:                  https://github.com/benknoble/vim-racket
" Last Change:          2024 May 12

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal lisp autoindent nosmartindent
if has('vim9script')
  setlocal indentexpr=racket#Indent() lispoptions+=expr:1
endif

setlocal lispwords=
setlocal lispwords+=lambda,let,let*,letrec
setlocal lispwords+=when,unless,cond,begin
setlocal lispwords+=quote,quasiquote,unquote,unquote-splicing,quote-syntax
setlocal lispwords+=quote-module-path
setlocal lispwords+=define,define-syntax,struct
setlocal lispwords+=include,require,provide,module+
setlocal lispwords+=at-source
setlocal lispwords+=provide-targets,bounce-to-targets
setlocal lispwords+=command-line

let b:undo_indent = "setlocal lisp< ai< si< lw<" .. (has('vim9script') ? ' indentexpr< lispoptions<' : '')
