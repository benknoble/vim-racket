let g:racket_hash_lang_modifiers =
      \ extend(get(g:, 'racket_hash_lang_modifiers', []), [
      \ 'at-exp',
      \ 's-exp',
      \ 'errortrace',
      \ 'pollen/mode',
      \ 'debug',
      \ ])

let g:racket_hash_lang_modifiers_regex =
      \ get(g:, 'racket_hash_lang_modifiers_regex',
      \ '\%('.
      \     join(map(deepcopy(g:racket_hash_lang_modifiers),
      \              {_, v -> printf('\<%s\>', escape(v, '\'))}),
      \     '\|')
      \ .'\)')

let g:racket_hash_lang_regexp = get(g:, 'racket_hash_lang_regexp',
      \ '^#lang\s\+\%\('.g:racket_hash_lang_modifiers_regex.'\s\+\)\?\([^][)(}{[:space:]]\+\)')
let g:racket_hash_lang_dict =
      \ extend(get(g:, 'racket_hash_lang_dict', #{}), {
      \   'racket/base': 'racket',
      \   'racket/gui': 'racket',
      \   'racket/gui/easy': 'racket',
      \   'racket/unit': 'racket',
      \   'racket/signature': 'racket',
      \   'typed/racket': 'racket',
      \   'typed/racket/base': 'racket',
      \   'br': 'racket',
      \   'br/quicklang': 'racket',
      \   'scribble/base': 'scribble',
      \   'scribble/manual': 'scribble',
      \   'info': 'racket-info',
      \   'setup/infotab': 'racket-info',
      \   'syntax/module-reader': 'racket',
      \   'slideshow': 'racket',
      \   'plai': 'racket',
      \   'eopl': 'racket',
      \   'htdp/bsl': 'racket',
      \   'htdp/bsl+': 'racket',
      \   'htdp/isl': 'racket',
      \   'htdp/isl+': 'racket',
      \   'htdp/asl': 'racket',
      \   'web-server/base': 'racket',
      \   'web-server': 'racket',
      \   'web-server/insta': 'racket',
      \   'sicp': 'racket',
      \   'scheme/base': 'scheme',
      \   'zuo/kernel': 'zuo',
      \   'zuo/datum': 'zuo',
      \   'zuo/hygienic': 'zuo',
      \   'zuo/base': 'zuo',
      \ }, 'keep') " keep prefers user dict to the default

" Tries to detect filetype from #lang line; defaults to ft=racket.
function! RacketDetectHashLang()
  let matches = matchlist(getline(1), g:racket_hash_lang_regexp)
  if ! empty(matches)
    execute 'set filetype='.get(g:racket_hash_lang_dict, matches[1], substitute(matches[1], '[/\*?[|<>]', '', 'g'))
  else
    set filetype=racket
  endif
endfunction

au BufRead,BufNewFile *.rkt,*.rktl,*.zuo call RacketDetectHashLang()
