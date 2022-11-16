#Requires -RunAsAdministrator

Import-RegFile apply.reg

# disable-user-data-collector
Set-ItemProperty (
    Get-CurrentAndNewUserPaths 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy'
) TailoredExperiencesWithDiagnosticDataEnabled 0
Set-ItemProperty (
    Get-CurrentAndNewUserPaths 'HKCU:\SOFTWARE\Microsoft\Siuf\Rules'
) NumberOfSIUFInPeriod 0
Set-ItemProperty (
    Get-CurrentAndNewUserPaths 'HKCU:\SOFTWARE\Microsoft\Siuf\Rules'
) PeriodInNanoSeconds 0

# disable-dynamic-lockscreen-pictures
Set-ItemProperty (
    Get-CurrentAndNewUserPaths 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'
) RotatingLockScreenEnabled 0

# disable-cortana
Set-ItemProperty (
    Get-CurrentAndNewUserPaths 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Windows Search'
) CortanaConsent 0

# disable-input-features-collector
Set-ItemProperty (
    Get-CurrentAndNewUserPaths 'HKCU:\Software\Microsoft\Input\TIPC'
) Enabled 0

# disable-msoffice-collector
Set-ItemProperty (
    Get-CurrentAndNewUserPaths 'HKCU:\Software\Policies\Microsoft\Office\Common\ClientTelemetry'
) SendTelemetry 3
Set-ItemProperty (
    Get-CurrentAndNewUserPaths 'HKCU:\Software\Microsoft\Office\Common\ClientTelemetry'
) DisableTelemetry 1

Disable-BundledService dmwappushservice, DiagTrack

& {
    schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable
    schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable
    if ($osver.Build -gt 7601) {
        schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClient" /Disable
        schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /Disable
    }
}>$null