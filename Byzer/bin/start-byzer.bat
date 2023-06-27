@echo off
set base=%~dp0%..\

echo %base%
for %%I in ("%base%") do set sbase=%%~fsI
echo %sbase%


%sbase%\..\jre-1.8\bin\java.exe ^
-Xmx1g ^
-classpath %sbase%\main\byzer-lang-3.3.0-2.12-2.3.7.jar;^
%sbase%\spark\*;%sbase%\libs\*;%sbase%\plugin\* ^
 -Dspark.driver.memory=2g tech.mlsql.example.app.LocalSparkServiceApp^
 --driver-memory 2g ^
 -streaming.plugin.clzznames ^
 tech.mlsql.plugins.ds.MLSQLExcelApp,^
 tech.mlsql.plugins.assert.app.MLSQLAssert,^
 tech.mlsql.plugins.shell.app.MLSQLShell,^
 tech.mlsql.plugins.ext.ets.app.MLSQLETApp,^
 tech.mlsql.plugins.mllib.app.MLSQLMllib