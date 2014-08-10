function! s:CreateVisualAnchor(change_value)
	if a:change_value == 1
		echom "yes"
		execute "normal `<v`>xa<a href=\"http://\<esc>pa\">\<esc>pa</a>\<esc>1T>vt<"
	else
		echom "no"
		execute "normal `<v`>xa<a href=\"http://\<esc>pa\">\<esc>pa</a>\<esc>2F<v2f>"
	endif
endfunction

function! s:CreateInsertAnchor(change_value)
	if a:change_value == 1
		execute "normal! diWi<a href=\"http://\<esc>pa\">\<esc>pa</a> \<esc>2T>vt<"
	else
		execute "normal! diWi<a href=\"http://\<esc>pa\">\<esc>pa</a> \<esc>"
	endif
endfunction

function! s:CreateNormalAnchor(change_value)
	if a:change_value == 1
		execute "normal! diWi<a href=\"http://\<esc>pa\">\<esc>pa</a> \<esc>2T>vt<"
	else
		execute "normal! diWi<a href=\"http://\<esc>pa\">\<esc>pa</a> \<esc>"
	endif
endfunction

function! s:CreateAnchor(mode, ...)
	let s:current_yank = @"
	if a:mode ==# 'v'
		call s:CreateVisualAnchor(a:1)
	elseif a:mode ==# 'i'
		call s:CreateInsertAnchor(a:1)
	elseif a:mode ==# 'n'
		call s:CreateNormalAnchor(a:1)
	endif
	let @" = s:current_yank
endfunction

nnoremap <buffer> <localleader>ay :call <SID>CreateAnchor("n", 1)<cr>
nnoremap <buffer> <localleader>an :call <SID>CreateAnchor("n", 0)<cr>
inoremap <buffer> <localleader>ay <esc>:call <SID>CreateAnchor("i",1)<cr>a
inoremap <buffer> <localleader>an <esc>:call <SID>CreateAnchor("i",0)<cr>a
vnoremap <buffer> <localleader>ay :<c-u>call <SID>CreateAnchor(visualmode(), 1)<cr>
vnoremap <buffer> <localleader>an :<c-u>call <SID>CreateAnchor(visualmode(),0)<cr>
