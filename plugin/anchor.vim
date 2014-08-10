function! s:CreateAnchor()
	execute "normal! diWa<a href=\"http://\<esc>pa\">\<esc>pa</a>\<esc>"
endfunction

nnoremap <buffer> <localleader>a :call <SID>CreateAnchor()<cr>
