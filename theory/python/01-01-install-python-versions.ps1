#!/usr/bin/env pwsh

<#
Author: NewtCode Anna Burova
Created: 2026-10

Run:
& 'D:\VS_Code\learning-guides\theory\python\01-01-install-python-versions.ps1'

Install Python Versions Using the Python Install Manager
#>

# ===================================================================== ======= =================== ====================

$PythonVersions = @(
    # "3.15"  # NO !
    "3.14"
    "3.13"
    "3.12"
    "3.11"
)

# --------------------------------------------------------------------- ------- ------------------- --------------------

Write-Host ""

# --------------------------------------------------------------------- ------- ------------------- --------------------

foreach ($Version in $PythonVersions) {

    Write-Host "`nInstalling Python $Version ..."

    py install $Version

    if ($LASTEXITCODE -ne 0) {
        throw "Failed to install Python $Version. Exit code: $LASTEXITCODE"
    }
}

Write-Host ""

# --------------------------------------------------------------------- ------- ------------------- --------------------

py list

Write-Host ""

# --------------------------------------------------------------------- ------- ------------------- --------------------

python --version

foreach ($Version in $PythonVersions) {

    py "-$Version" --version

    if ($LASTEXITCODE -ne 0) {
        throw "Failed to check Python $Version. Exit code: $LASTEXITCODE"
    }
}

Write-Host ""

# ===================================================================== ======= =================== ====================
