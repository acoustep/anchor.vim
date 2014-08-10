function! s:CreateAnchor()
	let s:current_yank = @"
	execute "normal! diWa<a href=\"http://\<esc>pa\">\<esc>pa</a>\<esc>"
	let @" = s:current_yank
endfunction

nnoremap <buffer> <localleader>a :call <SID>CreateAnchor()<cr>
