; �ű��� Inno Setup �ű��� ���ɣ�
; �йش��� Inno Setup �ű��ļ�����ϸ��������İ����ĵ���
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
; ע: AppId��ֵΪ������ʶ��Ӧ�ó���
; ��ҪΪ������װ����ʹ����ͬ��AppIdֵ��
; (��Ҫ�����µ� GUID�����ڲ˵��е�� "����|���� GUID"��)
AppId={{888C045A-C4E8-4A23-AEB7-D47878DA1D69}

AppName={#MyAppName}
AppVersion={#MyAppVersion}.{#VCode}
;AppVerName={#MyAppName} {#MyAppVersion}
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
; ������ȡ��ע�ͣ����ڷǹ���װģʽ�����У���Ϊ��ǰ�û���װ����
;PrivilegesRequired=lowest
OutputBaseFilename=byzer-setup-{#MyAppVersion}.{#VCode}
Compression=lzma
SolidCompression=yes
WizardStyle=modern
[Languages]
Name: "chinesesimp"; MessagesFile: "compiler:Default.isl"

[Files]

; ��װjre1.8
Source: "{#BaseDir}\jre-1.8\*"; DestDir: "{app}\jre-1.8\"; Flags: ignoreversion recursesubdirs createallsubdirs

; ��װHadoop
Source: "{#BaseDir}\hadoop\*"; DestDir: "{app}\hadoop\"; Flags: ignoreversion recursesubdirs createallsubdirs

; ��װByzer
Source: "{#BaseDir}\byzer\*"; DestDir: "{app}\byzer\"; Flags: ignoreversion recursesubdirs createallsubdirs

; ��װnssm
Source: "{#BaseDir}\nssm.exe"; DestDir: "{app}";  Flags: ignoreversion


[Run]
; �����ļ�Ϊmysql��nginx��redis��jar���ĸ�����������ļ�·����
;Filename: "{tmp}\vcredist_x86.exe"; Parameters: "/install /passive /norestart"; WorkingDir: "{tmp}"; Flags: shellexec runhidden
Filename: "{app}\hadoop\post-install.bat"; Flags: runhidden waituntilterminated

Filename: "{app}\nssm.exe"; Parameters: "install tensafeplt-byzer ""{app}\byzer\bin\start-byzer.bat"""; Flags: shellexec  waituntilterminated;
Filename: "{app}\nssm.exe"; Parameters: "set tensafeplt-byzer AppDirectory ""{app}\byzer\bin"""; Flags: shellexec  waituntilterminated;
Filename: "{app}\nssm.exe"; Parameters: "start tensafeplt-byzer"; Flags: shellexec  waituntilterminated;


[UninstallRun]
; ж��Ӧ��ʱִ�������ļ�

Filename: "{app}\nssm.exe"; Parameters: "stop tensafeplt-byzer"; Flags: shellexec runhidden waituntilterminated; RunOnceId: "0CF6D299-EF15-498D-9DBF-548030809D83"
Filename: "{app}\nssm.exe"; Parameters: "remove tensafeplt-byzer confirm"; Flags: shellexec runhidden waituntilterminated; RunOnceId: "35629476-1EAF-44A2-92A4-500ADFCE64EF"
