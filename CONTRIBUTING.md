# Contributing to Yahoo Finance MCP Server

Thank you for your interest in contributing to the Yahoo Finance MCP Server!

## Development Setup

1. Clone the repository:
```bash
git clone https://github.com/laxmimerit/yahoo-finance-mcp-server.git
cd yahoo-finance-mcp-server
```

2. Install uv if you haven't already:
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

3. Install the package in development mode with dev dependencies:
```bash
uv pip install -e ".[dev]"
```

## Development Workflow

### Making Changes

1. Create a new branch for your feature or bugfix:
```bash
git checkout -b feature/your-feature-name
```

2. Make your changes to the code in `src/yahoo_finance_mcp_server/`

3. Format your code:
```bash
black src/
ruff check src/ --fix
```

4. Test your changes:
```bash
pytest
```

### Running the Server Locally

To test your changes locally:

```bash
python -m yahoo_finance_mcp_server.server
```

Or with uv:

```bash
uv run python -m yahoo_finance_mcp_server.server
```

### Testing with Claude Desktop

1. Update your Claude Desktop config to point to your local development version:

```json
{
  "mcpServers": {
    "yahoo-finance-dev": {
      "command": "uv",
      "args": ["run", "--directory", "/path/to/yahoo-finance-mcp-server", "python", "-m", "yahoo_finance_mcp_server.server"]
    }
  }
}
```

2. Restart Claude Desktop

3. Test your changes through Claude

## Code Style

- Follow PEP 8 guidelines
- Use Black for code formatting (line length: 100)
- Use Ruff for linting
- Write clear, descriptive docstrings
- Add type hints where appropriate

## Adding New Tools

When adding a new tool to the MCP server:

1. Define the tool using the `@yfinance_server.tool()` decorator
2. Add comprehensive docstrings describing parameters and return values
3. Include error handling for invalid tickers and API errors
4. Return data as JSON strings
5. Update the README.md with documentation for the new tool
6. Add the tool to the server instructions in `yfinance_server` initialization

## Testing

- Write tests for new functionality
- Ensure all existing tests pass
- Test error cases and edge cases
- Mock external API calls in tests to avoid rate limits

## Pull Request Process

1. Update the README.md with details of changes if applicable
2. Update the version number in `pyproject.toml` following [Semantic Versioning](https://semver.org/)
3. Ensure all tests pass and code is formatted
4. Create a Pull Request with a clear description of the changes
5. Wait for review and address any feedback

## Reporting Issues

When reporting issues, please include:

- A clear description of the problem
- Steps to reproduce the issue
- Expected vs actual behavior
- Your environment (OS, Python version, etc.)
- Any relevant error messages or logs

## Questions?

Feel free to open an issue for questions or discussions about contributing.

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
