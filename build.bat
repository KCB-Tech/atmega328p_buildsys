@echo off
rem Init all required directories and variables
SET CWD=%CD%
SET SCRIPT_DIR=%CWD%\script
SET PATH=%PATH%;%CWD%\tools\avr-gcc\bin\
SET PATH=%PATH%;%CWD%\tools\MinGW\bin\
SET MAKE=mingw32-make.exe

rem set input argument into variables
SET ARG1=%1
SET ARG2=%2

rem Run commands
%MAKE% -f script/build.mak %ARG1% DEBUG=%ARG2%
rem return to initial working directory
cd %CWD%