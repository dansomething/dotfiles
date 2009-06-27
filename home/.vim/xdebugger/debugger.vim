pyfile ~/.vim/xdebugger/debugger.py
map <Leader><F1> :python debugger_resize()<cr>
map <Leader><F2> :python debugger_command('step_into')<cr>
map <Leader><F3> :python debugger_command('step_over')<cr>
map <Leader><F4> :python debugger_command('step_out')<cr>

nnoremap ,e :python debugger_watch_input("eval")<cr>A
"nnoremap E :python debugger_watch_input("exec")<cr>A

map <Leader><F5> :python debugger_run()<cr>
map <Leader><F6> :python debugger_quit()<cr>

"map <F7> :echo 'not yet'
"map <F9> :echo 'not yet'
"map <F8> :python debugger.ui.watchwin.clean()<cr>:python debugger.ui.watchwin.write('<?')<cr>:python debugger.ui.logwin.clean()<cr>
"map <F9> :python debugger_mark('<args>')<cr>

map <Leader><F8> :python debugger_context()<cr>
map <Leader><F7> :python debugger_property()<cr>
map <Leader><F8> :python debugger_watch_input("context_get")<cr>A<cr>
map <Leader><F7> :python debugger_watch_input("property_get", '<cword>')<cr>A<cr>

hi DbgCurrent ctermfg=Black ctermbg=Red 
hi DbgBreakPt ctermfg=Black ctermbg=Green

command! -nargs=? Bp python debugger_mark('<args>')
command! -nargs=0 Up python debugger_up()
command! -nargs=0 Dn python debugger_down()
sign define current text=->  texthl=DbgCurrent linehl=DbgCurrent
sign define breakpt text=B>  texthl=DbgBreakPt linehl=DbgBreakPt
python debugger_init(9000, 0)

