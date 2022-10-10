. .\lib\require-admin.ps1

foreach ($moduleName in
    @(
        'tweak_registry'
        'debloat'
        'deploy_pkgs'
    )
) {
    if (Test-Path ".\modules\$moduleName") {
        Write-Host "==> Running '$moduleName' modules"
        & ".\modules\$moduleName\main.ps1"
    }
}

& '.\lib\submit-sysprep.ps1'