#!/usr/bin/env pwsh

<#
Author: NewtCode Anna Burova
Created: 2024-06
Updated: 2026-11

Run:
& 'D:\VS_Code\learning-guides\theory\python\01-04-upgrade-pip.ps1'

Upgrade pip for Python Versions and Virtual Environments
#>

if (Get-Command deactivate -ErrorAction SilentlyContinue) {

    Write-Host "`nDeactivating virtual environment..."

    deactivate
}

$PythonVersions = @(
    "3.15"
    "3.14"
    "3.13"
    "3.12"
    "3.11"
)

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
