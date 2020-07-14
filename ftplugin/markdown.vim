" Set conceal level so that it's enabled by default.
setlocal conceallevel=2

" Enable YAML syntax in metadata.
let g:vim_markdown_yaml=1

" Enable LaTeX syntax color inside equations and environements.
let g:vim_markdown_latex=1

" Dictionary autocompletion
setlocal spell
setlocal spelllang=fr,en

function! OpenCompletion()
	let col = col('.')
	if !pumvisible() && ((v:char >= 'a' && v:char <= 'z') || (v:char >= 'A' && v:char <= 'Z'))
		call feedkeys("\<C-n>", "n")
	elseif !pumvisible() && v:char == '@'
		call feedkeys("\<C-x>\<c-u>", "n")
	endif
endfunction

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~ '\s'
endfunction

function! CompleteReferences(findstart, base)
	if a:findstart
		" locate the start of the word
		let line = getline('.')
		let start = col('.') - 1
		while start > 0 && line[start - 1] =~ '\a'
			let start -= 1
		endwhile
		return start
	else
		let res = []
		let lnr=1
		let line=getline(lnr)
		while (lnr <= line('$'))
			" TODO: add [-@...] and other
			let reference_list = matchlist(line, '\v\{#' . a:base . '([-A-Za-z0-9:]+)(\s.*)?\}')

			if len(reference_list) >= 2
				let reference = reference_list[1]
			  if reference !=# ''
					call add(res, reference)
				endif
			endif

			let lnr=lnr+1
			let line=getline(lnr)
		endwhile
		return res
	endif
endfunction

augroup completion
	autocmd!
	autocmd InsertCharPre * call OpenCompletion()
augroup END

inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<Tab>" : call OpenCompletion()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

setlocal completefunc=CompleteReferences
setlocal complete=kspell
setlocal completeopt+=menuone,noselect,noinsert
setlocal pumheight=10
