#!/usr/bin/env pwsh

<#
Author: NewtCode Anna Burova
Created: 2024-06
Updated: 2026-11

Run:
& 'D:\VS_Code\learning-guides\theory\python\01-02-update-python-versions.ps1'

Update Python Versions
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

foreach ($Version in $PythonVersions) {

    Write-Host "`nUpdating Python $Version..."

    py install --update $Version

    if ($LASTEXITCODE -ne 0) {
        throw "Failed to update Python $Version. Exit code: $LASTEXITCODE"
    }
}

Write-Host ""

py list
