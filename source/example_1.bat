@echo off

call vm nop
call vm push "Virtual Machine ""BatchASM"" by DosX!"
call vm out.1

call vm clr

call vm push "Processor name: "
call vm out.0
call vm clr

call vm push 2
call vm cpuid
call vm out.0

call vm clr

call vm push " ("
call vm out.0
call vm clr

call vm push 3
call vm cpuid
call vm out.0
call vm clr

call vm push " cores)"
call vm out.1
call vm clr

call vm out.1

call vm push "The important message: "
call vm out.0
call vm clr

call vm hw
call vm out.1
call vm clr

call vm out.1

call vm push "(2 + 6) / 2 = "
call vm out.0

call vm clr

call vm push 2
call vm push 6

call vm add

call vm push.ref tmp.1 stack.1

call vm clr

call vm nop
call vm push 0
call vm push.ref stack.1 tmp.1

call vm push 2

call vm div

call vm out.0

call vm push.ref tmp.1 stack.1
call vm clr
call vm push 0
call vm push.mov stack.1 tmp.1
call vm push 4
call vm cmp
call vm clr

IF %code% equ 0 (
    call vm push.clr code
    call vm push " (And this is the correct answer!)"
    call vm out.1
)

call vm clr

call vm out.1

call vm push "Random number between 0 and 1 is... "
call vm out.0
call vm clr

call vm push 0
call vm rand
call vm push 16383
call vm div
call vm out.1
call vm clr

call vm [debug]_$break
