# vim-racket

See also [Vim in the Racket Guide](https://docs.racket-lang.org/guide/Vim.html).

Installation
------------

This module works with native packages and many Vim plugin managers. To use with
pathogen, type the following into a terminal:

    cd ~/.vim/bundle
    git clone https://github.com/benknoble/vim-racket.git

Re-open your file(s) and benefit from the features of _vim-racket_. See [`:help
racket`](./doc/racket.txt) for more details.

Pairs well with
[rparen.vim](https://gist.github.com/plane/8c872ed174ba4f026b95ea8eb934cead), a
global mapping on `]` to insert the right closer. [Here is one updated version
of the same
script](https://github.com/benknoble/Dotfiles/blob/master/links/vim/autoload/rparen.vim)

## Thanks

This version is an updated fork of
[wlangstroth/vim-racket](https://github.com/wlangstroth/vim-racket) with
improved Racket support.

Most of the real work on this module was done by [Dale
Vaillancourt](https://github.com/dalev), [Paul
Cannon](https://github.com/thepaul) and [Asumu
Takikawa](https://github.com/takikawa).

To see all the contributors,

    git shortlog -sn
