# 02-variables.ps1

# Running the script
# & 'D:\VS_Code\learning-guides\theory\powershell\02-variables.ps1'
# & 'D:\VS_Code\learning-guides\theory\powershell\02-variables.ps1' *>&1 | Tee-Object -FilePath 'D:\VS_Code\learning-guides\theory\powershell\02-variables-output.txt'

# --------------------------------------------------------------------- ------- ------------------- --------------------

# ==============================================================================
# PowerShell Variables and Scopes Guide
# ==============================================================================

# Get-Variable displays variables available in the current PowerShell session.
# The command returns variable metadata, including:
# - Name
# - Value
# - Description
# - Visibility
# - Options
# - Module
# - Attributes

# The automatic variable $_ is not required for Get-Variable itself.
# It is used later inside pipeline script blocks when processing objects.

# ==============================================================================

# Create sample variables for the examples below.
$rootPath = 'D:\VS_Code'
$projectName = 'PowerShell Learning Guides'
$scriptVersion = 1

# --------------------------------------------------------------------- ------- ------------------- --------------------

Write-Host "# =============================================================================="
Write-Host "# Get-Variable "
Write-Host "# =============================================================================="

# Display all variables visible in the current scope.
Get-Variable

Write-Host "# =============================================================================="
Write-Host "# gv "
Write-Host "# =============================================================================="

# The alias 'gv' performs the same operation.
gv

# --------------------------------------------------------------------- ------- ------------------- --------------------

Write-Host "# =============================================================================="
Write-Host "# Get-Variable | Select-Object -ExpandProperty Name "
Write-Host "# =============================================================================="

# Display only variable names.
Get-Variable |
    Select-Object -ExpandProperty Name

Write-Host "# =============================================================================="
Write-Host "# Get-Variable | Select-Object Name "
Write-Host "# =============================================================================="

# Select-Object Name returns variable objects containing only the Name property.
Get-Variable |
    Select-Object Name

Write-Host "# =============================================================================="
Write-Host "# Get-Variable | Select-Object Name, Value "
Write-Host "# =============================================================================="

# Display variable names and values.
Get-Variable |
    Select-Object Name, Value

Write-Host "# =============================================================================="
Write-Host "# Get-Variable | Select-Object Name, Value | Format-Table -AutoSize "
Write-Host "# =============================================================================="

# Format the result as an automatically sized table.
Get-Variable |
    Select-Object Name, Value |
    Format-Table -AutoSize
    # Format-Table -AutoSize -Wrap

# This is similar to:
#   Get-Variable
# or
#   gv
# but adjusts column widths automatically
# so long variable names are fully visible.
# Use -Wrap to display full values with line wrapping.

# --------------------------------------------------------------------- ------- ------------------- --------------------

# Variable scopes determine where variables are created and available.

Write-Host "# =============================================================================="
Write-Host "# Get-Variable -Scope 0 "
Write-Host "# =============================================================================="

# Scope 0 represents the current scope.
Get-Variable -Scope 0

Write-Host "# =============================================================================="
Write-Host "# Get-Variable -Scope Local "
Write-Host "# =============================================================================="

# The Local scope is the current scope.
Get-Variable -Scope Local

Write-Host "# =============================================================================="
Write-Host "# Get-Variable -Scope 1 "
Write-Host "# =============================================================================="

# Scope 1 represents the parent scope.
Get-Variable -Scope 1

Write-Host "# =============================================================================="
Write-Host "# Get-Variable -Scope Global "
Write-Host "# =============================================================================="

# The Global scope belongs to the current PowerShell session.
Get-Variable -Scope Global

Write-Host "# =============================================================================="
Write-Host "# Compare-Object -Scope "
Write-Host "# =============================================================================="

# Compare variables from the current scope with variables from the parent scope.
Compare-Object `
    (Get-Variable -Scope 0) `
    (Get-Variable -Scope 1)

# Compare-Object shows differences between the two collections.
# The SideIndicator property identifies where each item was found:
# <= means the item exists only in the reference collection.
# => means the item exists only in the difference collection.

Write-Host "# =============================================================================="
Write-Host "# Get-Variable Sort-Object "
Write-Host "# =============================================================================="

# Display variables currently visible in the current scope.
Get-Variable |
    Sort-Object Name |
    Select-Object Name, Value |
    Format-Table -AutoSize

# --------------------------------------------------------------------- ------- ------------------- --------------------

Write-Host "# =============================================================================="
Write-Host "# Get-Variable -Name rootPath "
Write-Host "# =============================================================================="

# The -Name parameter expects the variable name without the $ symbol.
# Stream 1:
Get-Variable -Name rootPath
# Stream 6:
# Get-Variable -Name rootPath |
#     Format-List Name, Value

# Do not write the following form:
# Get-Variable -Name $rootPath

# In that expression, PowerShell evaluates $rootPath first
# and passes its value, 'D:\VS_Code', as the variable name.

# |
# |  Get-Variable -Name $rootPath
# |  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# | Unable to find a variable with the name "D:\VS_Code".

# --------------------------------------------------------------------- ------- ------------------- --------------------

Write-Host ""
