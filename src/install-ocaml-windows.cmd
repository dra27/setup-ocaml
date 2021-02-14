@setlocal
@echo off
if exist D:\ocaml-cache\cache.tar (
  cd /d D:\
  if not exist cygwin\bin\nul md cygwin\bin
  copy ocaml-cache\bootstrap\* cygwin\bin\
  D:\cygwin\bin\tar -pxf /cygdrive/d/ocaml-cache/cache.tar -C /cygdrive/d/cygwin
  dir D:\cygwin\dev /a
  dir D:\cygwin /a
  goto :EOF
)
echo on
%2\setup-x86_64.exe --quiet-mode --root %CYGWIN_ROOT% --site http://cygwin.mirror.constant.com --packages curl,diff,diffutils,git,m4,make,patch,perl,rsync,mingw64-x86_64-gcc-core,mingw64-x86_64-gcc-g++,unzip
copy %2\setup-x86_64.exe %CYGWIN_ROOT%
D:\cygwin\bin\bash -l %1\install-ocaml-windows.sh %3 %4
@if %ERRORLEVEL% neq 0 exit /b 1
mkdir %CYGWIN_ROOT%\wrapperbin
copy %1\opam.cmd %CYGWIN_ROOT%\wrapperbin\opam.cmd
@echo off
if not exist D:\ocaml-cache\bootstrap md D:\ocaml-cache\bootstrap
D:\cygwin\bin\bash -lc "cd /cygdrive/d/cygwin ; tar -pcf /cygdrive/d/ocaml-cache/cache.tar ."
rem TODO migrate old solution for this...
for %%f in (cygiconv-2.dll cygintl-8.dll cygwin1.dll tar.exe) do copy D:\cygwin\bin\%%f D:\ocaml-cache\bootstrap\
