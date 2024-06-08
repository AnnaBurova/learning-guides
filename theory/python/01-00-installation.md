```text
Created on 2024-06

@author: NewtCode Anna Burova

Python Setup: Versions, pip, and Virtual Environments
```

# Python Setup

## Python Install Manager for Windows

[https://www.python.org/downloads/windows/](https://www.python.org/downloads/windows/)

```pwsh
PS> WinGet search --id PythonInstallManager
PS> WinGet install --id Python.PythonInstallManager
```

## Status of Python Versions

[https://devguide.python.org/versions/](https://devguide.python.org/versions/)

| Version | Status      | End of life |
| ---     | ---         | ---         |
| 3.15    | bugfix      | 2031-10     |
| 3.14    | bugfix      | 2030-10     |
| 3.13    | security    | 2029-10     |
| 3.12    | security    | 2028-10     |
| 3.11    | security    | 2027-10     |
| 3.10    | end-of-life | 2026-10-01  |

## List of Available Python Versions

This command updates the manager if a new version is available,
and lists all Python versions available online.

```pwsh
PS> py list --online

Python install manager was successfully updated to 26.4.

Tag         Name             Managed By   Version   Alias
3.15[-64]   Python 3.15.0    PythonCore   3.15.0    python3[-64].exe, python3.15[-64].exe
3.14[-64]   Python 3.14.8    PythonCore   3.14.8    python3.14[-64].exe
3.13[-64]   Python 3.13.16   PythonCore   3.13.16   python3.13[-64].exe
3.12[-64]   Python 3.12.10   PythonCore   3.12.10   python3.12[-64].exe
3.11[-64]   Python 3.11.9    PythonCore   3.11.9    python3.11[-64].exe
```

All other versions not listed here are modified builds, test builds,
outdated versions, or are currently under development.

Check the locally installed versions with:

```pwsh
PS> py list

Tag   Name   Managed By   Version   Alias
-- No runtimes. Use 'py install <version>' to install one. --
```

## Install Python From Scratch

Works only if no default Python version is installed.

```pwsh
PS> python --version

********************************************************************************
The signature for https://www.python.org/ftp/python/index-windows.json was successfully verified.
Installing Python 3.15.0.
Downloading: ..................................................................✅
Extracting: ...................................................................✅
To see all available commands, run 'py help'
********************************************************************************
Python 3.15.0
```

Check the Python installation location, if needed:

```pwsh
PS> py list -f exe

C:\Users\UserName\AppData\Local\Python\pythoncore-3.15-64\python.exe
```

## Install Other Python Versions From Scratch

```pwsh
PS> py install 3.14

Installing Python 3.14.8.
Python 3.14.8 will be launched by python3.14[-64].exe

PS> py install 3.13

Installing Python 3.13.16.
Python 3.13.16 will be launched by python3.13[-64].exe

PS> py install 3.12

Installing Python 3.12.10.
Python 3.12.10 will be launched by python3.12[-64].exe

PS> py install 3.11

Installing Python 3.11.9.
Python 3.11.9 will be launched by python3.11[-64].exe
```

List of all locally installed Python versions:

```pwsh
PS> py list

Tag           Name            Managed By  Version  Alias
3.15[-64]  *  Python 3.15.0   PythonCore  3.15.0   python3[-64].exe, python3.15[-64].exe
3.14[-64]     Python 3.14.8   PythonCore  3.14.8   python3.14[-64].exe
3.13[-64]     Python 3.13.16  PythonCore  3.13.16  python3.13[-64].exe
3.12[-64]     Python 3.12.10  PythonCore  3.12.10  python3.12[-64].exe
3.11[-64]     Python 3.11.9   PythonCore  3.11.9   python3.11[-64].exe
```

## Check Installed Python Versions

```pwsh
PS> python --version

Python 3.15.0

PS> py -3.14 --version

Python 3.14.8

PS> py -3.13 --version

Python 3.13.16

PS> py -3.12 --version

Python 3.12.10

PS> py -3.11 --version

Python 3.11.9
```

## Update Installed Python Versions

```pwsh
PS> py install --update 3.15

Python 3.15.0 is already up to date.
Python 3.15.0 will be launched by python.exe and also python3[-64].exe, python3.15[-64].exe

PS> py install --update 3.14

Python 3.14.8 is already up to date.
Python 3.14.8 will be launched by python3.14[-64].exe

PS> py install --update 3.13

Python 3.13.16 is already up to date.
Python 3.13.16 will be launched by python3.13[-64].exe

PS> py install --update 3.12

Python 3.12.10 is already up to date.
Python 3.12.10 will be launched by python3.12[-64].exe

PS> py install --update 3.11

Python 3.11.9 is already up to date.
Python 3.11.9 will be launched by python3.11[-64].exe
```

## Uninstall a Single Python Version

```pwsh
PS> py uninstall 3.10

Uninstall Python 3.10.11? [Y/n]
Removed Python 3.10.11
```

## Uninstall All Python Versions

```pwsh
PS> deactivate
PS> py uninstall --purge

Uninstall all runtimes? [Y/n]
Purging Python 3.14.7  from C:\Users\UserName\AppData\Local\Python\pythoncore-3.14-64
Purging Python 3.13.15 from C:\Users\UserName\AppData\Local\Python\pythoncore-3.13-64
Purging Python 3.12.10 from C:\Users\UserName\AppData\Local\Python\pythoncore-3.12-64
Purging Python 3.11.9  from C:\Users\UserName\AppData\Local\Python\pythoncore-3.11-64
Purging saved downloads from C:\Users\UserName\AppData\Local\Python\_cache
Removing global commands directory from PATH
Purging global commands from C:\Users\UserName\AppData\Local\Python\bin
Purging all shortcuts
```

# Python Virtual Environments (`.venv`)

## Create Virtual Environments

```pwsh
PS> py -3.15 -m venv .venv315
PS> py -3.14 -m venv .venv314
PS> py -3.13 -m venv .venv313
PS> py -3.12 -m venv .venv312
PS> py -3.11 -m venv .venv311
```

On Linux:

```bash
$ python3 -m venv .venvLinux312
```

## Activate Virtual Environments

```pwsh
PS> (Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned) ; (& 'D:\VS_Code\.venv315\Scripts\Activate.ps1')
PS> (Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned) ; (& 'D:\VS_Code\.venv314\Scripts\Activate.ps1')
PS> (Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned) ; (& 'D:\VS_Code\.venv313\Scripts\Activate.ps1')
PS> (Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned) ; (& 'D:\VS_Code\.venv312\Scripts\Activate.ps1')
PS> (Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned) ; (& 'D:\VS_Code\.venv311\Scripts\Activate.ps1')

& 'D:\VS_Code\.venv315\Scripts\Activate.ps1'
& 'D:\VS_Code\.venv314\Scripts\Activate.ps1'
& 'D:\VS_Code\.venv313\Scripts\Activate.ps1'
& 'D:\VS_Code\.venv312\Scripts\Activate.ps1'
& 'D:\VS_Code\.venv311\Scripts\Activate.ps1'
```

On Linux:

```bash
$ source .venvLinux312/bin/activate
```

## Alias Command Context

| Context | Default | Explicit version | Virtual environment |
| --- | --- | --- | --- |
| Global default | `python -m` | `py -3.15 -m` | X |
| `.venv315` | `python -m` | `py -3.15 -m` | `& '.\.venv315\Scripts\python.exe' -m` |
| `.venv314` | `python -m` | `py -3.14 -m` | `& '.\.venv314\Scripts\python.exe' -m` |
| `.venv313` | `python -m` | `py -3.13 -m` | `& '.\.venv313\Scripts\python.exe' -m` |
| `.venv312` | `python -m` | `py -3.12 -m` | `& '.\.venv312\Scripts\python.exe' -m` |
| `.venv311` | `python -m` | `py -3.11 -m` | `& '.\.venv311\Scripts\python.exe' -m` |

## Deactivate Virtual Environment

```pwsh
PS> deactivate
```

# Packages and pip

## Update pip Package Manager

```pwsh
PS> deactivate

# Default global latest version, for example 3.15
PS> python -m pip install --upgrade pip

Collecting pip
Installing collected packages: pip
  Attempting uninstall: pip
    Found existing installation: pip 24.0
    Uninstalling pip-24.0:
      Successfully uninstalled pip-24.0
Successfully installed pip-26.2.1
```

Since each global Python installation and each virtual environment has its own pip,
use the following commands instead:

```pwsh
# Upgrade pip globally for each installed Python version
PS> py -3.15 -m pip install --upgrade pip
PS> py -3.14 -m pip install --upgrade pip
PS> py -3.13 -m pip install --upgrade pip
PS> py -3.12 -m pip install --upgrade pip
PS> py -3.11 -m pip install --upgrade pip

# Upgrade pip separately inside each existing virtual environment
PS> & '.\.venv315\Scripts\python.exe' -m pip install --upgrade pip
PS> & '.\.venv314\Scripts\python.exe' -m pip install --upgrade pip
PS> & '.\.venv313\Scripts\python.exe' -m pip install --upgrade pip
PS> & '.\.venv312\Scripts\python.exe' -m pip install --upgrade pip
PS> & '.\.venv311\Scripts\python.exe' -m pip install --upgrade pip

Requirement already satisfied: pip in .\.venv315\Lib\site-packages (26.2.1)
```

## List of Installed Packages

```pwsh
PS> pip list

Package Version
------- -------
pip     26.2.1
```

OR in each global Python installation and virtual environment separately:

```pwsh
PS> py -3.15 -m pip list
PS> py -3.14 -m pip list
PS> py -3.13 -m pip list
PS> py -3.12 -m pip list
PS> py -3.11 -m pip list
PS> & '.\.venv315\Scripts\python.exe' -m pip list
PS> & '.\.venv314\Scripts\python.exe' -m pip list
PS> & '.\.venv313\Scripts\python.exe' -m pip list
PS> & '.\.venv312\Scripts\python.exe' -m pip list
PS> & '.\.venv311\Scripts\python.exe' -m pip list
```

## Install Packages

Do not install packages globally unless necessary.
Activate the selected virtual environment first.

```pwsh
PS> pip install pytest
```

OR in each virtual environment separately:

```pwsh
PS> & '.\.venv315\Scripts\python.exe' -m pip install pytest
PS> & '.\.venv314\Scripts\python.exe' -m pip install pytest
PS> & '.\.venv313\Scripts\python.exe' -m pip install pytest
PS> & '.\.venv312\Scripts\python.exe' -m pip install pytest
PS> & '.\.venv311\Scripts\python.exe' -m pip install pytest
```

## Uninstall a Single Package

```pwsh
PS> pip uninstall pytest
```

## Uninstall All Packages

(Optional but recommended):
Open `to_delete.txt` and remove core packages such as `pip`, `setuptools`, or `wheel`
to avoid breaking your environment.

```pwsh
PS> pip freeze > to_delete.txt
PS> pip uninstall -y -r to_delete.txt
```

OR in each virtual and global environment separately:

```pwsh
PS> & '.\.venv315\Scripts\python.exe' -m pip freeze > '.\to_delete.txt'
PS> & '.\.venv315\Scripts\python.exe' -m pip uninstall -y -r '.\to_delete.txt'

PS> & '.\.venv314\Scripts\python.exe' -m pip freeze > '.\to_delete.txt'
PS> & '.\.venv314\Scripts\python.exe' -m pip uninstall -y -r '.\to_delete.txt'

PS> & '.\.venv313\Scripts\python.exe' -m pip freeze > '.\to_delete.txt'
PS> & '.\.venv313\Scripts\python.exe' -m pip uninstall -y -r '.\to_delete.txt'

PS> & '.\.venv312\Scripts\python.exe' -m pip freeze > '.\to_delete.txt'
PS> & '.\.venv312\Scripts\python.exe' -m pip uninstall -y -r '.\to_delete.txt'

PS> & '.\.venv311\Scripts\python.exe' -m pip freeze > '.\to_delete.txt'
PS> & '.\.venv311\Scripts\python.exe' -m pip uninstall -y -r '.\to_delete.txt'

PS> py -3.15 -m pip freeze > '.\to_delete.txt'
PS> py -3.15 -m pip uninstall -y -r '.\to_delete.txt'

PS> py -3.14 -m pip freeze > '.\to_delete.txt'
PS> py -3.14 -m pip uninstall -y -r '.\to_delete.txt'

PS> py -3.13 -m pip freeze > '.\to_delete.txt'
PS> py -3.13 -m pip uninstall -y -r '.\to_delete.txt'

PS> py -3.12 -m pip freeze > '.\to_delete.txt'
PS> py -3.12 -m pip uninstall -y -r '.\to_delete.txt'

PS> py -3.11 -m pip freeze > '.\to_delete.txt'
PS> py -3.11 -m pip uninstall -y -r '.\to_delete.txt'
```
