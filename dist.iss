[Setup]
AppName=LazySetting
AppVersion=1.0
DefaultDirName={autopf}\MyApp
OutputDir=D:\Coding\Project\ntdotjsx_setting
OutputBaseFilename=LazySetting
Compression=lzma
SolidCompression=yes

[Files]
Source: "D:\Coding\Project\ntdotjsx_setting\setup.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Coding\Project\ntdotjsx_setting\core\setup.ps1"; DestDir: "{app}\core"; Flags: ignoreversion
Source: "D:\Coding\Project\ntdotjsx_setting\core\profile.ps1"; DestDir: "{app}\core"; Flags: ignoreversion

[Run]
Filename: "{app}\setup.bat"; Description: "Run Setup"; Flags: postinstall runhidden
