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

%busybox% which java | %sed% -e "s~/~\\~g" > %tmpfile%
set /p java=<%tmpfile%
call :trim %java% java

set common_params=-Djetty.home=%root_dir%;
set common_params=%common_params%-DSTOP.PORT=8087;
set common_params=%common_params%-DSTOP.KEY=downb0y;
set common_params=%common_params%-jar;%root_dir%\start.jar;

set stop_params=%common_params%--stop

set prunsrv=%bin_dir%\prunsrv.exe
set jetty_service=%bin_dir%\JettyService.exe

set cmd=%prunsrv% //IS//JettyService 
set cmd=%cmd% --DisplayName="Jetty Service" 
set cmd=%cmd% --Install=%prunsrv%
set cmd=%cmd% --LogLevel=Debug
set cmd=%cmd% --StdOutput=auto
set cmd=%cmd% --StdError=auto
set cmd=%cmd% --StartMode=exe
set cmd=%cmd% --StartImage=%java%
set cmd=%cmd% --StopImage=%java%
set cmd=%cmd% --StartPath=%root_dir%
set cmd=%cmd% --StopMode=exe
set cmd=%cmd% --Jvm=auto
set cmd=%cmd% --StartParams=%common_params%
set cmd=%cmd% --StopParams=%stop_params%

%cmd%
del %tmpfile%


goto:eof

:trim
set %2=%1
goto:eof
