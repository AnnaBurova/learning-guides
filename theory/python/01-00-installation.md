```text
Author: NewtCode Anna Burova
Created: 2024-06
Updated: 2026-11
```

# Python Setup: Versions, pip, and venv

The guide is a point-in-time reference.

This guide covers Windows with PowerShell and the Python Install Manager.
Follow the manual steps, verify each result, and use the optional PowerShell helper scripts.
The scripts automate repeated steps across Python versions;
they are optional and do not replace reviewing the commands and results.

The examples assume commands are run from the directory containing this repository.
Python 3.15 is installed separately using the Python Install Manager;
the installation helper installs Python 3.11 through 3.14.
The update, virtual-environment, pip, and package helpers include Python 3.15
because those operations use an already-installed runtime.

## Install the Python Install Manager for Windows

https://www.python.org/downloads/windows/

```sh
WinGet search --id PythonInstallManager
WinGet install --id Python.PythonInstallManager
```

## Status of Python Versions

https://devguide.python.org/versions/

Check the linked page for current release status and end-of-life dates.

| Version | Status      | End of life |
| ---     | ---         | ---         |
| 3.15    | bugfix      | 2031-10     |
| 3.14    | bugfix      | 2030-10     |
| 3.13    | security    | 2029-10     |
| 3.12    | security    | 2028-10     |
| 3.11    | security    | 2027-10     |
| 3.10    | end-of-life | 2026-10     |

## List of Available Python Versions

This command updates the manager if a new version is available and
lists all Python versions available online.

```sh
py list --online
```
```output
OUTPUT:
Python install manager was successfully updated to 26.4.

Tag         Name             Managed By   Version   Alias
3.15[-64]   Python 3.15.2    PythonCore   3.15.2    python3.15[-64].exe
3.14[-64]   Python 3.14.10   PythonCore   3.14.10   python3.14[-64].exe
3.13[-64]   Python 3.13.17   PythonCore   3.13.17   python3.13[-64].exe
3.12[-64]   Python 3.12.10   PythonCore   3.12.10   python3.12[-64].exe
3.11[-64]   Python 3.11.9    PythonCore   3.11.9    python3.11[-64].exe
```

All other versions not listed here are modified builds, test builds,
obsolete versions, or variants currently under development.

Check the locally installed versions with:

```sh
py list
```
```output
OUTPUT:
Tag   Name   Managed By   Version   Alias
-- No runtimes. Use 'py install <version>' to install one. --
```

## Install the Default Python Version from Scratch

If no Python runtime is installed,
running `python --version` prompts the Python Install Manager
to install its default version.

```sh
python --version
```
```output
OUTPUT:
********************************************************************************
The signature for https://www.python.org/ftp/python/index-windows.json was successfully verified.
Installing Python 3.15.2.
Downloading: ..................................................................✅
Extracting: ...................................................................✅
To see all available commands, run 'py help'
********************************************************************************
Python 3.15.2
```

Check the Python installation location, if needed:

```sh
py list -f exe
```
```output
OUTPUT:
C:\Users\USER_NAME\AppData\Local\Python\pythoncore-3.15-64\python.exe
```

The global shortcuts directory may not be on `PATH`.
Add it to access Python aliases directly from PowerShell:

`C:\Users\USER_NAME\AppData\Local\Python\bin`

## Install Other Python Versions

Python 3.15 was installed manually in the previous section.

Install the other versions manually, one at a time,
or run the helper to repeat the installation of Python 3.11 through 3.14
and verify the installed versions:

> Optional helper: [01-01-install-python-versions.ps1](./01-01-install-python-versions.ps1)

```sh
py install 3.14
```
```output
OUTPUT:
Installing Python 3.14.10.
```

---

```sh
py install 3.13
```
```output
OUTPUT:
Installing Python 3.13.17.
Python 3.13.17 will be launched by python3.13[-64].exe
```

---

```sh
py install 3.12
```
```output
OUTPUT:
Installing Python 3.12.10.
Python 3.12.10 will be launched by python3.12[-64].exe
```

---

```sh
py install 3.11
```
```output
OUTPUT:
Installing Python 3.11.9.
Python 3.11.9 will be launched by python3.11[-64].exe
```

---

After all installations succeed, verify them:

```sh
py list
```
```output
OUTPUT:
Tag           Name            Managed By  Version  Alias
3.15[-64]  *  Python 3.15.2   PythonCore  3.15.2   python3[-64].exe, python3.15[-64].exe
3.14[-64]     Python 3.14.10  PythonCore  3.14.10  python3.14[-64].exe
3.13[-64]     Python 3.13.17  PythonCore  3.13.17  python3.13[-64].exe
3.12[-64]     Python 3.12.10  PythonCore  3.12.10  python3.12[-64].exe
3.11[-64]     Python 3.11.9   PythonCore  3.11.9   python3.11[-64].exe
```

---

```sh
python --version
```
```output
OUTPUT:
Python 3.15.2
```

---

