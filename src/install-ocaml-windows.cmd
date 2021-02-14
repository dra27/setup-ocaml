@setlocal
@echo off
if exist D:\ocaml-cache\cache.wim (
  cd /d D:\
  "C:\Program Files\7-Zip\7z.exe" x D:\ocaml-cache\cache.wim
  del D:\ocaml-cache\cache.wim
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
if not exist D:\ocaml-cache md D:\ocaml-cache
"C:\Program Files\7-Zip\7z.exe" a -snl -twim D:\ocaml-cache\cache.wim %CYGWIN_ROOT%
