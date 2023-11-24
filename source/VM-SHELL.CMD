@echo off
title {VM} BatchASM Shell
call vm --about
:main
set /p "basm_prompt=BatchASM >>> "
if defined basm_prompt call vm %basm_prompt%
set basm_prompt=
goto main