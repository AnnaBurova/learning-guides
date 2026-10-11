#!/usr/bin/env pwsh

<#
Author: NewtCode Anna Burova
Created: 2026-10

Run:
& 'D:\VS_Code\learning-guides\theory\python\01-07-uninstall-non-core-packages.ps1'

Uninstall Packages from Python Versions and Virtual Environments
#>

# ===================================================================== ======= ===================

# Directory containing virtual environments
$WorkspaceDirectory = "D:\VS_Code"

$PythonVersions = @(
    "3.15"
    "3.14"
    "3.13"
    "3.12"
    "3.11"
)

# --------------------------------------------------------------------- ------- -------------------

Set-Location -LiteralPath $WorkspaceDirectory

Write-Host ""

# --------------------------------------------------------------------- ------- -------------------

if (Get-Command deactivate -ErrorAction SilentlyContinue) {

    Write-Host "Deactivating virtual environment..."

    deactivate

    Write-Host ""
}

# --------------------------------------------------------------------- ------- -------------------

# Uninstall packages from each installed Python version.
foreach ($Version in $PythonVersions) {

    $RequirementsFile = ".\uninstall_packages_python$($Version.Replace('.', '')).txt"

    Write-Host "`nUninstalling packages from Python $Version..."

    py "-$Version" -m pip freeze > $RequirementsFile

    $Packages = @(Get-Content -LiteralPath $RequirementsFile | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })

    if ($Packages.Count -eq 0) {
        Write-Host "No packages found for Python $Version; continuing..."
        continue
    }

    py "-$Version" -m pip uninstall -y -r $RequirementsFile

    if ($LASTEXITCODE -ne 0) {
        throw "Failed to uninstall packages for Python $Version. Exit code: $LASTEXITCODE"
    }
}

# Uninstall packages from each corresponding virtual environment.
foreach ($Version in $PythonVersions) {

    $Environment = ".venv$($Version.Replace('.', ''))"
    $PythonPath = ".\$Environment\Scripts\python.exe"
    $RequirementsFile = ".\uninstall_packages_venv$($Version.Replace('.', '')).txt"

    Write-Host "`nUninstalling packages from $Environment..."

    & $PythonPath -m pip freeze > $RequirementsFile

    $Packages = @(Get-Content -LiteralPath $RequirementsFile | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })

    if ($Packages.Count -eq 0) {
        Write-Host "No packages found in $Environment; continuing..."
        continue
    }

    & $PythonPath -m pip uninstall -y -r $RequirementsFile

    if ($LASTEXITCODE -ne 0) {
        throw "Failed to uninstall packages from $Environment. Exit code: $LASTEXITCODE"
    }
}

Write-Host ""

# ===================================================================== ======= ===================
