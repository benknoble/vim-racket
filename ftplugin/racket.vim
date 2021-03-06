" Language:     Racket
" Maintainer:   Will Langstroth <will@langstroth.com>
" URL:          http://github.com/wlangstroth/vim-racket

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" quick hack to allow adding values
setlocal iskeyword=@,!,#-',*-:,<-Z,a-z,~,_,^
setl lispwords+=module,module*,module+,parameterize,let-values,let*-values,letrec-values,local
setl lispwords+=define/contract
setl lispwords+=λ
setl lispwords+=with-handlers
setl lispwords+=define-values,opt-lambda,case-lambda,syntax-rules,with-syntax,syntax-case,syntax-parse
setl lispwords+=define-syntax-parse-rule
setl lispwords+=define-signature,unit,unit/sig,compund-unit/sig,define-values/invoke-unit/sig
setl lispwords+=define-opt/c,define-syntax-rule
setl lispwords+=define-test-suite
setl lispwords+=struct

" Racket OOP
setl lispwords+=class,define/public,define/private

" kanren
setl lispwords+=fresh,run,run*,project,conde,condu

" loops
setl lispwords+=for,for/list,for/fold,for*,for*/list,for*/fold,for/or,for/and
setl lispwords+=for/hash,for/sum,for/flvector,for*/flvector,for/vector,for*/vector
setl lispwords+=for/async

setl lispwords+=match,match*,match/values,define/match,match-lambda,match-lambda*,match-lambda**
setl lispwords+=match-let,match-let*,match-let-values,match-let*-values
setl lispwords+=match-letrec,match-define,match-define-values
setl lisp

" Enable auto begin new comment line when continuing from an old comment line
setl comments=:;;;;,:;;;,:;;,:;
setl formatoptions+=r

" Simply setting keywordprg like this works:
"    setl keywordprg=raco\ docs
" but then vim says:
"    "press ENTER or type a command to continue"
" We avoid the annoyance of having to hit enter by remapping K directly.
function s:RacketDoc(word) abort
  execute 'silent !raco docs --' shellescape(a:word)
  redraw!
endfunction
nnoremap <buffer> <Plug>RacketDoc :call <SID>RacketDoc(expand('<cword>'))<CR>
if maparg("K", "n") == ""
  nmap <buffer> K <Plug>RacketDoc
endif

" For the visual mode K mapping, it's slightly more convoluted to get the 
" selected text:
function! s:Racket_visual_doc()
  try
    let l:old_a = @a
    normal! gv"ay
    call system("raco docs '". @a . "'")
    redraw!
    return @a
  finally
    let @a = l:old_a
  endtry
endfunction

vnoremap <buffer> <Plug>RacketDoc :call <SID>Racket_visual_doc()<cr>
if maparg("K", "v") == ""
  vmap <buffer> K <Plug>RacketDoc
endif

"setl commentstring=;;%s
setl commentstring=#\|\ %s\ \|#

" Undo our settings when the filetype changes away from Racket
" (this should be amended if settings/mappings are added above!)
let b:undo_ftplugin =
      \  "setl iskeyword< lispwords< lisp< comments< formatoptions<"
      \. "| setl commentstring<"
      \. "| nunmap <buffer> K"
      \. "| vunmap <buffer> K"
