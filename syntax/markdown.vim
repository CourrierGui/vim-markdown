if exists("b:current_syntax")
	finish
endif

" Recognize header
syntax match mdH1 "\v^(# .*$\n\s*|[^#]+( \{.+\})?$\n\=\=+\s*)$" contains=mdLatexInlineEq,mdRefDef
syntax match mdH2 "\v^(## .*$\n\s*|[^#]+( \{.+\})?$\n--+\s*)$" contains=mdLatexInlineEq,mdRefDef
syntax match mdH3 "\v^### .*$\n\s*$" contains=mdLatexInlineEq,mdRefDef
syntax match mdH4 "\v^#### .*$\n\s*$" contains=mdLatexInlineEq,mdRefDef
syntax match mdH5 "\v^##### .*$\n\s*$" contains=mdLatexInlineEq,mdRefDef
syntax match mdH6 "\v^###### .*$\n\s*$" contains=mdLatexInlineEq,mdRefDef
syntax match mdInvalidH "\v^#######+ .*$"

highlight mdH1 cterm=bold ctermfg=Red
highlight mdH2 cterm=bold ctermfg=Red
highlight mdH3 cterm=bold ctermfg=Red
highlight mdH4 cterm=bold ctermfg=Red
highlight mdH5 cterm=bold ctermfg=Red
highlight mdH6 cterm=bold ctermfg=Red
highlight link mdInvalidH Normal

" Strikethrough, quote, code
" Bold, Italic
syntax region mdItalic        concealends matchgroup=mdFormat start="\v(_|\*)"    end="\v(_|\*)"
syntax region mdBold          concealends matchgroup=mdFormat start="\v(__|\*\*)" end="\v(__|\*\*)"
syntax region mdStrikeThrough concealends matchgroup=mdFormat start="\v\~\~"      end="\v\~\~"
syntax region mdInlineCode    concealends matchgroup=mdFormat start="\v`"         end="\v`"
syntax region mdQuote         concealends matchgroup=mdFormat start="\v\> "       end="\v$" oneline


highlight link mdFormat   Normal
highlight mdItalic        cterm=italic
highlight mdBold          cterm=bold
highlight mdStrikeThrough cterm=strikethrough
highlight mdInlineCode    ctermfg=Red
highlight mdQuote         ctermfg=Grey

" Lists
syntax match mdList "\v^\s*(* |\+ |(\d|#)\. |- (\[(\s|X|x)\])?)"
highlight mdList      ctermfg=Red

" Block of code
syntax region mdBlockCode start="\v```" end="\v```" fold

highlight mdBlockCode ctermfg=Red

" C/C++ code in code blocks
syntax include @c syntax/cpp.vim
syntax region mdBlockCode start="\v```(c|cpp)" end="\v```" fold contains=@c keepend
unlet! b:current_syntax

" Links
" TODO: option syntax inside {} / for titles too
syntax match mdLink "\v\[.+\]\(.+\)( \{.+\})?" contains=mdUrl,mdText
" TODO: improve url and text regexp
syntax match mdText "\v[^\(\)\[\]!\{\}#]+" contained
syntax match mdUrl "\v(https?://)?(www.)?[-a-zA-Z0-9_]{1,256}(\.[a-zA-Z_]{1,6})+(/[-a-zA-Z0-9_]+)*/?" contained

highlight mdLink       ctermfg=Red
highlight mdUrl        cterm=underline ctermfg=Cyan
highlight link mdText  Normal

" Images
syntax match mdImage "\v!\[.+\]\(.+\)( \{.+\})?" contains=mdPath,mdText,mdOptionBrackets
" TODO: should space be escaped ?
syntax match  mdPath "\v(/|\~/)?([-_0-9a-zA-Z]+/)*([-A-Za-z_0-9]|\\ )+\.[a-zA-Z0-9]+"  contained
syntax region mdOptionBrackets start="\v\s\{" end="\v\}" contained containedin=mdImage oneline contains=mdText

highlight mdOptionBrackets ctermfg=Red
highlight mdImage          ctermfg=Red
highlight mdPath           ctermfg=Cyan
highlight link mdText      Normal

" Tables
" TODO: is it possible to handle column width ?
" TODO: improve this in order to allow =, - and + in TableRowText and TableHeaderText
" TODO: use matchgroup ? nextgroup ?
syntax region mdTableRow    start="\v\|(.*\|)+\s*$" end="\v\+(-+\+)+\s*$"  contains=mdTableText
syntax region mdTableHeader start="\v\+(-+\+)+\s*$" end="\v\+(\=+\+)+\s*$" contains=mdTableHeaderText

" TODO: text ascii input ?
syntax match mdTableText       "\v[^\|\-\+\=]+" contained containedin=mdTableRow contains=mdLatexInlineEq
syntax match mdTableHeaderText "\v[^\|\-\+\=]+" contained containedin=mdTableHeader

highlight mdTableHeader     ctermfg=Green
highlight mdTableRow        ctermfg=Gray
highlight mdTableText       ctermfg=Blue
highlight mdTableHeaderText ctermfg=Red

" Import LaTeX syntax
syntax include @tex syntax/tex.vim

" Math
syntax region mdLatexInlineEq start="\v\$([^\$]|\\)" end="\v\$" contains=@tex keepend
syntax region mdLatexEquation start="\v\$\$([^\$]|\\)" end="\v\$\$" contains=@tex keepend

" begin/end LaTeX env/function
syntax match mdLatexFunc "\v\\[a-z]+(\{(.+)?\})?" contains=@tex keepend
syntax region mdLatexEnv start="\v\\begin\{.*\}" end="\v\\end\{.*\}" contains=@tex keepend

unlet! b:current_syntax

" references: [@sec:...], @eq:..., [@fig:...], [@...:...]
syntax match mdCiteProcRef "\v\[\@\S+\]"             contains=mdRefText
syntax match mdCrossRef    "\v\[-?\@[a-z]+:\S+\]"    contains=mdRefText,mdRefKeyword
syntax match mdRefDef      "\v\{#[a-z]+:.+\}"        contains=mdRefText,mdRefKeyword
syntax match mdRefText     "\v[-0-9A-Za-z]+"         contained containedin=mdCiteProcRef,mdCrossRef contains=mdRefKeyword
syntax match mdEqnosRef    "\v\@[a-z]+:[-a-zA-Z0-9]+" contains=mdRefKeyword,mdRefText

syntax keyword mdRefKeyword eq sec fig contained containedin=mdRefText

highlight mdCiteProcRef ctermfg=Yellow
highlight mdCrossRef    ctermfg=Yellow
highlight mdRefDef      ctermfg=Yellow
highlight mdEqnosRef    ctermfg=Yellow

highlight mdRefText     ctermfg=Cyan
highlight mdRefKeyword  ctermfg=Gray

" YAML metadata
syntax include @yamlTop syntax/yaml.vim
" syn region Comment matchgroup=mkdDelimiter start="\%^---$" end="^\(---\|\.\.\.\)$" contains=@yamlTop keepend
syntax region mdYamlMetadata start="\v%^---\s*$" end="\v^---\s*$" contains=@yamlTop keepend
unlet! b:current_syntax

" HTML
syntax include @html syntax/html.vim
syntax region mdHTML start="\v\<" end="\v\>" contains=@html keepend
unlet! b:current_syntax

let b:current_syntax = "markdown"
