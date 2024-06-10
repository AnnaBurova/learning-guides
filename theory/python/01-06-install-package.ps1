#!/usr/bin/env pwsh

<#
Author: NewtCode Anna Burova
Created: 2024-06
Updated: 2026-11

Run:
& 'D:\VS_Code\learning-guides\theory\python\01-06-install-package.ps1'

Install a Package in Each Virtual Environment
#>

# ===================================================================== ======= =================== ====================

# Directory containing virtual environments
$WorkspaceDirectory = "D:\VS_Code"

$PackageName = "pytest"

$PythonVersions = @(
    "3.15"
    "3.14"
    "3.13"
    "3.12"
    "3.11"
)

# --------------------------------------------------------------------- ------- ------------------- --------------------

Set-Location -LiteralPath $WorkspaceDirectory

Write-Host ""

# --------------------------------------------------------------------- ------- ------------------- --------------------

if (Get-Command deactivate -ErrorAction SilentlyContinue) {

    Write-Host "Deactivating virtual environment..."

    deactivate

    Write-Host ""
}

# --------------------------------------------------------------------- ------- ------------------- --------------------

foreach ($Version in $PythonVersions) {

    $Environment = ".venv$($Version.Replace('.', ''))"
    $PythonPath = ".\$Environment\Scripts\python.exe"

    Write-Host "`nInstalling $PackageName in $Environment..."

    & $PythonPath -m pip install $PackageName

    if ($LASTEXITCODE -ne 0) {
        throw "Failed to install $PackageName in $Environment. Exit code: $LASTEXITCODE"
    }
}

Write-Host ""

# ===================================================================== ======= =================== ====================
