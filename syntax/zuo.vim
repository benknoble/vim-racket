" Vim syntax file
" Language:             Zuo
" Maintainer:           D. Ben Knoble <ben.knoble+github@gmail.com>
" URL:                  https://github.com/benknoble/vim-racket
" Last Change:          2024 May 12

" Initializing:
if exists("b:current_syntax")
  finish
endif

" Highlight unmatched parens
syntax match zuoError ,[]})],

if version < 800
  set iskeyword=33,35-39,42-58,60-90,94,95,97-122,126,_
else
  " syntax iskeyword 33,35-39,42-58,60-90,94,95,97-122,126,_
  " converted from decimal to char
  " :s/\d\+/\=submatch(0)->str2nr()->nr2char()/g
  " but corrected to remove duplicate _, move ^ to end
  syntax iskeyword @,!,#-',*-:,<-Z,a-z,~,_,^
  " expanded
  " syntax iskeyword !,#,$,%,&,',*,+,,,-,.,/,0-9,:,<,=,>,?,@,A-Z,_,a-z,~,^
endif

" Forms in order of appearance at
" https://docs.racket-lang.org/zuo/index.html
"

" 2.2 Binding and Control Forms
" 2.2.1 Expression Forms
syntax keyword zuoSyntax lambda let let* letrec
syntax keyword zuoSyntax if and or when unless cond else begin
syntax keyword zuoSyntax quote quasiquote unquote unquote-splicing quote-syntax
syntax keyword zuoSyntax quote-module-path

" 2.2.2 Definition Forms
syntax keyword zuoSyntax define define-syntax struct
syntax keyword zuoSyntax include require provide module+

" 2.3 Booleans
syntax keyword zuoFunc boolean? not eq? equal?

" 2.4 Numbers
syntax keyword zuoFunc integer? + - * quotient remainder modulo = < <= > >=
syntax keyword zuoFunc bitwise-ior bitwise-and bitwise-xor bitwise-not

" 2.5 Pairs and Lists
syntax keyword zuoFunc pair? null? list? cons car cdr list list* append reverse length list-ref list-set list-tail
syntax keyword zuoFunc caar cadr cdar cddr
syntax keyword zuoFunc map for-each foldl andmap ormap filter sort
syntax keyword zuoFunc member assoc remove

" 2.6 Strings
syntax keyword zuoFunc string? string string-length string-ref substring string=? string-ci=? string<?
syntax keyword zuoFunc string-u32-ref string->integer string-sha256 char string-split string-join string-trim string-tree?

" 2.7 Symbols
syntax keyword zuoFunc symbol? symbol->string string->symbol string->uninterned-symbol

" 2.8 Hash Tables (Persistent Maps)
syntax keyword zuoFunc hash? hash hash-ref hash-set hash-remove hash-keys hash-count hash-keys-subset?

" 2.9 Procedures
syntax keyword zuoFunc procedure? apply call/cc call/prompt continuation-prompt-available?

" 2.10 Paths
syntax keyword zuoFunc path-string? relative-path? build-raw-path build-path
syntax keyword zuoFunc split-path explode-path simple-form-path find-relative-path path-only
syntax keyword zuoFunc file-name-from-path path->complete-path path-replace-extension
syntax keyword zuoSyntax at-source

" 2.11 Opaque Records
syntax keyword zuoFunc opaque opaque-ref

" 2.12 Variables
syntax keyword zuoFunc variable? variable variable-set! variable-ref

" 2.13 Modules and Evaluation
syntax keyword zuoFunc module-path? build-module-path module->hash dynamic-require kernel-eval kernel-env

" 2.14 Void
syntax keyword zuoFunc void void?

" 2.15 Reading and Writing Objects
syntax keyword zuoFunc string-read ~v ~a ~s display displayln error alert arity-error arg-error

" 2.16 Syntax Objects
syntax keyword zuoFunc identifier? syntax-e syntax->datum datum->syntax bound-identifier=? syntax-error
syntax keyword zuoFunc bad-syntax misplaced-syntax duplicate-identifier context-consumer context-consumer?

" 2.17 Files, Streams, and Processes
syntax keyword zuoFunc handle? fd-open-input fd-open-output
syntax keyword zuoConstant :error :truncate :must-truncate :append :update :can-update
syntax keyword zuoFunc fd-close fd-read fd-write fd-poll fd-terminal? fd-valid? file->string display-to-file
syntax keyword zuoConstant eof
syntax keyword zuoFunc cleanable-file cleanable-cancel process process-wait process-status find-executable-path string->shell shell->strings

" 2.18 Filesystem
syntax keyword zuoFunc stat ls ls* rm rm* mv mkdir mkdir-p rmdir symlink readlink cp
syntax keyword zuoConstant :no-replace-mode
syntax keyword zuoFunc cp* file-exists? directory-exists? link-exists?

" 2.19 Run Time Configuration
syntax keyword zuoFunc runtime-env system-type current-time dump-image-and-exit exit suspend-signal resume-signal