```sh
py -3.14 --version
```
```output
OUTPUT:
Python 3.14.10
```

---

```sh
py -3.13 --version
```
```output
OUTPUT:
Python 3.13.17
```

---

```sh
py -3.12 --version
```
```output
OUTPUT:
Python 3.12.10
```

---

```sh
py -3.11 --version
```
```output
OUTPUT:
Python 3.11.9
```

## Update Installed Python Versions

Update each installed version manually and confirm the output,
or run the helper to update all five Python versions:

> Optional helper: [01-02-update-python-versions.ps1](./01-02-update-python-versions.ps1)

```sh
py install --update 3.15
```
```output
OUTPUT:
Python 3.15.2 is already up to date.
Python 3.15.2 will be launched by python.exe and also python3[-64].exe, python3.15[-64].exe
```

---

```sh
py install --update 3.14
```
```output
OUTPUT:
Python 3.14.10 is already up to date.
Python 3.14.10 will be launched by python3.14[-64].exe
```

---

```sh
py install --update 3.13
```
```output
OUTPUT:
Python 3.13.17 is already up to date.
Python 3.13.17 will be launched by python3.13[-64].exe
```

---

```sh
py install --update 3.12
```
```output
OUTPUT:
Python 3.12.10 is already up to date.
Python 3.12.10 will be launched by python3.12[-64].exe
```

---

```sh
py install --update 3.11
```
```output
OUTPUT:
Python 3.11.9 is already up to date.
Python 3.11.9 will be launched by python3.11[-64].exe
```

## Uninstall a Single Python Version

```sh
py uninstall 3.10
```
```output
OUTPUT:
Uninstall Python 3.10.11? [Y/n]
Removed Python 3.10.11
```

## Uninstall All Python Versions

This removes all managed Python runtimes, including the manually installed Python 3.15.

```sh
# If in Virtual Environment
deactivate
```
```sh
py uninstall --purge
```
```output
OUTPUT:
Uninstall all runtimes? [Y/n]
Purging Python 3.15.2  from C:\Users\USER_NAME\AppData\Local\Python\pythoncore-3.15-64
Purging Python 3.14.7  from C:\Users\USER_NAME\AppData\Local\Python\pythoncore-3.14-64
Purging Python 3.13.15 from C:\Users\USER_NAME\AppData\Local\Python\pythoncore-3.13-64
Purging Python 3.12.10 from C:\Users\USER_NAME\AppData\Local\Python\pythoncore-3.12-64
Purging Python 3.11.9  from C:\Users\USER_NAME\AppData\Local\Python\pythoncore-3.11-64
Purging saved downloads from C:\Users\USER_NAME\AppData\Local\Python\_cache
Purging global commands from C:\Users\USER_NAME\AppData\Local\Python\bin
Purging all shortcuts
```

## Create Virtual Environments (`.venv`)

Create and verify each environment manually,
or run the helper to create them automatically:

> Optional helper: [01-03-create-virtual-environments.ps1](./01-03-create-virtual-environments.ps1)

Run the helper from the workspace directory where the `.venv*` directories
should be created.

```sh
py -3.15 -m venv .venv315
py -3.14 -m venv .venv314
py -3.13 -m venv .venv313
py -3.12 -m venv .venv312
py -3.11 -m venv .venv311
```

## Activate Virtual Environments

Run the activation command for the environment,
changing `.venv315` to the corresponding environment name.
The process-scoped execution policy change applies only to the current PowerShell session.

```pwsh
(Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned) ; (& 'D:\VS_Code\.venv315\Scripts\Activate.ps1')
```

OR

```pwsh
# Required to activate the Python venv in a new terminal
# Allows running local PowerShell scripts in the current terminal session only
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned

& 'D:\VS_Code\.venv315\Scripts\Activate.ps1'
& 'D:\VS_Code\.venv314\Scripts\Activate.ps1'
& 'D:\VS_Code\.venv313\Scripts\Activate.ps1'
& 'D:\VS_Code\.venv312\Scripts\Activate.ps1'
& 'D:\VS_Code\.venv311\Scripts\Activate.ps1'
```

## Deactivate a Virtual Environment

```sh
deactivate
```

## Work with Packages and pip

The scripts `pip.exe`, `pip3.15.exe`, and `pip3.exe`
are installed in the corresponding `Scripts` directories:

`C:\Users\USER_NAME\AppData\Local\Python\pythoncore-3.15-64\Scripts`

`C:\Users\USER_NAME\AppData\Local\Python\pythoncore-3.14-64\Scripts`

`C:\Users\USER_NAME\AppData\Local\Python\pythoncore-3.13-64\Scripts`

`C:\Users\USER_NAME\AppData\Local\Python\pythoncore-3.12-64\Scripts`

`C:\Users\USER_NAME\AppData\Local\Python\pythoncore-3.11-64\Scripts`

These directories may not be on `PATH`.

Add the appropriate `Scripts` directory to `PATH`,
but using `python -m pip` or `py -<version> -m pip` avoids relying on that path.

