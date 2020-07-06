if exists("b:current_syntax")
	finish
endif

" TODO:
" - HTML
" - ref [@sec:...], @eq:..., [@fig:...], [@...:...]
" - metadata
" - yaml syntax
" - code

" Recognize header
syntax match markdownH1 "\v^(# .*$\n\s*|[^#]+$\n\=\=+\s*)$"
syntax match markdownH2 "\v^(## .*$\n\s*|[^#]+$\n--+\s*)$"
syntax match markdownH3 "\v^### .*$\n\s*$"
syntax match markdownH4 "\v^#### .*$\n\s*$"
syntax match markdownH5 "\v^##### .*$\n\s*$"
syntax match markdownH6 "\v^###### .*$\n\s*$"
syntax match markdownInvalidH "\v^#######+ .*$"

highlight markdownH1 cterm=bold ctermfg=Red
highlight markdownH2 cterm=bold ctermfg=Red
highlight markdownH3 cterm=bold ctermfg=Red
highlight markdownH4 cterm=bold ctermfg=Red
highlight markdownH5 cterm=bold ctermfg=Red
highlight markdownH6 cterm=bold ctermfg=Red
highlight link markdownInvalidH Normal

" Strikethrough, quote, code and code blocks
syntax match markdownStrikeThrough "\v\~\~.+\~\~"
syntax match markdownQuote "\v\>.+$"
syntax match markdownInlineCode "\v`.+`"
syntax region markdownBlockCode start="\v```" end="\v```" fold

" Bold, Italic
syntax match markdownItalic "\v(\*.+\*|_.+_)"
syntax match markdownBold "\v(\*\*.+\*\*|__.+__)"

" Lists
syntax match markdownList "\v(* |\+ |(\d|#)\. |- (\[(\s|X|x)\])?)"

highlight markdownBold          cterm=bold
highlight markdownItalic        cterm=italic
highlight markdownStrikeThrough cterm=strikethrough
highlight markdownInlineCode    ctermfg=Red
highlight markdownBlockCode     ctermfg=Red
highlight markdownQuote         ctermfg=Grey
highlight markdownList          ctermfg=Red

" Links
" TODO: add options inside {}
" force markdownLinkMiddle ?
syntax region markdownLink start="\v\[" end="\v\)" contains=markdownUrl,markdownText,markdownLinkMiddle oneline
" TODO: improve url and text regexp
syntax match markdownText "\v[^\)\[\]!]+"   contained
syntax match markdownUrl "\v[A-Za-z]+\.com" contained
syntax match markdownLinkMiddle "\v\]\("    contained

highlight markdownLink       ctermfg=Red
highlight markdownLinkMiddle ctermfg=Red
highlight markdownUrl        cterm=underline ctermfg=Cyan
highlight link markdownText  Normal

" Images
" TODO: add options inside {}
" force markdownLinkMiddle ?
syntax region markdownImage start="\v!\[" end="\v\)" contains=markdownPath,markdownText,markdownLinkMiddle oneline
" TODO: improve path
syntax match markdownPath "\v[A-Za-z_]+\.png" contained

highlight markdownImage      ctermfg=Red
highlight markdownPath       ctermfg=Cyan
highlight link markdownText  Normal

" Tables
" TODO: is it possible to handle column width ?
syntax region markdownTableRow    start="\v\|" end="\v\+(-+\+)+"         contains=markdownTableText
syntax region markdownTableHeader start="\v\+(-+\+)+" end="\v\+(\=+\+)+" contains=markdownTableHeaderText

" TODO: text ascii input ?
syntax match markdownTableText       "\v[A-Za-z0-9éà ]+" contained containedin=markdownTableRow
syntax match markdownTableHeaderText "\v[A-Za-z0-9éà ]+" contained containedin=markdownTableHeader

highlight markdownTableHeader       ctermfg=Green
highlight markdownTableRow          ctermfg=Gray
highlight markdownTableText         ctermfg=Blue
highlight markdownTableHeaderText   ctermfg=Red

" YAML metadata
syntax region markdownYamlMetadata start="\v\%^---" end="\v---"
highlight markdownYamlMetadata ctermfg=Blue

let b:current_syntax = "markdown"