" 3 zuo/build
" 3.5 Build API
syntax keyword zuoFunc target? target-name target-path target-shell input-file-target input-data-target target
syntax keyword zuoFunc rule rule? phony-rule phony-rule? token?
syntax keyword zuoFunc build build/dep build/no-dep build/command-line build/command-line*
syntax keyword zuoFunc find-target make-at-dir command-target? command-target->target
syntax keyword zuoFunc file-sha256 sha256?
syntax keyword zuoConstant sha256-length no-sha256
syntax keyword zuoSyntax provide-targets bounce-to-targets
syntax keyword zuoFunc make-targets

" 4 Zuo Libraries
" 4.1 zuo/cmdline
syntax keyword zuoSyntax command-line :program :preamble :usage :args-in :init :multi :once-each :once-any

" 4.2 zuo/glob
syntax keyword zuoFunc glob->matcher glob-match?

" 4.3 zuo/thread
syntax keyword zuoFunc call-in-main-thread thread thread? channel channel? channel-put channel-get channel-try-get thread-process-wait

" 4.4 zuo/shell
syntax keyword zuoFunc shell shell/wait build-shell shell-subst

" 4.5 zuo/c
syntax keyword zuoFunc c-compile c-link c-ar .c->.o .exe .a config-merge config-include config-define

" 4.6 zuo/config
syntax keyword zuoFunc config-file->hash

" 4.7 zuo/jobserver
syntax keyword zuoFunc maybe-jobserver-client maybe-jobserver-jobs

" 4.8 zuo/dry-run
syntax keyword zuoFunc maybe-dry-run-mode

syntax cluster zuoTop contains=zuoSyntax,zuoFunc,zuoDelimiter

" Non-quoted lists
syntax region zuoStruc matchgroup=zuoParen start="("rs=s+1 end=")"re=e-1 contains=@zuoTop
syntax region zuoStruc matchgroup=zuoParen start="\["rs=s+1 end="\]"re=e-1 contains=@zuoTop

" Simple literals

syntax match zuoStringEscapeError "\\." contained display
syntax match zuoStringEscape "\\["\\nrt]"        contained display
syntax match zuoStringEscape "\\\o\{1,3}" contained display
syntax region zuoString start=/\%(\\\)\@<!"/ skip=/\\[\\"]/ end=/"/ contains=zuoStringEscapeError,zuoStringEscape,zuoUStringEscape
syntax region zuoString start=/#"/           skip=/\\[\\"]/ end=/"/ contains=zuoStringEscapeError,zuoStringEscape
syntax match zuoNumber /\<-\?\d\+\>/
syntax keyword zuoBoolean  #t #f #true #false
syntax match zuoError   "\<#\\\k*\>"

syntax match zuoDelimiter !\<\.\>!
syntax match zuoConstant  ,\<<\k\+>\>,

syntax cluster zuoTop  add=zuoError,zuoConstant,zuoStruc,zuoString
syntax cluster zuoTop  add=zuoNumber,zuoBoolean

syntax match zuoSyntax    "#lang "

" syntax quoting, unquoting and quasiquotation
syntax match zuoQuote "['`]"

syntax match zuoUnquote "#,"
syntax match zuoUnquote "#,@"
syntax match zuoUnquote ","
syntax match zuoUnquote ",@"

" Comments
syntax match zuoSharpBang "\%^#![ /].*" display
syntax match zuoComment /;.*$/ contains=zuoTodo,zuoNote,@Spell
syntax match zuoFormComment "#;" nextgroup=@zuoTop

syntax match zuoTodo /\C\<\(FIXME\|TODO\|XXX\)\ze:\?\>/ contained
syntax match zuoNote /\CNOTE\ze:\?/ contained

syntax cluster zuoTop  add=zuoQuote,zuoUnquote,zuoComment,zuoMultilineComment,zuoFormComment

" Synchronization and the wrapping up...
syntax sync match matchPlace grouphere NONE "^[^ \t]"
" ... i.e. synchronize on a line that starts at the left margin

" Define the default highlighting.
highlight default link zuoSyntax Statement
highlight default link zuoFunc Function

highlight default link zuoString String
highlight default link zuoStringEscape Special
highlight default link zuoUStringEscape Special
highlight default link zuoStringEscapeError Error
highlight default link zuoBoolean Boolean

highlight default link zuoNumber Number

highlight default link zuoQuote SpecialChar
highlight default link zuoUnquote SpecialChar

highlight default link zuoDelimiter Delimiter
highlight default link zuoParen Delimiter
highlight default link zuoConstant Constant

highlight default link zuoComment Comment
highlight default link zuoMultilineComment Comment
highlight default link zuoFormComment SpecialChar
highlight default link zuoSharpBang Comment
highlight default link zuoTodo Todo
highlight default link zuoNote SpecialComment
highlight default link zuoError Error

let b:current_syntax = "zuo"
