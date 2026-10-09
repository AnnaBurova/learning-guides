#!/usr/bin/env pwsh

<#
Author: NewtCode Anna Burova
Created: 2026-10

Run:
& 'D:\VS_Code\learning-guides\theory\powershell\02-colors.ps1'

PowerShell Console Colors
#>

# ===================================================================== ======= =================== ====================

Write-Host ""

# --------------------------------------------------------------------- ------- ------------------- --------------------

# Test foreground colors
Write-Host "Yellow TEXT" -ForegroundColor Yellow

Write-Host ""

# Test foreground and background colors
Write-Host "Black TEXT ON Yellow BACKGROUND" `
    -ForegroundColor Black `
    -BackgroundColor Yellow

Write-Host ""
Write-Host ""

Write-Host "DarkBlue TEXT ON A Magenta BACKGROUND" -ForegroundColor DarkBlue -BackgroundColor Magenta

Write-Host ""
Write-Host ""

# --------------------------------------------------------------------- ------- ------------------- --------------------

# Display all available ConsoleColor values.

[System.Enum]::GetValues([System.ConsoleColor]) | ForEach-Object {
    Write-Host $_ -ForegroundColor $_
}

Write-Host ""

# --------------------------------------------------------------------- ------- ------------------- --------------------

# Available ConsoleColor values:
# Black
# DarkBlue
# DarkGreen
# DarkCyan
# DarkRed
# DarkMagenta
# DarkYellow
# Gray
# DarkGray
# Blue
# Green
# Cyan
# Red
# Magenta
# Yellow
# White

# --------------------------------------------------------------------- ------- ------------------- --------------------

[System.Enum]::GetValues([System.ConsoleColor]) | ForEach-Object {

    $backgroundColor = $_

    $foregroundColor = 'Black'

    Write-Host "$backgroundColor" -ForegroundColor $foregroundColor -BackgroundColor $backgroundColor

    Write-Host ""
}

Write-Host ""

# --------------------------------------------------------------------- ------- ------------------- --------------------

[System.Enum]::GetValues([System.ConsoleColor]) | ForEach-Object {

    # NOTE: VS Code integrated terminal modifies text colors by default.
    # The accessibility feature "Minimum Contrast Ratio" dynamically alters
    # foreground colors to match its contrast algorithm, which may override
    # explicitly defined foreground colors (e.g. White on DarkGreen/DarkCyan).

    # To display exact colors without automatic contrast adjustment,
    # add this line to VS Code user settings (settings.json):
    # "terminal.integrated.minimumContrastRatio": 1

    $backgroundColor = $_.ToString()

    $foregroundColor = if ($backgroundColor -in @(
        'Black',
        'DarkBlue',
        'DarkGreen',
        'DarkCyan',
        'DarkRed',
        'DarkMagenta',
        'DarkGray',
        'Blue'
    )) {
        # [System.ConsoleColor]::White
        'White'
    }
    else {
        # [System.ConsoleColor]::Black
        'Black'
    }

    Write-Host " $($backgroundColor.ToString().PadRight(12)) " `
        -ForegroundColor $foregroundColor `
        -BackgroundColor $backgroundColor `
        -NoNewline

    Write-Host " Foreground: $foregroundColor | Background: $backgroundColor "
}

Write-Host ""

# ===================================================================== ======= =================== ====================
