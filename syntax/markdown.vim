if exists("b:current_syntax")
	finish
endif

" #b76935ff
" #a56336ff
" #935e38ff
" #815839ff
" #6f523bff
" #5c4d3cff
" #4a473eff
" #38413fff
" #263c41ff
" #143642ff

" Headers
syntax match mdH1 "\v^(# .*$\n\s*|[^#]+( \{.+\})?$\n\=\=+\s*)$" contains=mdLatexInlineEq,mdRefDef
syntax match mdH2 "\v^(## .*$\n\s*|[^#]+( \{.+\})?$\n--+\s*)$"  contains=mdLatexInlineEq,mdRefDef
syntax match mdH3 "\v^### .*$\n\s*$"                            contains=mdLatexInlineEq,mdRefDef
syntax match mdH4 "\v^#### .*$\n\s*$"                           contains=mdLatexInlineEq,mdRefDef
syntax match mdH5 "\v^##### .*$\n\s*$"                          contains=mdLatexInlineEq,mdRefDef
syntax match mdH6 "\v^###### .*$\n\s*$"                         contains=mdLatexInlineEq,mdRefDef
syntax match mdInvalidH "\v^#######+ .*$"

" Strikethrough, quote, code
" Bold, Italic
syntax region mdItalic        concealends matchgroup=mdFormat start="\v(_|\*)"    end="\v(_|\*)"
syntax region mdBold          concealends matchgroup=mdFormat start="\v(__|\*\*)" end="\v(__|\*\*)"
syntax region mdStrikeThrough concealends matchgroup=mdFormat start="\v\~\~"      end="\v\~\~"
syntax region mdInlineCode    concealends matchgroup=mdFormat start="\v`"         end="\v`"
syntax region mdQuote         concealends matchgroup=mdFormat start="\v\> "       end="\v$" oneline

" Lists
syntax match mdList "\v^\s*(* |\+ |(\d|#)\. |- (\[(\s|X|x)\])?)"

" Block of code
syntax region mdBlockCode start="\v```" end="\v```" fold

" C/C++ code in code blocks
syntax include @c syntax/cpp.vim
syntax region mdBlockCode start="\v```(c|cpp)" end="\v```" fold contains=@c keepend
unlet! b:current_syntax

" Links
syntax match mdLink "\v\[.+\]\(.+\)( \{.+\})?" contains=mdUrl,mdText,mdRefDef " TODO: option syntax inside {} / for titles too
syntax match mdText "\v[^\(\)\[\]!\{\}#]+"     contained " TODO: improve url and text regexp
syntax match mdUrl "\v(https?://)?(www.)?[-a-zA-Z0-9_]{1,256}(\.[a-zA-Z_]{1,6})+(/[-a-zA-Z0-9_]+)*/?" contained

" Images
syntax match mdImage "\v!\[.+\]\(.+\)( \{.+\})?" contains=mdPath,mdText,mdRefDef
syntax match  mdPath "\v(/|\~/)?([-_0-9a-zA-Z]+/)*([-A-Za-z_0-9]|\\ )+\.[a-zA-Z0-9]+"  contained " TODO: should space be escaped ?

" Tables
" TODO: is it possible to handle column width ?
" TODO: improve this in order to allow =, - and + in TableRowText and TableHeaderText
" TODO: use matchgroup ? nextgroup ?
syntax region mdTableRow    start="\v\|(.*\|)+\s*$" end="\v\+(-+\+)+\s*$"  contains=mdTableText
syntax region mdTableHeader start="\v\+(-+\+)+\s*$" end="\v\+(\=+\+)+\s*$" contains=mdTableHeaderText

" TODO: text ascii input ?
syntax match mdTableText       "\v[^\|\-\+\=]+" contained containedin=mdTableRow contains=mdLatexInlineEq
syntax match mdTableHeaderText "\v[^\|\-\+\=]+" contained containedin=mdTableHeader

" Import LaTeX syntax
if get(g:, 'vim_markdown_latex', 0)
	syntax include @tex syntax/tex.vim

	" Math
	syntax region mdLatexInlineEq start="\v\$([^\$]|\\)" end="\v\$" contains=@tex keepend
	syntax region mdLatexEquation start="\v\$\$([^\$]|\\)" end="\v\$\$" contains=@tex keepend

	" begin/end LaTeX env/function
	syntax match mdLatexFunc "\v\\[a-z]+(\{(.+)?\})?" contains=@tex keepend
	syntax region mdLatexEnv start="\v\\begin\{.*\}" end="\v\\end\{.*\}" contains=@tex keepend

	unlet! b:current_syntax
endif

" references: [@sec:...], @eq:..., [@fig:...], [@...:...]
syntax match   mdCiteProcRef "\v\[\@\S+\]"              contains=mdRefText
syntax match   mdCrossRef    "\v\[-?\@[a-z]+:\S+\]"     contains=mdRefText,mdRefKeyword
syntax match   mdRefDef      "\v\{#[a-z]+:.+\}"         contains=mdRefText,mdRefKeyword
syntax match   mdRefText     "\v[-0-9A-Za-z]+"          contains=mdRefKeyword contained containedin=mdCiteProcRef,mdCrossRef
syntax match   mdEqnosRef    "\v\@[a-z]+:[-a-zA-Z0-9]+" contains=mdRefKeyword,mdRefText
syntax keyword mdRefKeyword  eq sec fig tab             containedin=mdRefText contained

" YAML metadata
if get(g:, 'vim_markdown_yaml', 0)
	syntax include @yamlTop syntax/yaml.vim
	" syn region Comment matchgroup=mkdDelimiter start="\%^---$" end="^\(---\|\.\.\.\)$" contains=@yamlTop keepend
	syntax region mdYamlMetadata start="\v%^---\s*$" end="\v^---\s*$" contains=@yamlTop keepend
	unlet! b:current_syntax
endif

" HTML
syntax include @html syntax/html.vim
syntax region mdHTML start="\v\<" end="\v\>" contains=@html keepend
unlet! b:current_syntax

highlight link mdH1 markdownH1
highlight link mdH2 markdownH2
highlight link mdH3 markdownH3
highlight link mdH4 markdownH4
highlight link mdH5 markdownH5
highlight link mdH6 markdownH6
highlight link mdInvalidH Normal

highlight mdItalic        cterm=italic
highlight mdBold          cterm=bold
highlight mdStrikeThrough cterm=strikethrough

highlight link mdQuote  PreProc
highlight link mdFormat Normal
highlight link mdList   Label

highlight link mdInlineCode Comment
highlight link mdBlockCode  mdInlineCode

highlight link mdSpecialChar Statement
highlight link mdImage       mdSpecialChar
highlight link mdLink        mdSpecialChar
highlight link mdText        Normal

highlight link mdUrl  Underlined
highlight link mdPath StorageClass

highlight link mdTableHeader     rubyInstanceVariable
highlight link mdTableRow        rubyBlockParameter
highlight link mdTableHeaderText Function
highlight link mdTableText       Normal

highlight link mdCiteProcRef mdSpecialChar
highlight link mdCrossRef    mdSpecialChar
highlight link mdEqnosRef    mdSpecialChar

highlight link mdRefDef     mdSpecialChar
highlight link mdRefText    Normal
highlight link mdRefKeyword Function

let b:current_syntax = "markdown"
