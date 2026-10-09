```text
Author: NewtCode Anna Burova
Created: 2026-10
```

# PowerShell Guide

## Running a Script

In this example, `D:\VS_Code` is used as the working folder to demonstrate absolute paths.

A script can be run by its full path from any PowerShell working directory.

Run the script by its full path:

```pwsh
& 'D:\VS_Code\script_powershell.ps1'
```

Change to the script directory and run the script directly:

```pwsh
& '.\script_powershell.ps1'
```

## Script Execution Modes

### Dot-Sourcing

The dot followed by a space is the **dot-sourcing operator**.

```pwsh
. 'D:\VS_Code\script_powershell.ps1'
```

Dot-sourcing runs a script in the current PowerShell scope.
Variables and functions created by the script remain available
in the current PowerShell session after the script finishes.

Use dot-sourcing when a script is intended to load functions,
aliases, variables, or configuration into the current session.

### Call Operator

The ampersand (`&`) is the **call operator**.

```pwsh
& 'D:\VS_Code\script_powershell.ps1'
```

It runs the script normally in its own script scope.
Variables created by the script do not remain available
in the current PowerShell session after the script finishes.

Use the call operator for scripts that perform an operation and
should not leave their internal variables or functions in the current session.

## Scope Differences

### Dot-Sourcing

```pwsh
. 'D:\VS_Code\script_powershell.ps1'
```
```pwsh
. '.\script_powershell.ps1'
```

- Runs in the current PowerShell console scope.
- Variables remain available after the script finishes.

### Call Operator

```pwsh
& 'D:\VS_Code\script_powershell.ps1'
```
```pwsh
& '.\script_powershell.ps1'
```
```pwsh
.\script_powershell.ps1
```

- Runs in the scripts own scope.
- Variables created inside the script are not available outside it.

## Saving Output to a Log File

### `*>&1`

The redirection operator `*>&1` merges all PowerShell output streams into the success output stream.

This includes:

- Standard output
- Errors
- Warnings
- Verbose messages
- Debug messages
- Information messages

### `Tee-Object`

The `Tee-Object` displays the output in the console and writes the same output to a file.

The name comes from the Unix `tee` command and refers to a T-shaped split:
one input is sent to two outputs.

### `-FilePath`

The `-FilePath` parameter specifies the path and name of the log file.

### Run from `D:\VS_Code`

```pwsh
& '.\script_powershell.ps1' *>&1 | Tee-Object -FilePath '.\script_powershell_output.log'
```

This creates the log file in the current PowerShell working directory.

### Run from any working directory

```pwsh
& 'D:\VS_Code\script_powershell.ps1' *>&1 | Tee-Object -FilePath 'D:\VS_Code\script_powershell_output.log'
```

This always writes the log file to `D:\VS_Code` because the log path is absolute.

### Important Note About Colors

> **Warning:** `Write-Host` colors are not preserved when output is redirected through `*>&1` and `Tee-Object`.

Run the script normally to see colored output in the terminal:

```pwsh
& 'D:\VS_Code\script_powershell.ps1'
```

Use `Tee-Object` to display the output and save a text log at the same time.
The log file contains plain text rather than terminal color formatting.

## Silent File Redirection

Redirect all streams to a file without printing them to the terminal:

```pwsh
# Overwrite the log file
& '.\script_powershell.ps1' *> '.\script_powershell_output.log'
```
```pwsh
# Append to the log file
& '.\script_powershell.ps1' *>> '.\script_powershell_output.log'
```

The `*>` operator captures all six PowerShell output streams directly into the target file.

## Session Transcription (`Start-Transcript`)

`Start-Transcript` records everything that occurs during script execution,
including native commands, pipeline data, errors, and `Write-Host` output.

Place these commands at the beginning and end of the script:

```pwsh
# At the very start of the script
Start-Transcript -Path 'D:\VS_Code\script_powershell.log' -Append

# TODO: Script logic

# At the very end of the script
Stop-Transcript
```

- Output is displayed normally in the console while being appended to the log file.
- PowerShell automatically writes a header containing timestamps, user information,
and PowerShell version details.

## Note About Output Order in the Console

When running a script without redirection, for example:

```pwsh
& '.\script_powershell.ps1'
```

some output may appears in a different order than the commands in the script.
For example:

- `Write-Host` messages may appear immediately.
- Output from cmdlets such as `Get-Variable` may appear later.
- Error messages may appear at the end of the output.

This happens because PowerShell uses multiple output streams:

- Stream 1: Success output, for example objects returned by `Get-Variable`.
- Stream 2: Error output, for example error records produced by cmdlets.
- Stream 6: Information output, including `Write-Host` messages.

These streams are buffered and rendered by the host independently.
In some environments, such as the VS Code integrated terminal,
the visual order of these streams may not match the exact order of commands in the script.

The script logic still executes sequentially from top to bottom.
Only the visual order of mixed output in the console can differ.

For more predictable visual order:

- Use `Format-List` or `Format-Table` to format object output explicitly.
- Use `try / catch` with `-ErrorAction Stop` to control how errors are handled and displayed.

When output is redirected to a file, for example with `*>&1 | Tee-Object`,
all streams are merged into a single text stream.
