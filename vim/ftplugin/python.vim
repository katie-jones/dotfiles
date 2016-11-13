" Show docstring when folding code
let g:SimpylFold_docstring_preview=1

" mark bad whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
match BadWhitespace /\s\+$/

" use utf-8 encoding
set encoding=utf-8

"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

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

