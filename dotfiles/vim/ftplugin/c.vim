" Quite if filetype isn't C (i.e. C++)
if (&ft != 'c')
  finish
endif

" color 81st column to know when to linebreak
set colorcolumn=81

" map FR in normal mode to :ClangFormat
nnoremap FR :ClangFormat<C-m>

" Camel Case
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge

map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge

" visual/normal mode map to make header guard
vnoremap HD dggi#ifndef <C-r>"_HEADER_DEF_<Return>#define <C-r>"_HEADER_DEF_<Esc>Go<Return>#endif<Esc>k
nnoremap HD $a_HEADER_DEF_<Esc>0d$ggi#ifndef <Esc>po#define <Esc>pGo<Return>#endif<Esc>k

" Doxygen setup
let g:DoxygenToolkit_briefTag_pre="@brief      "
let g:DoxygenToolkit_briefTag_post="<++>"
let g:DoxygenToolkit_paramTag_pre="@param      [<++>] "
let g:DoxygenToolkit_paramTag_post=": <++>"
let g:DoxygenToolkit_returnTag="@return     <++>"
