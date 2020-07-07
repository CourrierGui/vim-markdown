if exists("b:current_syntax")
	finish
endif

" TODO:
" - HTML
" - metadata
" - yaml syntax
" - code

" YAML metadata
syntax region mdYamlMetadata start="\v\%^---\s*$" end="\v^---\s*$"
highlight mdYamlMetadata ctermfg=Blue

" Recognize header
syntax match mdH1 "\v^(# .*$\n\s*|[^#]+$\n\=\=+\s*)$"
syntax match mdH2 "\v^(## .*$\n\s*|[^#]+$\n--+\s*)$"
syntax match mdH3 "\v^### .*$\n\s*$"
syntax match mdH4 "\v^#### .*$\n\s*$"
syntax match mdH5 "\v^##### .*$\n\s*$"
syntax match mdH6 "\v^###### .*$\n\s*$"
syntax match mdInvalidH "\v^#######+ .*$"

highlight mdH1 cterm=bold ctermfg=Red
highlight mdH2 cterm=bold ctermfg=Red
highlight mdH3 cterm=bold ctermfg=Red
highlight mdH4 cterm=bold ctermfg=Red
highlight mdH5 cterm=bold ctermfg=Red
highlight mdH6 cterm=bold ctermfg=Red
highlight link mdInvalidH Normal

" Strikethrough, quote, code and code blocks
syntax match mdStrikeThrough "\v\~\~.+\~\~"
syntax match mdQuote "\v\>.+$"
syntax match mdInlineCode "\v`.+`"
syntax region mdBlockCode start="\v```" end="\v```" fold

" Bold, Italic
syntax match mdItalic "\v(\*.+\*|_.+_)"
syntax match mdBold "\v(\*\*.+\*\*|__.+__)"

" Lists
syntax match mdList "\v(* |\+ |(\d|#)\. |- (\[(\s|X|x)\])?)"

highlight mdBold          cterm=bold
highlight mdItalic        cterm=italic
highlight mdStrikeThrough cterm=strikethrough
highlight mdInlineCode    ctermfg=Red
highlight mdBlockCode     ctermfg=Red
highlight mdQuote         ctermfg=Grey
highlight mdList          ctermfg=Red

" Links
" TODO: option syntax inside {}
syntax region mdLink start="\v\[.*\]\(" end="\v\)( \{.+\})?"
	\ contains=mdUrl,mdText,mdLinkMiddle oneline
" TODO: improve url and text regexp
syntax match mdText "\v[^\)\[\]!\{\}#]+" contained
syntax match mdUrl
	\ "\v(https?://)?(www.)?[-a-zA-Z0-9_]{1,256}(\.[a-zA-Z_]{1,6})+(/[-a-zA-Z0-9_]+)*/?" contained
syntax match mdLinkMiddle "\v\]\("    contained

highlight mdLink       ctermfg=Red
highlight mdLinkMiddle ctermfg=Red
highlight mdUrl        cterm=underline ctermfg=Cyan
highlight link mdText  Normal

" Images
syntax region mdImage start="\v!\[.*\]\(" end="\v\)( \{.+\})?"
	\ contains=mdPath,mdText,mdLinkMiddle,mdOptionBrackets oneline
" TODO: should space be escaped ?
syntax match mdPath "\v(/|\~/)?([-_0-9a-zA-Z]+/)*([-A-Za-z_0-9]|\\ )+\.[a-zA-Z0-9]+" contained
syntax region mdOptionBrackets start="\v\s\{" end="\v\}"
	\ contained containedin=mdImage oneline contains=mdText

highlight mdOptionBrackets ctermfg=Red
highlight mdImage          ctermfg=Red
highlight mdPath           ctermfg=Cyan
highlight link mdText      Normal

" Tables
" TODO: is it possible to handle column width ?
" TODO: improve this in order to allow =, - and + in TableRowText and TableHeaderText
syntax region mdTableRow    start="\v\|(.*\|)+\s*$" end="\v\+(-+\+)+\s*$"  contains=mdTableText
syntax region mdTableHeader start="\v\+(-+\+)+\s*$" end="\v\+(\=+\+)+\s*$" contains=mdTableHeaderText

" TODO: text ascii input ?
syntax match mdTableText       "\v[^\|\-\+\=]+"
	\ contained containedin=mdTableRow contains=mdLatexInlineEq
syntax match mdTableHeaderText "\v[^\|\-\+\=]+"
	\ contained containedin=mdTableHeader

highlight mdTableHeader     ctermfg=Green
highlight mdTableRow        ctermfg=Gray
highlight mdTableText       ctermfg=Blue
highlight mdTableHeaderText ctermfg=Red

" LaTeX
" Math
" TODO: put latex syntax here
syntax region mdLatexInlineEq start="\v\$([^\$]|\\)" end="\v\$"
syntax region mdLatexEquation start="\v\$\$([^\$]|\\)" end="\v\$\$"

highlight mdLatexInlineEq ctermfg=Cyan    cterm=underline
highlight mdLatexEquation ctermfg=Magenta cterm=underline

" begin/end LaTeX env
syntax region mdLatexEnv start="\v\\begin\{.*\}" end="\v\\end\{.*\}"
highlight mdLatexEnv cterm=bold

" references: [@sec:...], @eq:..., [@fig:...], [@...:...]

syntax match mdCiteProcRef "\v\[\@\S+\]"        contains=mdRefText
syntax match mdCrossRef    "\v\[\@[a-z]+:\S+\]" contains=mdRefText,mdRefKeyword
syntax match mdRefDef      "\v\{#[a-z]+:.+\}"   contains=mdRefText,mdRefKeyword
syntax match mdRefText     "\v[-0-9A-Za-z]+"
	\ contained containedin=mdCiteProcRef,mdCrossRef contains=mdRefKeyword
syntax match mdEqnosRef "\v\@[a-z]+:[-a-zA-Z0-9]+" contains=mdRefKeyword,mdRefText

syntax keyword mdRefKeyword eq sec fig contained containedin=mdRefText

highlight mdCiteProcRef ctermfg=Yellow
highlight mdCrossRef    ctermfg=Yellow
highlight mdRefDef      ctermfg=Yellow
highlight mdEqnosRef    ctermfg=Yellow

highlight mdRefText     ctermfg=Cyan
highlight mdRefKeyword  ctermfg=Gray

let b:current_syntax = "markdown"
