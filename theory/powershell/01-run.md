# PowerShell Guide

## Script location

Save the script in the folder: D:\VS_Code.
It can be run from any PowerShell working directory.

-------------------------------------------------------------------------------

## Running the script

Run the script by its full path

```powershell
& 'D:\VS_Code\script_powershell.ps1'
```

Change to the script directory and run the script directly

```powershell
PS D:\VS_Code> .\script_powershell.ps1
```

-------------------------------------------------------------------------------

## Dot-sourcing the script

```powershell
. 'D:\VS_Code\script_powershell.ps1'
```

The dot followed by a space is the **dot-sourcing operator**.

Dot-sourcing runs the script in the current PowerShell scope.
Variables and functions created by the script remain available
in the current PowerShell session after the script finishes.

Use dot-sourcing when a script is intended to load functions,
aliases, variables, or configuration into the current session.

-------------------------------------------------------------------------------

## Call operator

```powershell
& 'D:\VS_Code\script_powershell.ps1'
```

The ampersand (`&`) is the **call operator**.

It runs the script normally in its own script scope.
Variables created by the script do not remain available
in the current PowerShell session after the script finishes.

Use the call operator for scripts that perform an operation and
should not leave their internal variables or functions in the current session.

-------------------------------------------------------------------------------

## Dot-sourcing vs. normal execution

| Command | Execution scope | Variables remain available? |
| --- | --- | ---: |
| `. 'D:\VS_Code\script_powershell.ps1'` | Current PowerShell scope | Yes |
| `. .\script_powershell.ps1` | Current PowerShell scope | Yes |
| `& 'D:\VS_Code\script_powershell.ps1'` | Script scope | No |
| `.\script_powershell.ps1` | Script scope | No |

-------------------------------------------------------------------------------

## Saving output to a log file

### `*>&1`

Redirection operator merges all PowerShell output streams
into the success output stream.

This includes:

- Standard output
- Errors
- Warnings
- Verbose messages
- Debug messages
- Information messages

### `Tee-Object`

Displays the output in the console and writes the same output to a file.

The name comes from the Unix `tee` command and refers to a T-shaped split:
one input is sent to two outputs.

### `-FilePath`

This parameter specifies the path and name of the log file.

### Run from `D:\VS_Code`

```powershell
.\script_powershell.ps1 *>&1 | Tee-Object -FilePath .\script_powershell_output.txt
```

This creates the log file in the current PowerShell working directory.

### Run from any working directory

```powershell
& 'D:\VS_Code\script_powershell.ps1' *>&1 | Tee-Object -FilePath 'D:\VS_Code\script_powershell_output.txt'
```

This always writes the log file to `D:\VS_Code`
because the log path is absolute.

-------------------------------------------------------------------------------

## Silent file redirection

Redirects all streams into a file without printing to the terminal:

```powershell
# Overwrite the log file
.\script_powershell.ps1 *> '.\script_powershell.log'

# Append to the log file
.\script_powershell.ps1 *>> '.\script_powershell.log'
```

The operator `*>` captures all six PowerShell output streams
directly into the target document.

-------------------------------------------------------------------------------

## Session transcription (`Start-Transcript`)

Records everything occurring during script execution,
including native commands, pipeline data, errors,
and `Write-Host` output.

Place these commands at the beginning and end of the script:

```powershell
# At the very start of the script
Start-Transcript -Path 'D:\VS_Code\script_powershell.log' -Append

# Script logic

# At the very end of the script
Stop-Transcript
```

- Output displays normally in the console while being appended to the log file.
- Automatically writes a header with timestamps, user credentials,
and PowerShell version details.

-------------------------------------------------------------------------------

## Important note about colors

> **Warning:** `Write-Host` colors are not preserved when output is redirected through `*>&1` and `Tee-Object`.

Run the script normally to see colored output in the terminal:

```powershell
& 'D:\VS_Code\script_powershell.ps1'
```

Use `Tee-Object` when you need to display the output
and save a text log at the same time.
The log file contains plain text rather than terminal color formatting.
