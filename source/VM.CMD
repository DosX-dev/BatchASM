@echo off

:VirtualMachine
set batchasm_ver=1.0.0 vanilla
set batchasm_edition=beta

if "%~1" == "" (
    echo:No input instructions!
	echo:Use --help to get more info
	goto :eof
) else if "%~1" == "--help" (
    echo: --about - get VM information
    goto :eof
) else if "%~1" == "--about" (
    echo:BatchASM Virtualization
	echo:VM version: %batchasm_ver% ^(%batchasm_edition%^)
    echo:
    echo:GitHub: https://github.com/DosX-dev/BatchASM
	goto :eof
)

set "args=%~2"
set "args_2=%~3"
set "args_3=%~4"

if defined args   set "args=%args:""="%"
if defined args_2 set "args_2=%args_2:""="%"
if defined args_3 set "args_3=%args_3:""="%"

call :opcode__%1 "%args%" "%args_2%"

call :opcode__push.clr args
call :opcode__push.clr args_2
call :opcode__push.clr args_3
goto :eof


:: [push] opcode
:: Pushes a value onto the stack and registers the sequence number "stack__size" for it
:: stack.1, stack.2, stack.3 ...
:opcode__push
set /a stack__size=stack__size+1
call set "stack.%stack__size%=%~1%"
goto :eof


:: push.ref opcode
:: Copies a value from one element to another
:opcode__push.ref
call set "%~1=%%%~2%%"
goto :eof


:: push.clr opcode
:: Clears the specified stack object or specified external parameter
:opcode__push.clr
if defined "%~1" set "%~1="
goto :eof


:: clr opcode
:: Clears all stack elements
:opcode__clr
if defined stack.1 for /f "delims==" %%A in ('set stack.') do set %%A=
set /a stack__size=0
goto :eof


:: out.0 opcode
:: Displays a message on the screen
:opcode__out.0
for /f %%a in ('"prompt $H&for %%b in (1) do rem"') do set "backspace=%%a"
if not "%stack.1%" == "" (
    <nul set /p=".%backspace%%stack.1%"
)
goto :eof


:: out.1 opcode
:: Displays a message on the screen. With carriage transfer
:opcode__out.1
call :opcode__out.0
echo:
goto :eof


:: cmp opcode
:: Compares the contents of stack.1 and stack.2 and returns the result in "code"
:opcode__cmp
set code=1
if "%stack.1%" == "%stack.2%" set code=0
goto :eof


:: add opcode
:: Adds the first stack value to the second
:opcode__add
set /a stack.1=stack.1+stack.2
goto :eof


:: sub opcode
:: Subtracts the first stack value from the second
:opcode__sub
set /a stack.1=stack.1-stack.2
goto :eof


:: mul opcode
:: Multiplies the first stack value by the second
:opcode__mul
set /a stack.1=stack.1*stack.2
goto :eof


:: div opcode
:: Divides the first element of the stack by the second
:opcode__div
set /a stack.1=stack.1/stack.2
goto :eof


:: sl opcode
:: Performs a bitwise left shift of the first stack element
:: to the positions specified in the second stack element
:opcode__sl
set /a stack.1=stack.1^<^<stack.2
goto :eof


:: sr opcode
:: Performs a bitwise right shift of the first stack element
:: to the positions specified in the second stack element
:opcode__sr
set /a stack.1=stack.1^>^>stack.2
goto :eof


:: and opcode
:: Uses a bitwise AND of the first stack element to the second
:opcode__and
set /a stack.1=stack.1^&stack.2
goto :eof


:: xor opcode
:: Performs a bitwise exclusive OR between the first and second
:: elements of the stack
:opcode__xor
set /a stack.1=stack.1^^stack.2
goto :eof


:: or opcode
:: Performs a bitwise OR operation between the first and second
:: elements of the stack
:opcode__or
set /a stack.1=stack.1^|stack.2
goto :eof


:: cpuid opcode
:: Returns information about the current processor in the
:: first stack element
::
:: stack.1 values at which the described result is returned:
:: 1 = architecture
:: 2 = identifier
:: 3 = number of cores
:: 4 = number of logical cores
:: 5 = revision
:opcode__cpuid
       if "%stack.1%" == "1" ( call :opcode__push.ref stack.1 PROCESSOR_ARCHITECTURE
) else if "%stack.1%" == "2" ( call :opcode__push.ref stack.1 PROCESSOR_IDENTIFIER
) else if "%stack.1%" == "3" ( call :opcode__push.ref stack.1 PROCESSOR_LEVEL
) else if "%stack.1%" == "4" ( call :opcode__push.ref stack.1 NUMBER_OF_PROCESSORS
) else if "%stack.1%" == "5" ( call :opcode__push.ref stack.1 PROCESSOR_REVISION )
goto :eof


:: rand opcode
:: Gets a random number in the range from 0 to 32767
:: and returns it to stack.1
:opcode__rand
for /l %%t in (1, 1, 2) do @ (
    call :opcode__push.clr random
    call :opcode__push.ref stack.1 random
)
goto :eof


:: nop opcode
:: Doing nothing. Performs an aesthetic function
:opcode__nop
goto :eof


:opcode__[unsafe]_$exec
@%stack.1% %stack.2%
goto :eof


:opcode__[unsafe]_$exec_no_out
@%stack.1% %stack.2%>nul=2>&1
goto :eof


:: [debug]_$stack opcode-function
:: Prints the contents of all stack elements
:opcode__[debug]_$stack
echo:
echo:=========================
echo:^| STACK ELEMENTS REGISTERED: %stack__size%
if defined stack.1 set stack.
echo:=========================
goto :eof


:: [debug]_$break opcode-function
:: Pauses during program execution; Waits for any key
:: to be pressed
:opcode__[debug]_$break
pause>nul
goto :eof


:opcode__hw
call :opcode__push "Hello, world!"
goto :eof