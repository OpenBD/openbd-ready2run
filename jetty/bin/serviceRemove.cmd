@echo off

set bin_dir=%~dp0
set tmpfile=%tmp%\tmpfile
set busybox=%bin_dir%\busybox.exe%
set awk=%busybox% awk
set sed=%busybox% sed

 
echo %bin_dir% | %sed% -e "s/\\bin\\//g" > %tmpfile% 
set /p root_dir=<%tmpfile%
call :trim %root_dir% root_dir
set bin_dir=%root_dir%\bin


set cmd=%bin_dir%\prunsrv //DS//JettyService 

%cmd%


del %tmpfile%

goto:eof

:trim
set %2=%1
goto:eof
