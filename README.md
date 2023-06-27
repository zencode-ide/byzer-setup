## 1. 打包需求
Byzer官网提供了[Byzer All In One](https://docs.byzer.org/#/byzer-lang/zh-cn/installation/server/byzer-all-in-one-deployment?id=byzer-all-in-one-%e5%ae%89%e8%a3%85%e4%b8%8e%e9%85%8d%e7%bd%ae)开箱即用工具包，支持实现开发Dev环境的快速配置。<br />在Windows操作系统中，需要配置java环境、hadoop环境、以及相应的环境变量，为此，尝试提供基于inno setup 的打包脚本，实现对各类运行环境的一键部署支持。<br />安装包下载地址：<br />链接：[https://pan.baidu.com/s/1BqcKBAPFUG_PjXAlOuKlzA](https://pan.baidu.com/s/1BqcKBAPFUG_PjXAlOuKlzA)  提取码：6sp2
## 2. 核心运行批处理脚本
```bash
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
```
默认调整2g内存，可根据实际业务需要调整；
## 3. 打包脚本
```bash
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
```

1. 安装inno setup 安装包；
2. 配置inno setup 安装路径到Path环境变量（方便使用iscc命令）
3. 增加打包版本号跟踪功能，每次编译后版本号+1；
4. iscc运行时，配置环境变量，方便脚本正确运行；
## 4. 服务注册

1. 使用nssm实现对Byzer的服务注册与管理；
2. 注: 360安全卫士等杀毒软件可能会拦截nssm的服务注册功能，安装时可临时关闭或根据需要是否注册服务；
### 5. 解决byzer运行时对hadoop的依赖
出错提示：
> HADOOP_HOME and hadoop.home.dir are unset. -see https://wiki.apache.org/hadoop/WindowsProblems

使用 [https://github.com/kontext-tech/winutils](https://github.com/kontext-tech/winutils/tree/master) 3.3.1版本的 Hadoop 3.3.1 winutils，并设置环境变量HADOOP_HOME为winutils所在目录。<br />![image.png](https://cdn.nlark.com/yuque/0/2023/png/25461494/1687845955717-d0d5245d-4448-4c0a-98ae-854e56e793f2.png#averageHue=%23ddd6cb&clientId=u2cf5fe21-1d44-4&from=paste&height=182&id=u00d9005c&originHeight=364&originWidth=806&originalType=binary&ratio=2&rotation=0&showTitle=false&size=91409&status=done&style=none&taskId=u277b1bb4-e24c-40ec-851c-b6ca27fc66f&title=&width=403)
## 6.测试功能

1. Byzer服务运行正常；
2. 脚本执行正常

![image.png](https://cdn.nlark.com/yuque/0/2023/png/25461494/1687867412049-4e7bb722-b042-44f5-a87f-599edcfbde7b.png#averageHue=%23656565&clientId=u72aec3dc-4825-4&from=paste&height=465&id=u91efb4a0&originHeight=930&originWidth=1138&originalType=binary&ratio=2&rotation=0&showTitle=false&size=81568&status=done&style=none&taskId=u1cfc3f31-668f-4df0-aa19-d3ab6f795c1&title=&width=569)
