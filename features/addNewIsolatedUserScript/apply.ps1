#Requires -RunAsAdministrator

$target = "$(mkdir -f "$(Get-AppFolderPath)\scripts")\newIsolatedUser.ps1"
Copy-Item 'script.ps1' $target

$it = New-Shortcut "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\New Isolated User.lnk"
$it.IconLocation = 'imageres.dll,73'
$it.TargetPath = "powershell.exe"
$it.Arguments = "-exec bypass -file `"$target`""
$it.Save()
Set-ShortcutRunAsAdmin $it.FullName
