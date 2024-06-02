# Python installation

## Python install manager for Windows

https://www.python.org/downloads/windows/

```shell
$ WinGet search --id PythonInstallManager
$ WinGet install --id Python.PythonInstallManager
```

## Status of Python versions

https://devguide.python.org/versions/

Version   Status        End of life   Security     Bugfix
3.9       end-of-life   2025-10-31
3.10      security      2026-10 (soon)
3.11      security      2027-10
3.12      security      2028-10
3.13      bugfix        2029-10       2026-10-06 (soon)
3.14      bugfix        2030-10       2027-10-05
3.15      prerelease    2031-10                    2026-10-01 (soon)

## List of Python Versions

This command
Updates manager if a new version is available, and
Lists all available online versions of Python.

```shell
$ py list --online

Python install manager was successfully updated to 26.3.

3.14[-64]   Python 3.14.7    PythonCore   3.14.7    python3.14-64.exe
3.13[-64]   Python 3.13.15   PythonCore   3.13.15   python3.13-64.exe
3.12[-64]   Python 3.12.10   PythonCore   3.12.10   python3.12-64.exe
3.11[-64]   Python 3.11.9    PythonCore   3.11.9    python3.11-64.exe
3.10[-64]   Python 3.10.11   PythonCore   3.10.11   python3.10.exe
```

All other versions not listed here are modifications, test builds,
outdated versions, or are currently under development.

## Install Python from scratch

Only if no default python version exists!

Both options are equally effective.

```shell
$ python
$ python --version

********************************************************************************
The signature for https://www.python.org/ftp/python/index-windows.json was successfully verified.
Installing Python 3.14.7.
Downloading: ..................................................................✅
Extracting: ...................................................................✅
To see all available commands, run 'py help'
********************************************************************************
Python 3.14.7
```

Check python location, if needed:

```shell
$ py -0p
-V:3.14[-64]  *  C:\Users\UserName\AppData\Local\Python\pythoncore-3.14-64\python.exe
```

The configuration of the PATH variable:

```shell
$ where python
# I have it empty

$ where py
# I have it empty
```

## Installing other versions of Python

```shell
$ py install 3.13
Installing Python 3.13.15.

$ py install 3.12
Installing Python 3.12.10.

$ py install 3.11
Installing Python 3.11.9.

$ py install 3.10
Installing Python 3.10.11.
```

List of all local installed python versions:

```shell
$ py list

Tag           Name            Managed By  Version  Alias
3.14[-64]  *  Python 3.14.7   PythonCore  3.14.7   python3[-64].exe, python3.14[-64].exe
3.13[-64]     Python 3.13.15  PythonCore  3.13.15  python3.13[-64].exe
3.12[-64]     Python 3.12.10  PythonCore  3.12.10  python3.12[-64].exe
3.11[-64]     Python 3.11.9   PythonCore  3.11.9   python3.11[-64].exe
3.10[-64]     Python 3.10.11  PythonCore  3.10.11  python3.10.exe
```

## Check installed Python versions

```shell
$ python --version
Python 3.14.7

$ py -3.14 --version
Python 3.14.7

$ py -3.13 --version
Python 3.13.15

$ py -3.12 --version
Python 3.12.10

$ py -3.11 --version
Python 3.11.9

$ py -3.10 --version
Python 3.10.11
```

# Environments

## Prepare environments

```shell
$ py -3.14 -m venv .venv314
$ py -3.13 -m venv .venv313
$ py -3.12 -m venv .venv312
$ py -3.11 -m venv .venv311
$ py -3.10 -m venv .venv310
```

On Linux:

```shell
$ python3 -m venv .venvLinux312
```

## Activate environments

```shell
$ (Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned) ; (& d:\VS_Code\.venv314\Scripts\Activate.ps1)
$ (Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned) ; (& d:\VS_Code\.venv313\Scripts\Activate.ps1)
$ (Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned) ; (& d:\VS_Code\.venv312\Scripts\Activate.ps1)
$ (Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned) ; (& d:\VS_Code\.venv311\Scripts\Activate.ps1)
$ (Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned) ; (& d:\VS_Code\.venv310\Scripts\Activate.ps1)
```

On Linux:

```shell
$ source .venvLinux312/bin/activate
```

## Deactivate environment

```shell
$ deactivate
```

## Uninstall single environment

```shell
$ py uninstall 3.14
```

## Uninstall all environments

```shell
$ deactivate
$ py uninstall --purge

Uninstall all runtimes? [Y/n] Y
Purging Python 3.14.4  from C:\Users\UserName\AppData\Local\Python\pythoncore-3.14-64
Purging Python 3.13.13 from C:\Users\UserName\AppData\Local\Python\pythoncore-3.13-64
Purging Python 3.12.10 from C:\Users\UserName\AppData\Local\Python\pythoncore-3.12-64
Purging Python 3.11.9  from C:\Users\UserName\AppData\Local\Python\pythoncore-3.11-64
Purging Python 3.10.11 from C:\Users\UserName\AppData\Local\Python\pythoncore-3.10-64
Purging saved downloads from C:\Users\UserName\AppData\Local\Python\_cache
Purging global commands from C:\Users\UserName\AppData\Local\Python\bin
Purging all shortcuts
```

