function! s:DetermineProtocol(mode)
	if(a:mode ==# 'v')
		execute "normal! `<v`>x"
	else
		execute "normal! diW"
	endif
	let address = @"
	let protocol = matchstr(address, '\(:\/\/\)')

	if empty(protocol)
		echom match(address, '@')
		if(match(address, '@') > 1)
			return "mailto:"
		else
			return "http://"
		endif
	else
		return ""
	endif
endfunction

function! s:CreateVisualAnchor(change_value, attributes)
	let protocol = s:DetermineProtocol('v')
	if a:change_value == 1
		execute "normal! i<a href=\"" . protocol ."\<esc>pa\"" . a:attributes . ">\<esc>pa</a>\<esc>1T>vt<"
	else
		execute "normal! i<a href=\"" . protocol ."\<esc>pa\"" . a:attributes . ">\<esc>pa</a>\<esc>2F<v2f>"
	endif
endfunction

function! s:CreateInsertAnchor(change_value, attributes)
	let protocol = s:DetermineProtocol('i')
	if a:change_value == 1
		execute "normal! i<a href=\"" . protocol . "\<esc>pa\"" . a:attributes . ">\<esc>pa</a> \<esc>2T>vt<"
	else
		execute "normal! i<a href=\"" . protocol . "\<esc>pa\"" . a:attributes . ">\<esc>pa</a> \<esc>"
	endif
endfunction

function! s:CreateNormalAnchor(change_value, attributes)
	let protocol = s:DetermineProtocol('n')
	if a:change_value == 1
		execute "normal! i<a href=\"" . protocol . "\<esc>pa\"" . a:attributes . ">\<esc>pa</a> \<esc>2T>vt<"
	else
		execute "normal! i<a href=\"" . protocol . "\<esc>pa\"" . a:attributes . ">\<esc>pa</a> \<esc>"
	endif
endfunction

function! s:CreateAnchor(mode, ...)
	let s:current_yank = @"
	
	let s:attributes = ""
	if exists("a:2")
		let s:attributes = a:2
	endif

	if a:mode ==# 'v'
		call s:CreateVisualAnchor(a:1, s:attributes)
	elseif a:mode ==# 'i'
		call s:CreateInsertAnchor(a:1, s:attributes)
	elseif a:mode ==# 'n'
		call s:CreateNormalAnchor(a:1, s:attributes)
	endif
	let @" = s:current_yank
endfunction

nnoremap <buffer> <localleader>ay :call <SID>CreateAnchor("n", 1, ' class="" target="_blank"')<cr>
nnoremap <buffer> <localleader>an :call <SID>CreateAnchor("n", 0)<cr>
inoremap <buffer> <localleader>ay <esc>:call <SID>CreateAnchor("i",1)<cr>
inoremap <buffer> <localleader>an <esc>:call <SID>CreateAnchor("i",0)<cr>a
vnoremap <buffer> <localleader>ay :<c-u>call <SID>CreateAnchor(visualmode(), 1)<cr>
vnoremap <buffer> <localleader>an :<c-u>call <SID>CreateAnchor(visualmode(),0)<cr>
