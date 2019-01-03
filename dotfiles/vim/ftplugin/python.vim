" Show docstring when folding code
let g:SimpylFold_docstring_preview=1

" mark bad whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
match BadWhitespace /\s\+$/

" use utf-8 encoding
set encoding=utf-8

" turn syntax highlighting on
let python_highlight_all=1
syntax on

" use unix line breaks etc
set fileformat=unix

" Camel Case
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge

" Disable auto line breaks
set textwidth=0
