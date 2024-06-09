#!/usr/bin/env pwsh

<#
Author: NewtCode Anna Burova
Created: 2024-06
Updated: 2026-11

Run:
& 'D:\VS_Code\learning-guides\theory\python\01-03-create-virtual-environments.ps1'

Create Python Virtual Environments
#>

# ===================================================================== ======= =================== ====================

$PythonVersions = @(
    "3.15"
    "3.14"
    "3.13"
    "3.12"
    "3.11"
)

# --------------------------------------------------------------------- ------- ------------------- --------------------

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

    Write-Host "`nCreating $Environment with Python $Version..."

    py "-$Version" -m venv $Environment

    if ($LASTEXITCODE -ne 0) {
        throw "Failed to create $Environment with Python $Version. Exit code: $LASTEXITCODE"
    }
}

Write-Host ""

# ===================================================================== ======= =================== ====================
