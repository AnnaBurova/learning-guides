# 03-errors.ps1

# Running the script
# & 'D:\VS_Code\learning-guides\theory\powershell\03-errors.ps1'

# --------------------------------------------------------------------- ------- ------------------- --------------------

# ==============================================================================
# PowerShell Error Handling Guide
# ==============================================================================

# Non-terminating vs. Terminating Errors:
#     Non-terminating:
#         Default for most cmdlets (e.g. Get-Item).
#         PowerShell displays the error message and continues running.
#         try / catch blocks will NOT catch these.
#     Terminating:
#         Fatal errors (e.g. 'throw', syntax errors,
#         or cmdlets with '-ErrorAction Stop').
#         Execution stops immediately or jumps to 'catch'.

# $ErrorActionPreference Options:
#     'Continue':
#         Default.
#         Prints errors and continues execution.
#     'Stop':
#         Converts non-terminating errors to terminating errors.
#     'SilentlyContinue':
#         Suppresses error messages.
#         Adds errors to $Error.
#     'Ignore':
#         Suppresses error messages completely.
#         Skips $Error.
#     'Inquire':
#         Prompts the user for action on error.
#     'Break':
#         Pauses execution and enters the PowerShell debugger.

# External Executables (Git, Python, etc.):
#     - External tools run outside the PowerShell engine
#       and do not throw PS exceptions.
#     - $ErrorActionPreference does NOT catch failures from external commands.
#     - Always evaluate '$LASTEXITCODE' (0 = Success, non-zero = Failure).
#
# ==============================================================================

# Default preference for this script:
$ErrorActionPreference = 'Continue'

# --------------------------------------------------------------------- ------- ------------------- --------------------

Write-Host ""

# Scenario:
#     Handling PowerShell cmdlet errors using try / catch
#     Most cmdlets produce non-terminating errors by default.
#     To trigger a 'catch' block, promote the error to
#     a terminating error by passing '-ErrorAction Stop'.

$rootPath1 = 'D:\VS_Code1'

try {
    # -ErrorAction Stop forces execution to jump to 'catch' if this cmdlet fails.
    # Out-Null suppresses standard console output when the item is found.
    Get-Item -LiteralPath $rootPath1 -ErrorAction Stop | Out-Null

    Write-Host ""
    Write-Host "Folder exists: $rootPath1" -ForegroundColor Green
}
catch {
    # $_ represents the current ErrorRecord object.
    # $_.Exception.Message contains the human-readable error description.
    Write-Host "Failed to access folder: $($_.Exception.Message)" -ForegroundColor Red
}

# --------------------------------------------------------------------- ------- ------------------- --------------------

Write-Host ""

Write-Host "LASTEXITCODE before reset: $LASTEXITCODE" -ForegroundColor Yellow

# Reset $LASTEXITCODE to 0 by running a harmless external command.
# $LASTEXITCODE is an automatic, read-only variable
# that holds the exit code of the last external (non-PowerShell) command.
# It cannot be set directly (e.g. '$LASTEXITCODE = 0' has no effect).

# To reset it, run an external command that exits with code 0.
# This updates $LASTEXITCODE while allowing the script to continue executing.
cmd /c exit 0

# Alternative (works but heavier, spawns a new PowerShell process):
# powershell -NoProfile -Command "exit 0"

Write-Host "LASTEXITCODE  after reset: $LASTEXITCODE" -ForegroundColor Yellow

# --------------------------------------------------------------------- ------- ------------------- --------------------

Write-Host ""

# Scenario:
#     Handling errors from external executables (Git, Python, Node, etc.)
#     External commands run as separate operating system processes
#     outside the PowerShell engine.
#     They do not generate native PowerShell error objects,
#     so neither 'catch' blocks nor $ErrorActionPreference
#     will intercept their failures.
#     Check the automatic variable $LASTEXITCODE instead.

git fetch --prune

# An exit code of 0 indicates success; any non-zero value indicates an error.
if ($LASTEXITCODE -eq 0) {
    Write-Host "Fetch succeeded." -ForegroundColor Green
}
else {
    Write-Host "Git fetch failed with exit code: $LASTEXITCODE" -ForegroundColor Red
}

# --------------------------------------------------------------------- ------- ------------------- --------------------

Write-Host ""

# Scenario:
#     Explicitly raising a terminating error.
#     Use 'throw' when a custom validation fails
#     (e.g., empty variable, missing directory)
#     and the script cannot safely continue.
#     'throw' generates a terminating error
#     that stops execution or jumps to 'catch'.

try {
    if (-not $rootPath) {
        throw "Fatal: Root directory path is empty. Execution stopped."
    }
}
catch {
    Write-Host "Caught: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

if (-not $rootPath) {
    throw "Fatal: Root directory path is empty. Execution stopped."
}

# --------------------------------------------------------------------- ------- ------------------- --------------------

Write-Host ""
