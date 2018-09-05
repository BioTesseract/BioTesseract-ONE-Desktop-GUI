@echo off
d:\lazarus\fpc\2.2.4\bin\i386-win32\windres.exe --include d:/lazarus/fpc/222A9D~1.4/bin/I386-W~1/ -O res -o Grow4.res C:/DOCUME~1/RAFA£/Pulpit/PROJEKTY/PROGRA~1/Grow4.rc --preprocessor=d:\lazarus\fpc\2.2.4\bin\i386-win32\cpp.exe
if errorlevel 1 goto linkend
SET THEFILE=Grow_4.exe
echo Linking %THEFILE%
d:\lazarus\fpc\2.2.4\bin\i386-win32\ld.exe -b pe-i386 -m i386pe  --gc-sections   --subsystem windows --entry=_WinMainCRTStartup    -o Grow_4.exe link.res
if errorlevel 1 goto linkend
d:\lazarus\fpc\2.2.4\bin\i386-win32\postw32.exe --subsystem gui --input Grow_4.exe --stack 16777216
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occured while assembling %THEFILE%
goto end
:linkend
echo An error occured while linking %THEFILE%
:end
