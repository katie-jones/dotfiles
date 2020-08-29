let maplocalleader = ","

" color 80th column to know when to linebreak
set colorcolumn=80

" Camel Case
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge

" Fold code based on markers
set foldmethod=expr

" DoxygenToolkit
let g:DoxygenToolkit_briefTag_pre=""

" Set tabs to display as 2 spaces (save as tabs).
set ts=2
set sts=2
set sw=0
