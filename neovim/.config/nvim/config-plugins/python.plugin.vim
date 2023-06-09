function s:FormatPython()
  let view = winsaveview()

  !black %
  " Clear prompt
  echon ''

  edit!
  call winrestview(view)
endfunction

" define custom command
command FormatPython call s:FormatPython()

"let python_highlight_all=1

"# Configuration for os
let system = system('uname -o')

if system =~? 'GNU/Linux'
  if has('python')
    "python with virtualenv support
    python3 << EOF
import os.path
import sys
import vim
if 'VIRTUA_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  sys.path.insert(0, project_base_dir)
  activate_this = os.path.join(project_base_dir,'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

  endif
endif
