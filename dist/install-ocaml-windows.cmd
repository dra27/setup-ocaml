@setlocal
@echo off
if exist D:\cleanup (
  if exist D:\ocaml-cache\cache.tar goto :EOF
  if not exist D:\ocaml-cache md D:\ocaml-cache
  D:\cygwin\bin\bash -lc "opam clean --logs -ac"
  rem Step should less necessary with opam 2.1?
  D:\cygwin\bin\bash -lc "rm -rf /home/runneradmin/.opam/repo/default/.git; rm -rf /home/runneradmin/.opam/repo/default/packages"
  rem These should just not be being installed...
  D:\cygwin\bin\bash -lc "rm /home/runneradmin/.opam/ocaml-*/bin/ocaml*.byte.exe"
  rem These are all the "wrong" way around (i.e. with the ocamlc.exe as the main one) because of the Sys.file_exists issue with symlinks
  rem Submit upstream
  set CYGWIN=winsymlinks:nativestrict
  D:\cygwin\bin\bash -lc "cd /home/runneradmin/.opam/ocaml-*/bin; if [ -e ocamlbuild.native.exe ]; then ln -sf ocamlbuild.exe ocamlbuild.native.exe; fi"
  rem These should be being linked if it's available
  D:\cygwin\bin\bash -lc "cd /home/runneradmin/.opam/ocaml-*/bin; for f in ocaml*.opt.exe; do ln -sf ${f%%.opt.exe}.exe $f; done"
  D:\cygwin\bin\bash -lc "ls -lh /home/runneradmin/.opam/ocaml-*/bin"
  D:\cygwin\bin\bash -lc "cd /home/runneradmin/.opam/ocaml-*/bin ; cmd /c dir"
  
  if not exist D:\ocaml-cache\cache.tar D:\cygwin\bin\bash -lc "tar -pcf /cygdrive/d/ocaml-cache/cache.tar -C /home ."
  goto :EOF
) else (
  rem XXX Until we figure out boilerplate for the cleanup wrapper
  echo cleanup> D:\cleanup
)
if exist D:\cygwin-cache\cache.tar (
  cd /d D:\
  if not exist cygwin\bin\nul md cygwin\bin
  copy cygwin-cache\bootstrap\* cygwin\bin\
  D:\cygwin\bin\tar -pxf /cygdrive/d/cygwin-cache/cache.tar -C /cygdrive/d/cygwin
  if exist D:\ocaml-cache\cache.tar (
    D:\cygwin\bin\bash -lc "tar -pxf /cygdrive/d/ocaml-cache/cache.tar -C /home"
    D:\cygwin\bin\bash -lc "du -h --max-depth=4 /home/runneradmin"
    D:\cygwin\bin\bash -lc "du -hs /home/runneradmin/.opam/ocaml-variants*/.opam-switch/sources/*"
  ) else (
    D:\cygwin\bin\bash -l %1\install-ocaml-windows.sh %3 %4 || exit /b 1
  )
  goto :EOF
)
echo on
%2\setup-x86_64.exe --quiet-mode --root %CYGWIN_ROOT% --site http://cygwin.mirror.constant.com --packages curl,diff,diffutils,git,m4,make,patch,perl,rsync,mingw64-x86_64-gcc-core,mingw64-x86_64-gcc-g++,unzip
copy %2\setup-x86_64.exe %CYGWIN_ROOT%
mkdir %CYGWIN_ROOT%\wrapperbin
copy %1\opam.cmd %CYGWIN_ROOT%\wrapperbin\opam.cmd
D:\cygwin\bin\bash -l %1\install-opam-windows.sh %3 %4
@echo off
if not exist D:\cygwin-cache\bootstrap md D:\cygwin-cache\bootstrap
D:\cygwin\bin\bash -lc "cd /cygdrive/d/cygwin ; tar -pcf /cygdrive/d/cygwin-cache/cache.tar ."
rem TODO migrate old solution for this...
for %%f in (cygiconv-2.dll cygintl-8.dll cygwin1.dll tar.exe) do copy D:\cygwin\bin\%%f D:\cygwin-cache\bootstrap\
echo on
D:\cygwin\bin\bash -l %1\install-ocaml-windows.sh %3 %4
@if %ERRORLEVEL% neq 0 exit /b 1
