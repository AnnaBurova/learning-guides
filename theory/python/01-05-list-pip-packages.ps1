#!/usr/bin/env pwsh

<#
Author: NewtCode Anna Burova
Created: 2024-06
Updated: 2026-11

Run:
& 'D:\VS_Code\learning-guides\theory\python\01-05-list-pip-packages.ps1'

List Packages for Python Versions and Virtual Environments
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

# List installed packages for each installed Python version.
foreach ($Version in $PythonVersions) {

    Write-Host "`nListing installed packages for Python $Version..."

    py "-$Version" -m pip list

    if ($LASTEXITCODE -ne 0) {
        throw "Failed to list installed packages for Python $Version. Exit code: $LASTEXITCODE"
    }
}

# List installed packages inside each corresponding virtual environment.
foreach ($Version in $PythonVersions) {

    $Environment = ".venv$($Version.Replace('.', ''))"
    $PythonPath = ".\$Environment\Scripts\python.exe"

    Write-Host "`nListing installed packages in $Environment..."

    & $PythonPath -m pip list

    if ($LASTEXITCODE -ne 0) {
        throw "Failed to list installed packages in $Environment. Exit code: $LASTEXITCODE"
    }
}

Write-Host ""

# ===================================================================== ======= =================== ====================
