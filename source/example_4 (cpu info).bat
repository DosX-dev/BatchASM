@echo off

call vm push "Architecture: "
call vm out.0
call vm clr

call vm push 1
call vm cpuid
call vm out.1
call vm clr


call vm push "Identifier: "
call vm out.0
call vm clr

call vm push 2
call vm cpuid
call vm out.1
call vm clr


call vm push "Number of cores: "
call vm out.0
call vm clr

call vm push 3
call vm cpuid
call vm out.1
call vm clr


call vm push "Number of threads: "
call vm out.0
call vm clr

call vm push 4
call vm cpuid
call vm out.1
call vm clr


call vm push "Revision: "
call vm out.0
call vm clr

call vm push 5
call vm cpuid
call vm out.1
call vm clr

call vm [debug]_$break