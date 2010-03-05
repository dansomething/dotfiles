"set the window size
set co=100
set lines=50

"hide toolbar
set go-=T

"show file name in tab
set guitablabel=%t

"background dar
set bg=dark

if &background == "dark"
    hi normal guibg=black
	if has("mac")
    	set transp=8
	endif
endif
