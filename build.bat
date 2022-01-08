@echo off
rem Required initial paths as Working dir and Make tool dir
SET CWD=%CD%
SET SCRIPT_DIR=%CWD%\script
SET PATH=%PATH%;%CWD%\tools\avr-gcc\bin\
SET PATH=%PATH%;%CWD%\tools\MinGW\bin\

rem set input argument into variables
SET ARG1=%1
SET ARG2=%2

rem call init scripts
call script/set_variables.bat
rem Run commands
%MAKE% -f script/app.mak %ARG1% DEBUG=%ARG2%
rem return to initial working directory
cd %CWD%