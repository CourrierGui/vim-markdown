---
string: "a string"
- item: "1"
---

# H1 $1 + 1$ {#sec:ref}

H1 {#sec:this}
==

## H2 $\alpha$

H2 {#sec:ref2}
--

### H3 $\beta$

#### H4 {#sec:ref4}

##### H5 $\Pi$ {#sec:ref5 .numbered}

###### H6 $1+1$

####### H7

**bold**
__more bold__
*italic*
_more italic_
~~strikethrough~~
`Some inlined code`
> this is a quote

_this is
a multiline text
in italic_

**this is a multiline
text
in bold**

```cpp
#include <toto>

int main(int argc, char** argv) {
	return 0;
}
```


* This is a list item
+ another one
- a **bold** item
- [x] another one in _italic_
- [X] another one ~~done~~
- [ ] another one
1. another one with some `code`
#. another one

+---------------+-----------------+----------------+
| Title 1       |     Title 2     |        Title 3 |
+===============+=================+================+
| Column 1      |     Colum 2     |       Column 3 |
+---------------+-----------------+----------------+
| Text          |     Text        |        Text    |
+---------------+-----------------+----------------+
| $1 + 1$       |     Text        |        Text    |
+---------------+-----------------+----------------+

[link](https://www.some-link.rezometz.org/to-to/ti_ti/) {toto}
![image](some-image.jpeg) {option}
![image](/fu-ll/pa_th/to/some-image.jpeg)
![image](~/path/from/home/some-image.jpeg)
![image](relative/path/to/some-image.jpeg)

![image](some-image.jpeg) {#ref option=value}
[link](https://www.some-link.rezometz.org/to-to/ti_ti/) {#toto option=value}

$
$$
$$$$
$$$
text
$\alpha + \beta_j$
text
$$1$$
bonjour

$\sum_{j=1}^n a_i$

text
$$1$$
text

\begin{algin*}
	\beta_i + 1
\end{algin*}

\textsc{Test}
\test
\test{}

$$1 < 2$$

<b>bonjour</b>

[@bonjour-toto]

{#sec:my-fancy-section}
{#eq:my-fancy-section}
{#fig:my-fancy-section}

[@eq:my-fancy-equation]
[-@fig:my-fancy-figure]
[@sec:my-fancy-section]

@eq:my-eqnos-ref
