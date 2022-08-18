" latex indent maybe ? probably a bad idea
setlocal indentexpr=MarkdownIndent()

function! MarkdownIndent()
	let line = getline(v:lnum)
	let previousNum = prevnonblank(v:lnum - 1)
	let previous = getline(previousNum)

	if previous =~ "{" && previous !~ "}" && line !~ "}" && line !~ ":$"
		return indent(previousNum) + &tabstop
	endif
endfunction
