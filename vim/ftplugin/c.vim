" color 80th column to know when to linebreak
set colorcolumn=80

" set clang options
let g:clang_format#code_style = "google"

" map FR in normal mode to :ClangFormat
nnoremap FR :ClangFormat<C-m>

" Camel Case
let maplocalleader = ","
"map <silent> <LocalLeader>w <Plug>CamelCaseMotion_w
"map <silent> <LocalLeader>b <Plug>CamelCaseMotion_b
"map <silent> <LocalLeader>e <Plug>CamelCaseMotion_e
"map <silent> <LocalLeader>ge <Plug>CamelCaseMotion_ge

map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge

" remap NERD Commenter toggle command
" map .. <leader>c<SPACE>

" set default YCM config file
let g:ycm_global_ycm_extra_conf = '~/.ycm_conf_c.py'

" visual/normal mode map to make header guard
vnoremap HD dggi#ifndef <C-r>"_HEADER_DEF_<Return>#define <C-r>"_HEADER_DEF_<Esc>Go<Return>#endif<Esc>k
nnoremap HD $a_HEADER_DEF_<Esc>0d$ggi#ifndef <Esc>po#define <Esc>pGo<Return>#endif<Esc>k
