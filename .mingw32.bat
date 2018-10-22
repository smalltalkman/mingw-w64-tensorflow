@echo off
setlocal
set THIS_DIR=%~dp0
cd "%THIS_DIR%"

if "x%MSYS2_HOME%" == "x" set MSYS2_HOME=
set MSYS2_SHELL=%MSYS2_HOME%\msys2_shell.cmd

if NOT EXIST %MSYS2_SHELL% goto notfound
"%MSYS2_SHELL%" -mingw32 -use-full-path -here
REM "%MSYS2_SHELL%" -mingw32 -use-full-path -where "%THIS_DIR%"
goto EOF

:notfound
echo Cannot find %MSYS2_SHELL% -- aborting.
pause

:EOF
