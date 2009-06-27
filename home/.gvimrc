"set the window size
set co=100
set lines=50

"hide toolbar
set go-=T

"background dar
set bg=dark

if &background == "dark"
    hi normal guibg=black
    set transp=8
endif
