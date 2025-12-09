# Quick Start Guide

Get up and running with Yahoo Finance MCP Server in minutes!

## Prerequisites

- Python 3.10 or higher
- [uv](https://github.com/astral-sh/uv) package manager (recommended)

## Install uv (if not already installed)

### macOS/Linux:
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### Windows:
```powershell
irm https://astral.sh/uv/install.ps1 | iex
```

## Quick Installation

### Option 1: Using uvx (No Installation Required)

The fastest way to try it out:

```bash
uvx yahoo-finance-mcp-server
```

This runs the server directly without installing anything permanently!

### Option 2: Install with uv

```bash
uv pip install yahoo-finance-mcp-server-server
```

### Option 3: Install from source

```bash
git clone https://github.com/laxmimerit/yahoo-finance-mcp-server.git
cd yahoo-finance-mcp-server
uv pip install -e .
```

## Configure Claude Desktop

1. Open your Claude Desktop config file:
   - **macOS**: `~/Library/Application Support/Claude/claude_desktop_config.json`
   - **Windows**: `%APPDATA%\Claude\claude_desktop_config.json`

2. Add this configuration:

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

3. Restart Claude Desktop

4. Look for the 🔌 icon in Claude to confirm the server is connected

## Try It Out!

Ask Claude questions like:

- "What's Apple's current stock price?"
- "Show me Tesla's revenue for the last 4 quarters"
- "Get the latest news about Microsoft"
- "What dividends has Coca-Cola paid this year?"
- "Show me Amazon's balance sheet"

## Available Commands

Once the server is connected, you can:

- Get historical stock prices with custom date ranges
- Fetch real-time stock information
- Read latest financial news
- View financial statements (income, balance sheet, cash flow)
- Check dividend and split history
- See institutional and insider holdings
- Get options data and analytics
- View analyst recommendations

## Troubleshooting

### Server not connecting?

1. Verify uv is installed: `uv --version`
2. Check the config file syntax is valid JSON
3. Restart Claude Desktop completely
4. Check Claude Desktop's logs for errors

### Command not found?

Make sure uv is in your PATH:
```bash
echo $PATH  # macOS/Linux
echo %PATH%  # Windows
```

### Python version issues?

Check your Python version:
```bash
python --version  # Should be 3.10+
```

## Next Steps

- Read the full [README.md](README.md) for detailed documentation
- Check out [CONTRIBUTING.md](CONTRIBUTING.md) to contribute
- Report issues on GitHub

## Support

- GitHub Issues: https://github.com/laxmimerit/yahoo-finance-mcp-server/issues
- MCP Documentation: https://modelcontextprotocol.io

Happy trading! 📈
