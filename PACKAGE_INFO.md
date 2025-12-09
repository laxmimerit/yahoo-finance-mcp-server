# Yahoo Finance MCP Server - Package Information

## Package Structure

```
yahoo-finance-mcp-server/
├── src/
│   └── yahoo_finance_mcp_server/
│       ├── __init__.py          # Package initialization
│       └── server.py            # Main MCP server implementation
├── tests/
│   ├── __init__.py
│   └── test_server.py           # Basic tests
├── .claude/
│   └── settings.local.json      # Claude Code settings
├── pyproject.toml               # Package metadata and dependencies
├── README.md                    # Main documentation
├── LICENSE                      # MIT License
├── .gitignore                   # Git ignore patterns
├── .python-version              # Python version (3.12)
├── MANIFEST.in                  # Package manifest
├── CHANGELOG.md                 # Version history
├── CONTRIBUTING.md              # Contribution guidelines
├── QUICKSTART.md                # Quick start guide
├── BUILD.md                     # Build and publish instructions
├── claude_desktop_config.example.json  # Example config
└── uv.lock                      # uv lock file (auto-generated)
```

## Key Files

### pyproject.toml
- Package name: `yahoo-finance-mcp-server`
- Entry point: `yahoo-finance-mcp-server` command
- Dependencies: fastmcp, yfinance, pandas
- Build system: Hatchling
- Python requirement: >=3.10

### src/yahoo_finance_mcp_server/server.py
- Main server implementation
- 10 MCP tools for Yahoo Finance data
- Entry point: `main()` function

### src/yahoo_finance_mcp_server/__init__.py
- Package version: 0.1.0
- Exports: main function

## Installation Methods

### 1. uvx (Run without installation)
```bash
uvx yahoo-finance-mcp-server
```

### 2. uv (Install)
```bash
uv pip install yahoo-finance-mcp-server
```

### 3. pip (Traditional)
```bash
pip install yahoo-finance-mcp
```

### 4. From source (Development)
```bash
git clone <repo-url>
cd yahoo-finance-mcp
uv pip install -e .
```

## Running the Server

### As a command
```bash
yahoo-finance-mcp-server
```

### As a module
```bash
python -m yahoo_finance_mcp_server.server
```

### With uvx
```bash
uvx yahoo-finance-mcp-server
```

### With uv run
```bash
uv run yahoo-finance-mcp-server
```

## Claude Desktop Configuration

### Using uvx (recommended)
```json
{
  "mcpServers": {
    "yahoo-finance": {
      "command": "uvx",
      "args": ["yahoo-finance-mcp-server"]
    }
  }
}
```

### Using uv
```json
{
  "mcpServers": {
    "yahoo-finance": {
      "command": "uv",
      "args": ["run", "yahoo-finance-mcp-server"]
    }
  }
}
```

### Using python directly
```json
{
  "mcpServers": {
    "yahoo-finance": {
      "command": "python",
      "args": ["-m", "yahoo_finance_mcp_server.server"]
    }
  }
}
```

## MCP Tools Provided

1. **get_historical_stock_prices** - Historical price data
2. **get_stock_info** - Comprehensive stock information
3. **get_yahoo_finance_news** - Latest news articles
4. **get_stock_actions** - Dividends and splits
5. **get_financial_statement** - Financial statements
6. **get_holder_info** - Holder/ownership data
7. **get_option_expiration_dates** - Options expiration dates
8. **get_option_chain** - Options chain data
9. **get_recommendations** - Analyst recommendations

## Building the Package

```bash
# Clean previous builds
rm -rf dist/ build/ *.egg-info

# Build with uv
uv build

# Or with build module
python -m build
```

This creates:
- `dist/yahoo_finance_mcp_server-0.1.0-py3-none-any.whl`
- `dist/yahoo_finance_mcp_server-0.1.0.tar.gz`

## Publishing to PyPI

### Test on TestPyPI first
```bash
twine upload --repository testpypi dist/*
```

### Publish to PyPI
```bash
twine upload dist/*
```

## Development Commands

```bash
# Install in development mode
uv pip install -e ".[dev]"

# Format code
black src/

# Lint code
ruff check src/

# Run tests
pytest

# Run tests with coverage
pytest --cov=yahoo_finance_mcp_server
```

## Version Management

Current version: **0.1.0**

To update:
1. Update `pyproject.toml` → `[project] version`
2. Update `src/yahoo_finance_mcp_server/__init__.py` → `__version__`
3. Update `CHANGELOG.md`
4. Commit and tag: `git tag v0.1.0`

## Dependencies

### Runtime
- `fastmcp>=0.3.0` - MCP server framework
- `yfinance>=0.2.40` - Yahoo Finance API
- `pandas>=2.0.0` - Data manipulation

### Development
- `pytest>=7.0.0` - Testing framework
- `pytest-asyncio>=0.21.0` - Async test support
- `black>=23.0.0` - Code formatting
- `ruff>=0.1.0` - Linting

## License

MIT License - See LICENSE file

## Links

- PyPI: https://pypi.org/project/yahoo-finance-mcp-server/
- GitHub: https://github.com/laxmimerit/yahoo-finance-mcp-server
- Issues: https://github.com/laxmimerit/yahoo-finance-mcp-server/issues
- MCP Docs: https://modelcontextprotocol.io

## Support

For issues, questions, or contributions:
1. Check existing GitHub issues
2. Read CONTRIBUTING.md
3. Open a new issue with details

## Next Steps

1. **Test locally**: `uvx yahoo-finance-mcp-server`
2. **Configure Claude Desktop**: See QUICKSTART.md
3. **Build package**: See BUILD.md
4. **Publish to PyPI**: See BUILD.md
5. **Contribute**: See CONTRIBUTING.md
