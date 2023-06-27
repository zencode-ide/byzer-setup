; 脚本由 Inno Setup 脚本向导 生成！
; 有关创建 Inno Setup 脚本文件的详细资料请查阅帮助文档！
#define MyAppName "Byzer-Win"
#define MyAppVersion "1.0"

#ifdef BaseDirS
  #undef  BaseDir
  #define BaseDir BaseDirS
#else
  #define BaseDir "d:\byzer-setup"
#endif

#ifdef VCodeS
  #undef  VCode
  #define VCode VCodeS
#else
  #define VCode "1"
#endif


[Setup]
; 注: AppId的值为单独标识该应用程序。
; 不要为其他安装程序使用相同的AppId值。
; (若要生成新的 GUID，可在菜单中点击 "工具|生成 GUID"。)
AppId={{888C045A-C4E8-4A23-AEB7-D47878DA1D69}

AppName={#MyAppName}
AppVersion={#MyAppVersion}.{#VCode}
;AppVerName={#MyAppName} {#MyAppVersion}
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
; 以下行取消注释，以在非管理安装模式下运行（仅为当前用户安装）。
;PrivilegesRequired=lowest
OutputBaseFilename=byzer-setup-{#MyAppVersion}.{#VCode}
Compression=lzma
SolidCompression=yes
WizardStyle=modern
[Languages]
Name: "chinesesimp"; MessagesFile: "compiler:Default.isl"

[Files]

; 安装jre1.8
Source: "{#BaseDir}\jre-1.8\*"; DestDir: "{app}\jre-1.8\"; Flags: ignoreversion recursesubdirs createallsubdirs

; 安装Hadoop
Source: "{#BaseDir}\hadoop\*"; DestDir: "{app}\hadoop\"; Flags: ignoreversion recursesubdirs createallsubdirs

; 安装Byzer
Source: "{#BaseDir}\byzer\*"; DestDir: "{app}\byzer\"; Flags: ignoreversion recursesubdirs createallsubdirs

; 安装nssm
Source: "{#BaseDir}\nssm.exe"; DestDir: "{app}";  Flags: ignoreversion


[Run]
; 以下文件为mysql、nginx、redis、jar包四个组件启动的文件路径，
;Filename: "{tmp}\vcredist_x86.exe"; Parameters: "/install /passive /norestart"; WorkingDir: "{tmp}"; Flags: shellexec runhidden
Filename: "{app}\hadoop\post-install.bat"; Flags: runhidden waituntilterminated

Filename: "{app}\nssm.exe"; Parameters: "install tensafeplt-byzer ""{app}\byzer\bin\start-byzer.bat"""; Flags: shellexec  waituntilterminated;
Filename: "{app}\nssm.exe"; Parameters: "set tensafeplt-byzer AppDirectory ""{app}\byzer\bin"""; Flags: shellexec  waituntilterminated;
Filename: "{app}\nssm.exe"; Parameters: "start tensafeplt-byzer"; Flags: shellexec  waituntilterminated;


[UninstallRun]
; 卸载应用时执行以下文件

Filename: "{app}\nssm.exe"; Parameters: "stop tensafeplt-byzer"; Flags: shellexec runhidden waituntilterminated; RunOnceId: "0CF6D299-EF15-498D-9DBF-548030809D83"
Filename: "{app}\nssm.exe"; Parameters: "remove tensafeplt-byzer confirm"; Flags: shellexec runhidden waituntilterminated; RunOnceId: "35629476-1EAF-44A2-92A4-500ADFCE64EF"
