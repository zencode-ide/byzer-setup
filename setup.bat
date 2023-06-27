echo off
set "basedir=%cd%"
echo %basedir%

setlocal EnableDelayedExpansion

set "filename=%basedir%\VERSION"
REM 读取文件的第一行内容作为 versioncode
set /p versioncode=<%filename%
REM 将 versioncode 加一
set /a versioncode+=1
REM 将新的 versioncode 保存回文件中
echo %versioncode% > %filename%
echo versioncode: %versioncode%

iscc "/DBaseDirS=%basedir%" "/DVCodeS=%versioncode%"  %basedir%\setup.iss

start %basedir%\Output