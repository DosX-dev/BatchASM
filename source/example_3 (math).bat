@echo off

call vm push "2 + 3 = "
call vm out.0
call vm clr

call vm push 2
call vm push 3
call vm add
call vm out.1
call vm clr


call vm push "10 - 7 = "
call vm out.0
call vm clr

call vm push 10
call vm push 7
call vm sub
call vm out.1
call vm clr


call vm push "4 / 2 = "
call vm out.0
call vm clr

call vm push 4
call vm push 2
call vm div
call vm out.1
call vm clr


call vm push "5 * 7 = "
call vm out.0
call vm clr

call vm push 5
call vm push 7
call vm mul
call vm out.1
call vm clr

call vm out.1
call vm push "RANDOM MATH EXAMPLE:"
call vm out.1
call vm clr

call vm push 0
call vm rand
call vm push.ref tmp.1 stack.1
call vm clr

call vm push 0
call vm rand
call vm push.ref tmp.2 stack.1
call vm clr

call vm push.ref stack.1 tmp.1
call vm out.0
call vm clr

call vm push " + "
call vm out.0
call vm clr

call vm push.ref stack.1 tmp.2
call vm out.0
call vm clr

call vm push " = "
call vm out.0
call vm clr

call vm push.mov stack.1 tmp.1
call vm push.mov stack.2 tmp.2

call vm add

call vm out.1
call vm clr

call vm [debug]_$break