## Upgrade pip Package Manager

Deactivate any active virtual environment,
then update pip manually in each global Python installation and virtual environment,
or run the helper:

> Optional helper: [01-04-upgrade-pip.ps1](./01-04-upgrade-pip.ps1)

```sh
py -3.15 -m pip install --upgrade pip
py -3.14 -m pip install --upgrade pip
py -3.13 -m pip install --upgrade pip
py -3.12 -m pip install --upgrade pip
py -3.11 -m pip install --upgrade pip
```
```pwsh
& '.\.venv315\Scripts\python.exe' -m pip install --upgrade pip
& '.\.venv314\Scripts\python.exe' -m pip install --upgrade pip
& '.\.venv313\Scripts\python.exe' -m pip install --upgrade pip
& '.\.venv312\Scripts\python.exe' -m pip install --upgrade pip
& '.\.venv311\Scripts\python.exe' -m pip install --upgrade pip
```
```output
OUTPUT:
Collecting pip
  Using cached pip-26.3-py3-none-any.whl.metadata (4.6 kB)
Using cached pip-26.3-py3-none-any.whl (2.0 MB)
Installing collected packages: pip
  Attempting uninstall: pip
    Found existing installation: pip 26.2.2
    Uninstalling pip-26.2.2:
      Successfully uninstalled pip-26.2.2
Successfully installed pip-26.3
```

## List of Installed Packages

List packages manually in each global Python installation and virtual environment,
or run the helper to list packages for all five Python versions and their virtual environments:

> Optional helper: [01-05-list-pip-packages.ps1](./01-05-list-pip-packages.ps1)

```sh
py -3.15 -m pip list
py -3.14 -m pip list
py -3.13 -m pip list
py -3.12 -m pip list
py -3.11 -m pip list
```
```pwsh
& '.\.venv315\Scripts\python.exe' -m pip list
& '.\.venv314\Scripts\python.exe' -m pip list
& '.\.venv313\Scripts\python.exe' -m pip list
& '.\.venv312\Scripts\python.exe' -m pip list
& '.\.venv311\Scripts\python.exe' -m pip list
```

## Install Packages

Avoid installing packages globally unless necessary.

Activate the virtual environment before installing a package:

```pwsh
& 'D:\VS_Code\.venv315\Scripts\Activate.ps1'
```
```sh
python -m pip install pytest
```

Or install the package directly into the chosen environment without activating it:

```pwsh
& '.\.venv315\Scripts\python.exe' -m pip install pytest
& '.\.venv314\Scripts\python.exe' -m pip install pytest
& '.\.venv313\Scripts\python.exe' -m pip install pytest
& '.\.venv312\Scripts\python.exe' -m pip install pytest
& '.\.venv311\Scripts\python.exe' -m pip install pytest
```

For scripted installation, the optional helper repeats the `pytest` package installation
in all five virtual environments:

> Optional helper: [01-06-install-package.ps1](./01-06-install-package.ps1)

The helper is configured to install `pytest`;
edit `$PackageName` in the script to install a different package.

## Uninstall a Single Package

With the intended virtual environment active, uninstall one package:

```sh
python -m pip uninstall pytest
```

## Uninstall All Packages

To uninstall packages from one active virtual environment manually,
first create a package list and review it.
To keep core tools such as `pip`, `setuptools`, or `wheel`, remove their entries from the list:

```sh
python -m pip freeze > 'uninstall_packages.txt'
python -m pip uninstall -r 'uninstall_packages.txt'
```

For a global Python installation, use the matching version-specific commands:

```sh
py -3.15 -m pip freeze > 'uninstall_packages_python315.txt'
py -3.15 -m pip uninstall -r 'uninstall_packages_python315.txt'
```

Repeat with each installed Python version that needs cleanup.

For the five virtual environments, first perform the equivalent manual steps
for each environment and review each package list.

The optional helper removes every package reported by `pip freeze`
without applying additional package filters.
It processes all five global Python installations and all five virtual environments.
nlike the manual steps, it does not pause for review before uninstalling;
t creates package-list files in the current directory and uninstalls their contents automatically.

> Optional helper: [01-07-uninstall-non-core-packages.ps1](./01-07-uninstall-non-core-packages.ps1)

## Quick reference for WSL

```sh
wsl --status
wsl --version
wsl --list --verbose
wsl --install --no-distribution
wsl --install -d Ubuntu
```

---

```bash
sudo apt update
sudo apt install python3 python3-pip
```

---

```bash
python3 --version
```
```output
OUTPUT:
Python 3.14.4
```

---

```bash
pip3 --version
```
```output
OUTPUT:
pip 25.1.1 from /usr/lib/python3/dist-packages/pip (python 3.14)
```

---

```bash
sudo apt install python3-venv
python3 -m venv .venvWSL314
source .venvWSL314/bin/activate
python3 -m pip install pytest
python3 -m pip freeze > 'uninstall_packages.txt'
```
