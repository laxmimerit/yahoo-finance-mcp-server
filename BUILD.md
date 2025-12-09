# Build and Publish Guide

This guide explains how to build and publish the Yahoo Finance MCP Server package.

## Building the Package

### Prerequisites

1. Install uv:
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh  # macOS/Linux
```

2. Install build dependencies:
```bash
uv pip install build twine hatchling
```

### Build Steps

1. Clean previous builds:
```bash
rm -rf dist/ build/ *.egg-info
```

2. Build the package:
```bash
python -m build
```

Or with uv:
```bash
uv build
```

This creates two files in the `dist/` directory:
- `yahoo_finance_mcp_server-0.1.0-py3-none-any.whl` (wheel)
- `yahoo_finance_mcp_server-0.1.0.tar.gz` (source distribution)

### Verify the Build

1. Check package contents:
```bash
tar -tzf dist/yahoo_finance_mcp_server-0.1.0.tar.gz
```

2. Install locally to test:
```bash
uv pip install dist/yahoo_finance_mcp_server-0.1.0-py3-none-any.whl
```

3. Test the installation:
```bash
yahoo-finance-mcp-server --help
python -m yahoo_finance_mcp_server.server
```

## Publishing to PyPI

### Prerequisites

1. Create accounts:
   - PyPI (production): https://pypi.org/account/register/
   - TestPyPI (testing): https://test.pypi.org/account/register/

2. Create API tokens:
   - PyPI: https://pypi.org/manage/account/token/
   - TestPyPI: https://test.pypi.org/manage/account/token/

3. Configure credentials in `~/.pypirc`:
```ini
[distutils]
index-servers =
    pypi
    testpypi

[pypi]
username = __token__
password = pypi-your-api-token-here

[testpypi]
repository = https://test.pypi.org/legacy/
username = __token__
password = pypi-your-testpypi-api-token-here
```

### Publish to TestPyPI (Recommended First)

1. Upload to TestPyPI:
```bash
twine upload --repository testpypi dist/*
```

2. Test installation from TestPyPI:
```bash
uv pip install --index-url https://test.pypi.org/simple/ --extra-index-url https://pypi.org/simple/ yahoo-finance-mcp
```

3. Test the package works:
```bash
yahoo-finance-mcp
```

### Publish to PyPI (Production)

Once you've verified everything works on TestPyPI:

```bash
twine upload dist/*
```

### Verify Publication

1. Check the package page:
   - https://pypi.org/project/yahoo-finance-mcp/

2. Test installation:
```bash
uvx yahoo-finance-mcp-server
```

## Version Management

### Updating the Version

1. Update version in `pyproject.toml`:
```toml
[project]
version = "0.2.0"  # Update this
```

2. Update version in `src/yahoo_finance_mcp_server/__init__.py`:
```python
__version__ = "0.2.0"  # Update this
```

3. Update `CHANGELOG.md` with new changes

4. Commit changes:
```bash
git add .
git commit -m "Bump version to 0.2.0"
git tag v0.2.0
git push origin main --tags
```

### Version Numbering

Follow [Semantic Versioning](https://semver.org/):

- **MAJOR** (1.0.0): Breaking changes
- **MINOR** (0.2.0): New features, backward compatible
- **PATCH** (0.1.1): Bug fixes, backward compatible

## Automated Publishing with GitHub Actions

Create `.github/workflows/publish.yml`:

```yaml
name: Publish to PyPI

on:
  release:
    types: [published]

jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Install uv
        uses: astral-sh/setup-uv@v1

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.12'

      - name: Build package
        run: uv build

      - name: Publish to PyPI
        env:
          TWINE_USERNAME: __token__
          TWINE_PASSWORD: ${{ secrets.PYPI_API_TOKEN }}
        run: |
          uv pip install twine
          twine upload dist/*
```

Add your PyPI API token as a GitHub secret named `PYPI_API_TOKEN`.

## Pre-release Checklist

Before publishing a new version:

- [ ] All tests pass: `pytest`
- [ ] Code is formatted: `black src/`
- [ ] Linting passes: `ruff check src/`
- [ ] Version numbers updated in all files
- [ ] CHANGELOG.md updated
- [ ] README.md is up to date
- [ ] Built locally and tested
- [ ] Tested on TestPyPI
- [ ] Git tags created
- [ ] GitHub release created (optional)

## Common Issues

### Issue: Build fails with missing dependencies
**Solution**: Install build dependencies: `uv pip install build hatchling`

### Issue: Upload fails with "File already exists"
**Solution**: Increment the version number - you cannot overwrite existing versions

### Issue: Package installs but command not found
**Solution**: Check `[project.scripts]` in `pyproject.toml` is correct

### Issue: Import errors after installation
**Solution**: Verify package structure matches `[tool.hatch.build.targets.wheel]` config

## Resources

- [Python Packaging Guide](https://packaging.python.org/)
- [uv Documentation](https://github.com/astral-sh/uv)
- [Hatchling Documentation](https://hatch.pypa.io/latest/)
- [Semantic Versioning](https://semver.org/)
