let maplocalleader = ","

" color 80th column to know when to linebreak
set colorcolumn=80

" map FR in normal mode to :ClangFormat
nnoremap FR :ClangFormat<C-m>

" Camel Case
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge

" set default YCM config file
let g:ycm_global_ycm_extra_conf = '~/Stuff/linux-config/custom-config/ycm_conf_cpp.py'

" Fold code based on markers
set foldmethod=expr

" Fold code based on markers
set foldmethod=expr
