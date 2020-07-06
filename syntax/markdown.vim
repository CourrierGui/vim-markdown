if exists("b:current_syntax")
	finish
endif

syntax match markdownHeader1 "\v# .*$"
syntax match markdownHeader2 "\v## .*$"
syntax match markdownHeader3 "\v### .*$"
syntax match markdownHeader4 "\v#### .*$"
syntax match markdownHeader5 "\v##### .*$"
syntax match markdownHeader6 "\v###### .*$"

highlight link markdownHeader1 MarkdownH1
highlight link markdownHeader2 MarkdownH2
highlight link markdownHeader3 MarkdownH3
highlight link markdownHeader4 MarkdownH4
highlight link markdownHeader5 MarkdownH5
highlight link markdownHeader6 MarkdownH6

let b:current_syntax = "markdown"
