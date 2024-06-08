```text
Created on 2024-06

@author: NewtCode Anna Burova
```

# Create a Python Library from Scratch

## Project Structure

Create the following directory structure:

```text
dev-library/              # Root repository
│
├── src/
│   └── library/          # Main Python package (module source)
│       ├── __init__.py
│       ├── module.py
│       └── (other files)
│
├── tests/                # Manual and automated test scripts
│   │
│   ├── TESTING.md        # Test documentation and instructions
│   ├── __init__.py       # Marks tests as a package
│   ├── test_module.py
│   ├── test_*.py         # Pytest test scripts for modules
│   ├── test_*_*.py       # Pytest test scripts for functions
│   └── (other test scripts)
│
├── LICENSE               # License file
├── pyproject.toml        # Build system configuration and project metadata
├── requirements.txt      # Project dependencies
└── README.md             # Project overview and usage instructions
```

**Key points:**

- The `src/` layout is the modern standard. It prevents import issues during development.
- `__init__.py` makes the directory a Python package. Can be empty or export functions.
- `pyproject.toml` is the main configuration file for build tools and metadata.

## Requirements

Try to support the following Python versions:

- Python 3.15
- Python 3.14
- Python 3.13
- Python 3.12
- Python 3.11

Other dependencies list in `requirements.txt`.

## Examples of Library Code

[github.com/AnnaBurova/dev-configs/new-python/](https://github.com/AnnaBurova/dev-configs/blob/main/new-python/)

- pyproject.toml
- src/library/__init__.py
- src/library/docstring.py = module.py

## Build Distribution Packages

Install build tools:

```pwsh
PS> pip install build twine
```

Build the package:

```pwsh
PS> cd dev-library/
PS> python -m build

Successfully built dev_library-0.1.0.tar.gz and dev_library-0.1.0-py3-none-any.whl
```

This creates `.tar.gz` (source distribution) and `.whl` (wheel) files in the `dist/` directory.

To inspect the contents of the source distribution without extracting:

```pwsh
PS> tar -tzf dist/dev_library-0.1.0.tar.gz
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

```pwsh
PS> tar -xzf dist/dev_library-0.1.0.tar.gz
```

## Test on TestPyPI (Recommended)

Before publishing to the main PyPI, test your package on the staging server.
This helps catch packaging errors without risking your package name.

### Step 1: Create a TestPyPI Account

1. Go to [test.pypi.org](https://test.pypi.org/).

2. **Register** an account or Log in.

3. Go to **Account Settings** -> **API Tokens**.

4. Create a new token with **Upload** scope.

**Copy the token immediately**.
You won't be able to see it again!
Save it in a password manager or secure note.

### Step 2: Upload Your Package to TestPyPI

```pwsh
PS> cd dev-library/
PS> twine upload --repository testpypi dist/*
```

Enter your API token when prompted.

### Step 3: Install and Test from TestPyPI

```pwsh
PS> pip install --index-url https://test.pypi.org/simple/ library
```

Verify that:
- The package installs without errors.
- All imports work: `import library`.
- Functions behave as expected.

## Publish to PyPI (Production)

Once testing is complete, publish to the main PyPI.

### Step 1: Create a PyPI Account

1. Go to [pypi.org](https://pypi.org/).

2. **Register** an account or Log in (same process as TestPyPI).

3. Go to **Account Settings** -> **API Tokens**.

4. Create a new token with **Upload** scope.

**Copy the token immediately**.
You won't be able to see it again!
Save it in a password manager or secure note.

### Step 2: Upload Your Package to PyPI

```pwsh
PS> cd dev-library/
PS> twine upload dist/*
```

Enter your API token when prompted.

### Step 3: Verify on PyPI

1. Visit your package page: [pypi.org/project/dev-library/](https://pypi.org/project/dev-library/)

2. Check that:
    - README renders correctly (no broken Markdown)
    - All metadata is correct (version, author, license)
    - Files are listed under **Download files**

### Step 4: Install from PyPI

Anyone can now install your package:

```pwsh
PS> pip install library
```
