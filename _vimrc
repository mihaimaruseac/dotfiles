" Created by MM
" Last updated: 160208.1916
" Add ack integration (via :grep)

" globals
set modeline
filetype indent on
syntax on
set mouse=a
set incsearch
set sm "showmatch
set ai "autoindent
set smartindent
set formatoptions+=r
set autowrite
set list listchars=tab:»\ ,trail:·,extends:»,precedes:« "whitespaces
set tw=79 "implicit textwidth
set hls "highlight search
set spell

au FileType c,cpp,cu set tw=78 cino=:0 foldmethod=syntax
au FileType haskell set tw=78 sw=2 sts=2 et
au FileType cabal set tw=78 sw=2 sts=2 et
au FileType python set ai sw=4 sts=4 et tw=78
au FileType matlab set sw=2 sts=2 noet
"au FileType java set ai noet sw=2 sts=2 cin tw=78
au FileType java set tw=80
au FileType tex set ai et sw=2 sts=2 tw=78
"au FileType tex so ~/.vim/abbrevs.vim " from ddvlad - LaTeX mappings
" from ddvlad, ease filetype recognition
au BufRead,BufNewFile *.tex setlocal ft=tex
au FileType html set ai et sw=2 sts=2 tw=78
au FileType xml set ai et sw=2 sts=2 tw=78
au FileType sh set ai et sw=4 sts=4
au FileType v set ai et sw=4 sts=4 tw=78
au FileType vhdl set ai et sw=4 sts=4 tw=78
au BufRead,BufNewFile *.md setlocal ft=markdown
au FileType markdown set ai et sw=4 sts=4 tw=78
au BufRead,BufNewFile SCons* setlocal ft=python

" from Alexandru Moșoi via ddvlad
set statusline=%<%f\ %y%h%m%r%=%-24.(0x%02B,%l/%L,%c%V%)\ %P
set laststatus=2
set wildmenu

nnoremap <Tab> :cnext<Cr>
nnoremap <S-Tab> :cprev<Cr>
nnoremap <F9> :make<Cr>

" from Cosmin Ratiu via ddvlad
" updated by MM on 131504.1349: prevent cscope from complaining about duplicate
" dbs; use vertical windows for search results
if has("cscope")
        set csto=0	" Use cscope first, then ctags
        set cst		" Only search cscope
        set nocsverb	" Make cs verbose

        " Look for a 'cscope.out' file starting from the current directory,
        " going up to the root directory.
        let s:dirs = split(getcwd(), "/")
        while s:dirs != []
                let s:path = "/" . join(s:dirs, "/")
                if (filereadable(s:path . "/cscope.out"))
                        execute "cs add " . s:path . "/cscope.out " . s:path . " -v"
                        break
                endif
                let s:dirs = s:dirs[:-2]
        endwhile

        set csverb	" Make cscope verbose after loading databases

        nmap <C-\>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
        nmap <C-\>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
        nmap <C-\>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
        nmap <C-\>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
        nmap <C-\>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
        nmap <C-\>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
        nmap <C-\>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
        nmap <C-\>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

        " Open a quickfix window for the following queries.
        set cscopequickfix=s-,g-,c-,t-,e-,f-,i-,d-
endif

" From ezyang, http://blog.ezyang.com/2010/03/vim-textwidth/
augroup highlight_over_79
	autocmd BufEnter * highlight OverLength ctermbg=lightgrey guibg=#592929
	autocmd BufEnter * match OverLength /\%79v.*/
augroup END

" https://pbrisbin.com/posts/sharpening_your_tools/
"set winwidth=84
"set winheight=5
"set winminheight=5
"set winheight=999

" use :grep from inside vim to search using ack
set grepprg=ag
