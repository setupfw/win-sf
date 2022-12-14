#Requires -RunAsAdministrator
param($cfg)

function Hide-CommonTarget([string]$filename) {
    Get-ChildItem "C:\Users\*\AppData\Roaming\Microsoft\Windows\SendTo\$filename" |`
        ForEach-Object { $_.Attributes += 'Hidden' }
}

if ($cfg.optimize) {
    Hide-CommonTarget 'Fax Recipient.lnk'
    Hide-CommonTarget '*.mydocs'
}

if ($cfg.addStartMenu) {
    $defaultUserSendToFolder = 'C:\Users\Default\AppData\Roaming\Microsoft\Windows\SendTo'

    $it = New-Shortcut -Lnk "$env:APPDATA\Microsoft\Windows\SendTo\$(
            Get-Translation 'Start Menu' -cn '开始菜单'
        )"
    $it.IconLocation = if (Test-Windows7) { 'imageres.dll,203' } else { 'imageres.dll,204' }
    $it.TargetPath = '%APPDATA%\Microsoft\Windows\Start Menu\Programs'
    $it.Save()
    Copy-Item $it.FullName $defaultUserSendToFolder

    $it = New-Shortcut -Lnk "$env:APPDATA\Microsoft\Windows\SendTo\$(
            Get-Translation 'Start Menu (All Users)' -cn '开始菜单 (所有用户)'
        )"
    $it.IconLocation = 'imageres.dll,73'
    $it.TargetPath = 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs'
    $it.Save()
    Copy-Item $it.FullName $defaultUserSendToFolder
}
