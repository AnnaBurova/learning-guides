```text
Author: NewtCode Anna Burova
Created: 2024-06
Updated: 2026-11
```

# Create a Python Library

This guide introduces a small, installable Python package.

The accompanying starter files are in the
[dev-configs/new-python](https://github.com/AnnaBurova/dev-configs/tree/main/new-python)
directory.

## Project Structure Overview

A modern src-layout structure is recommended
to make the project easier to manage and avoid import issues.
This approach is the standard for Python packages.

Create the following directory structure:

```text
new-python/                       # Root repository
│
├── src/
│   └── package_name/             # Main Python package (module source)
│       ├── __init__.py           # Defines the package's public import interface
│       ├── __main__.py           # Optional entry point for `python -m package_name`
│       ├── docstring.py          # Example module with a documented function
│       ├── module.py             # Example module with a public function
│       └── (other modules)
│
├── tests/                        # Manual and automated test scripts
│   ├── README_TESTING.md         # Instructions for running tests across Python versions
│   ├── __init__.py               # Marks tests as a package
│   ├── test_module.py            # Tests for the module example
│   ├── test_module_function.py   # Tests for the function example
│   └── (other tests)
│
├── .gitignore                    # Excludes local environments, caches, and build output
├── LICENSE                       # Terms for using and distributing the package
├── CHANGELOG.md                  # Optional record of changes between releases
├── CONTRIBUTING.md               # Optional baseline for project contributions
├── INSTALLATION.md               # Local setup instructions
├── pyproject.toml                # Build configuration and package metadata
├── requirements.txt              # Convenience install for editable development
└── README.md                     # Project overview and first-use instructions
```

### Key Architectural Details:

- **The `src/` Layout**:
Using the dedicated `src` directory is considered a modern best practice.
It explicitly separates source code from configuration files and tests,
preventing common import ambiguities
(e.g., accidentally importing local test utilities into production code).

- **Package Naming Convention**:
The name chosen for the main package folder (`package_name`)
must consistently match the intended module
or import name used throughout the project.

- **`__init__.py` Role**:
This file marks a directory as a Python package.
While modern Python versions (3.12+) often handle this implicitly,
including `__init__.py` remains crucial for defining and exposing the public API of your module
(e.g., allowing users to import specific functions directly `from import package_name`).

### Requirements

Aim to support the modern versions Python versions:

- Python 3.15
- Python 3.14
- Python 3.13
- Python 3.12
- Python 3.11

The test suite should also run under each supported interpreter.
Version classifiers in `pyproject.toml` are metadata and should be kept in sync with this range.

Runtime dependencies belong in `[project].dependencies` in `pyproject.toml`.
The optional `test` dependency group contains tools needed only during development.

List dependencies in `requirements.txt`.

## Build and Publish Distribution Packages

### 1. Install build tools

These tools are used to build the package and upload it to PyPI.

Install the required tools:

```sh
python -m pip install --upgrade build twine setuptools wheel
```

### 2. Build the package

```sh
cd ./new-python/
python -m build
```
```output
OUTPUT:
Successfully built package_name-0.1.0.tar.gz and package_name-0.1.0-py3-none-any.whl
```

This creates distribution files in the `dist/` directory, including:
- a source archive (`.tar.gz`)
- a wheel (`.whl`)

### 3. Inspect the package

To inspect the contents of the source distribution without extracting:

```sh
tar -tzf dist/package_name-0.1.0.tar.gz
```
```output
OUTPUT:
package_name-0.1.0/src/package_name/__init__.py
package_name-0.1.0/src/package_name/__main__.py
package_name-0.1.0/src/package_name/docstring.py
package_name-0.1.0/src/package_name/module.py
package_name-0.1.0/.gitignore
package_name-0.1.0/LICENSE
package_name-0.1.0/README.md
package_name-0.1.0/pyproject.toml
package_name-0.1.0/PKG-INFO
```

This lists all files that will be included. Use this to verify:
- All necessary files are present (code, README, LICENSE)
- No unnecessary files are included (tests, `.git`, `.env`, etc.)

If you need to adjust which files are included, modify these settings in `pyproject.toml`:

```toml
[tool.hatch.build.targets.sdist]
only-include = []
exclude = []
```

To extract the archive for manual inspection:

```sh
tar -xzf dist/package_name-0.1.0.tar.gz
```

### 4. Validate the package

This helps catch common packaging issues, such as missing README rendering or invalid metadata.

```sh
python -m twine check dist/*
```
```output
OUTPUT:
Checking dist\package_name-0.1.0-py3-none-any.whl: PASSED
Checking dist\package_name-0.1.0.tar.gz: PASSED
```

## Test on TestPyPI (Recommended)

Before publishing to the main PyPI, test your package on the staging server.
This helps catch packaging errors without risking your package name.

### 1. Create a TestPyPI Account

1. Go to [test.pypi.org](https://test.pypi.org/).
2. **Register** an account or Log in.
3. Go to **Account Settings** -> **API Tokens**.
4. Create a new token with **Upload** scope.

**Copy the token immediately**.
You won't be able to see it again!
Save it in a password manager or secure note.

### 2. Upload Your Package to TestPyPI

```sh
cd ./new-python/
python -m twine upload --repository testpypi dist/*
```

Enter your API token when prompted.

### 3. Install and Test from TestPyPI

```sh
python -m pip install --index-url https://test.pypi.org/simple/ package_name
```

Verify that:
- The package installs without errors.
- All imports work: `import package_name`.
- Functions behave as expected.

## Publish to PyPI (Production)

Once testing is complete, publish to the main PyPI.

### 1. Create a PyPI Account

1. Go to [pypi.org](https://pypi.org/).
2. **Register** an account or Log in (same process as TestPyPI).
3. Go to **Account Settings** -> **API Tokens**.
4. Create a new token with **Upload** scope.

**Copy the token immediately**.
You won't be able to see it again!
Save it in a password manager or secure note.

### 2. Upload Your Package to PyPI

```sh
cd ./new-python/
python -m twine upload dist/*
```

When prompted, enter the PyPI API token.

### 3. Verify on PyPI

1. Visit your package page: [pypi.org/project/package_name/](https://pypi.org/project/package_name/)
2. Check that:
    - README renders correctly (no broken Markdown)
    - All metadata is correct (version, author, license)
    - Files are listed under **Download files**

### 4. Example Usage

Once the package is published, it can be installed with:

```sh
python -m pip install package_name
```