# Packages pip

## Update pip package manager

### Localy in .venv

```shell
$ .\.venv314\Scripts\Activate.ps1
$ python -m pip install --upgrade pip

$ .\.venv313\Scripts\Activate.ps1
$ python -m pip install --upgrade pip

$ .\.venv312\Scripts\Activate.ps1
$ python -m pip install --upgrade pip

$ .\.venv311\Scripts\Activate.ps1
$ python -m pip install --upgrade pip

$ .\.venv310\Scripts\Activate.ps1
$ python -m pip install --upgrade pip

Collecting pip
Installing collected packages: pip
Successfully installed pip-26.2.1
```

### Globaly

```shell
# Default
$ python -m pip install --upgrade pip

$ py -3.14 -m pip install --upgrade pip
$ py -3.13 -m pip install --upgrade pip
$ py -3.12 -m pip install --upgrade pip
$ py -3.11 -m pip install --upgrade pip
$ py -3.10 -m pip install --upgrade pip
```

## pip lists

```shell
$ pip list

Package Version
------- -------
pip     26.2.1
```

### Localy in .venv

```shell
$ .\.venv314\Scripts\python.exe -m pip list
$ .\.venv313\Scripts\python.exe -m pip list
$ .\.venv312\Scripts\python.exe -m pip list
$ .\.venv311\Scripts\python.exe -m pip list
$ .\.venv310\Scripts\python.exe -m pip list
```

### Globaly

```shell
$ deactivate

# Default
$ python -m pip list

$ py -3.14 -m pip list
$ py -3.13 -m pip list
$ py -3.12 -m pip list
$ py -3.11 -m pip list
$ py -3.10 -m pip list
```

## Install packages in each environment

```shell
$ pip install pytest
```

### Localy in .venv

```shell
$ .\.venv314\Scripts\python.exe -m pip install pytest
$ .\.venv313\Scripts\python.exe -m pip install pytest
$ .\.venv312\Scripts\python.exe -m pip install pytest
$ .\.venv311\Scripts\python.exe -m pip install pytest
$ .\.venv310\Scripts\python.exe -m pip install pytest
```

### Globaly

```shell
# Default
$ python -m pip install pytest

$ py -3.14 -m pip install pytest
$ py -3.13 -m pip install pytest
$ py -3.12 -m pip install pytest
$ py -3.11 -m pip install pytest
$ py -3.10 -m pip install pytest
```

## Uninstalling single package from an environment

```shell
$ pip uninstall pytest
```

## Uninstalling all packages from an environment

(Optional but Recommended):
Open to_delete.txt and remove core packages like pip, setuptools, or wheel
to avoid breaking your environment.

```shell
$ pip freeze > to_delete.txt
$ pip uninstall -y -r to_delete.txt
```

### Localy in .venv

```shell
$ .\.venv314\Scripts\python.exe -m pip freeze > to_delete.txt
$ .\.venv314\Scripts\python.exe -m pip uninstall -y -r to_delete.txt
$ .\.venv313\Scripts\python.exe -m pip freeze > to_delete.txt
$ .\.venv313\Scripts\python.exe -m pip uninstall -y -r to_delete.txt
$ .\.venv312\Scripts\python.exe -m pip freeze > to_delete.txt
$ .\.venv312\Scripts\python.exe -m pip uninstall -y -r to_delete.txt
$ .\.venv311\Scripts\python.exe -m pip freeze > to_delete.txt
$ .\.venv311\Scripts\python.exe -m pip uninstall -y -r to_delete.txt
$ .\.venv310\Scripts\python.exe -m pip freeze > to_delete.txt
$ .\.venv310\Scripts\python.exe -m pip uninstall -y -r to_delete.txt
```

### Globaly

```shell
# Default
$ python -m pip freeze > to_delete.txt
$ python -m pip uninstall -y -r to_delete.txt

$ py -3.14 -m pip freeze > to_delete.txt
$ py -3.14 -m pip uninstall -y -r to_delete.txt
$ py -3.13 -m pip freeze > to_delete.txt
$ py -3.13 -m pip uninstall -y -r to_delete.txt
$ py -3.12 -m pip freeze > to_delete.txt
$ py -3.12 -m pip uninstall -y -r to_delete.txt
$ py -3.11 -m pip freeze > to_delete.txt
$ py -3.11 -m pip uninstall -y -r to_delete.txt
$ py -3.10 -m pip freeze > to_delete.txt
$ py -3.10 -m pip uninstall -y -r to_delete.txt
```
