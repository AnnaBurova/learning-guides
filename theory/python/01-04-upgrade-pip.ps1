#!/usr/bin/env pwsh

<#
Author: NewtCode Anna Burova
Created: 2026-10

Run:
& 'D:\VS_Code\learning-guides\theory\python\01-04-upgrade-pip.ps1'

Upgrade pip for Python Versions and Virtual Environments
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

# Upgrade pip globally for each installed Python version.
foreach ($Version in $PythonVersions) {

    Write-Host "`nUpgrading pip for Python $Version..."

    py "-$Version" -m pip install --upgrade pip

    if ($LASTEXITCODE -ne 0) {
        throw "Failed to upgrade pip for Python $Version. Exit code: $LASTEXITCODE"
    }
}

# Upgrade pip separately inside each existing virtual environment.
foreach ($Version in $PythonVersions) {

    $Environment = ".venv$($Version.Replace('.', ''))"
    $PythonPath = ".\$Environment\Scripts\python.exe"

    Write-Host "`nUpgrading pip in $Environment..."

    & $PythonPath -m pip install --upgrade pip

    if ($LASTEXITCODE -ne 0) {
        throw "Failed to upgrade pip in $Environment. Exit code: $LASTEXITCODE"
    }
}

Write-Host ""

# ===================================================================== ======= ===================
