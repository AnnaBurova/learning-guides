#!/usr/bin/env pwsh

<#
Author: NewtCode Anna Burova
Created: 2026-10

Run:
& 'D:\VS_Code\learning-guides\theory\python\01-02-update-python-versions.ps1'

Update Python Versions
#>

# ===================================================================== ======= ===================

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

    Write-Host "`nUpdating Python $Version..."

    py install --update $Version

    if ($LASTEXITCODE -ne 0) {
        throw "Failed to update Python $Version. Exit code: $LASTEXITCODE"
    }
}

Write-Host ""

# --------------------------------------------------------------------- ------- ------------------- --------------------

py list

Write-Host ""

# ===================================================================== ======= ===================
