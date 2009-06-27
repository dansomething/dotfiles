"
" Settings for PHP filetype
"

" Load PHP Documentor for VIM
source ~/.vim/php-doc.vim

" Set up automatic formatting
setlocal formatoptions+=tcqlro

" Jump to matching bracket for 3/10th of a second (works with showmatch)
setlocal matchtime=3
setlocal showmatch

" Set maximum text width (for wrapping)
setlocal textwidth=80

"
" Syntax options
"
" Enable folding of class/function blocks
let php_folding = 1

" Do not use short tags to find PHP blocks
let php_noShortTags = 1

" Highlighti SQL inside PHP strings
let php_sql_query=1


"
" Linting
"
" Use PHP syntax check when doing :make
setlocal makeprg=php\ -l\ %

" Parse PHP error output
setlocal errorformat=%m\ in\ %f\ on\ line\ %l

" Function to locate endpoints of a PHP block {{{
function! PhpBlockSelect(mode)
	let motion = "v"
	let line = getline(".")
	let pos = col(".")-1
	let end = col("$")-1

	if a:mode == 1
		if line[pos] == '?' && pos+1 < end && line[pos+1] == '>'
			let motion .= "l"
		elseif line[pos] == '>' && pos > 1 && line[pos-1] == '?'
			" do nothing
		else
			let motion .= "/?>/e\<CR>"
		endif
		let motion .= "o"
		if end > 0
			let motion .= "l"
		endif
		let motion .= "?<\\?php\\>\<CR>"
	else
		if line[pos] == '?' && pos+1 < end && line[pos+1] == '>'
			" do nothing
		elseif line[pos] == '>' && pos > 1 && line[pos-1] == '?'
			let motion .= "h?\\S\<CR>""
		else
			let motion .= "/?>/;?\\S\<CR>"
		endif
		let motion .= "o?<\\?php\\>\<CR>4l/\\S\<CR>"
	endif

	return motion
endfunction
" }}}

" Mappings to select full/inner PHP block
nmap <silent> <expr> vaP PhpBlockSelect(1)
nmap <silent> <expr> viP PhpBlockSelect(0)
" Mappings for operator mode to work on full/inner PHP block
omap <silent> aP :silent normal vaP<CR>
omap <silent> iP :silent normal viP<CR>

" Mappings for PHP Documentor for VIM
inoremap <buffer> <C-P> <Esc>:call PhpDocSingle()<CR>i
nnoremap <buffer> <C-P> :call PhpDocSingle()<CR>
vnoremap <buffer> <C-P> :call PhpDocRange()<CR>

" Map <CTRL>-a to alignment function
vnoremap <C-a> :call PhpAlign()<CR>

" Map <CTRL>-a to (un-)comment function
vnoremap <C-c> :call PhpUnComment()<CR>

" Generate @uses tag based on inheritance info
let g:pdv_cfg_Uses = 1
" Set default Copyright
let g:pdv_cfg_Copyright = "Copyright (C) 2008 Beaport LLC"

" Match for control structures begin and end points
let s:match_words = ""

if exists("b:match_words")
    let s:match_words = b:match_words
endif

setlocal include=\\\(require\\\|include\\\)\\\(_once\\\)\\\?
setlocal iskeyword+=$
if exists("loaded_matchit")
    let b:match_words = '\<switch\>:\<endswitch\>,' .
		      \ '\<if\>:\<elseif\>:\<else\>:\<endif\>,' .
		      \ '\<while\>:\<endwhile\>,' .
		      \ '\<do\>:\<while\>,' .
		      \ '\<for\>:\<endfor\>,' .
		      \ '\<foreach\>:\<endforeach\>,' .
		      \ s:match_words
endif

" Exuberant Ctags
"
" Map <F4> to re-build tags file
nmap <silent> <F4>
		\ :!ctags-ex -f ./tags 
		\ --langmap="php:+.inc"
		\ -h ".php.inc" -R --totals=yes
		\ --tag-relative=yes --PHP-kinds=+cf-v .<CR>

" Set tag filename(s)
setlocal tags=./tags,tags

" vim: set fdm=marker:

" {{{ Alignment

func! PhpAlign() range
    let l:paste = &g:paste
    let &g:paste = 0

    let l:line        = a:firstline
    let l:endline     = a:lastline
    let l:maxlength = 0
    while l:line <= l:endline
		" Skip comment lines
		if getline (l:line) =~ '^\s*\/\/.*$'
			let l:line = l:line + 1
			continue
		endif
		" \{-\} matches ungreed *
        let l:index = substitute (getline (l:line), '^\s*\(.\{-\}\)\s*\S\{0,1}=\S\{0,1\}\s.*$', '\1', "") 
        let l:indexlength = strlen (l:index)
        let l:maxlength = l:indexlength > l:maxlength ? l:indexlength : l:maxlength
        let l:line = l:line + 1
    endwhile
    
	let l:line = a:firstline
	let l:format = "%s%-" . l:maxlength . "s %s %s"
    
	while l:line <= l:endline
		if getline (l:line) =~ '^\s*\/\/.*$'
			let l:line = l:line + 1
			continue
		endif
        let l:linestart = substitute (getline (l:line), '^\(\s*\).*', '\1', "")
        let l:linekey   = substitute (getline (l:line), '^\s*\(.\{-\}\)\s*\(\S\{0,1}=\S\{0,1\}\)\s\(.*\)$', '\1', "")
        let l:linesep   = substitute (getline (l:line), '^\s*\(.\{-\}\)\s*\(\S\{0,1}=\S\{0,1\}\)\s\(.*\)$', '\2', "")
        let l:linevalue = substitute (getline (l:line), '^\s*\(.\{-\}\)\s*\(\S\{0,1}=\S\{0,1\}\)\s\(.*\)$', '\3', "")

        let l:newline = printf (l:format, l:linestart, l:linekey, l:linesep, l:linevalue)
        call setline (l:line, l:newline)
        let l:line = l:line + 1
    endwhile
    let &g:paste = l:paste
endfunc

" }}}

" {{{ (Un-)comment

func! PhpUnComment() range
    let l:paste = &g:paste
    let &g:paste = 0

    let l:line        = a:firstline
    let l:endline     = a:lastline

	while l:line <= l:endline
		if getline (l:line) =~ '^\s*\/\/.*$'
			let l:newline = substitute (getline (l:line), '^\(\s*\)\/\/ \(.*\).*$', '\1\2', '')
		else
			let l:newline = substitute (getline (l:line), '^\(\s*\)\(.*\)$', '\1// \2', '')
		endif
		call setline (l:line, l:newline)
		let l:line = l:line + 1
	endwhile

    let &g:paste = l:paste
endfunc

" }}}
