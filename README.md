# Yahoo Finance MCP Server

A Model Context Protocol (MCP) server that provides access to Yahoo Finance data. This server enables AI assistants to fetch real-time stock prices, financial statements, news, options data, and more through a standardized interface.

## Features

- **Historical Stock Prices**: Get historical price data with customizable periods and intervals
- **Stock Information**: Access comprehensive stock data including financials, metrics, and company info
- **Financial Statements**: Retrieve income statements, balance sheets, and cash flow statements
- **News**: Fetch latest news articles for any ticker
- **Options Data**: Get option chains, expiration dates, and options analytics
- **Holder Information**: Access institutional, mutual fund, and insider holder data
- **Analyst Recommendations**: Get analyst ratings, upgrades, and downgrades
- **Corporate Actions**: Track dividends and stock splits

## Installation

### Using uvx (Recommended)

The easiest way to use this MCP server is with `uvx`, which runs it directly without installation:

```bash
uvx yahoo-finance-mcp-server
```

### Using uv

Install the package using `uv`:

```bash
uv pip install yahoo-finance-mcp-server-server
```

### Using pip

```bash
pip install yahoo-finance-mcp-server
```

### From Source

```bash
git clone https://github.com/laxmimerit/yahoo-finance-mcp-server.git
cd yahoo-finance-mcp-server
uv pip install -e .
```

## Configuration

### Claude Desktop Configuration

Add this to your Claude Desktop configuration file:

**MacOS**: `~/Library/Application Support/Claude/claude_desktop_config.json`
**Windows**: `%APPDATA%\Claude\claude_desktop_config.json`

#### Using uvx (Recommended):

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

#### Using uv:

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

#### Using Python directly:

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

### Other MCP Clients

For other MCP clients that support stdio transport, you can run:

```bash
yahoo-finance-mcp
```

Or with uvx:

```bash
uvx yahoo-finance-mcp-server
```

## Available Tools

### 1. get_historical_stock_prices

Get historical stock prices for a ticker symbol.

**Parameters:**
- `ticker` (str): Stock ticker symbol (e.g., "AAPL")
- `period` (str, optional): Valid periods: 1d, 5d, 1mo, 3mo, 6mo, 1y, 2y, 5y, 10y, ytd, max. Default: "1mo"
- `interval` (str, optional): Valid intervals: 1m, 2m, 5m, 15m, 30m, 60m, 90m, 1h, 1d, 5d, 1wk, 1mo, 3mo. Default: "1d"

**Example:**
```
Get historical prices for Apple stock over the last year
```

### 2. get_stock_info

Get comprehensive stock information including price, company details, financial metrics, and more.

**Parameters:**
- `ticker` (str): Stock ticker symbol (e.g., "TSLA")

**Example:**
```
Get detailed information about Tesla stock
```

### 3. get_yahoo_finance_news

Get latest news articles for a ticker symbol.

**Parameters:**
- `ticker` (str): Stock ticker symbol (e.g., "GOOGL")

**Example:**
```
Get recent news about Google
```

### 4. get_stock_actions

Get dividend and stock split history.

**Parameters:**
- `ticker` (str): Stock ticker symbol (e.g., "MSFT")

**Example:**
```
Get dividend history for Microsoft
```

### 5. get_financial_statement

Get financial statements (income statement, balance sheet, or cash flow).

**Parameters:**
- `ticker` (str): Stock ticker symbol (e.g., "AMZN")
- `financial_type` (str): One of: `income_stmt`, `quarterly_income_stmt`, `balance_sheet`, `quarterly_balance_sheet`, `cashflow`, `quarterly_cashflow`

**Example:**
```
Get Amazon's quarterly income statement
```

### 6. get_holder_info

Get holder and ownership information.

**Parameters:**
- `ticker` (str): Stock ticker symbol (e.g., "NVDA")
- `holder_type` (str): One of: `major_holders`, `institutional_holders`, `mutualfund_holders`, `insider_transactions`, `insider_purchases`, `insider_roster_holders`

**Example:**
```
Get institutional holders of NVIDIA
```

### 7. get_option_expiration_dates

Get available options expiration dates for a ticker.

**Parameters:**
- `ticker` (str): Stock ticker symbol (e.g., "SPY")

**Example:**
```
Get option expiration dates for SPY
```

### 8. get_option_chain

Get option chain data for calls or puts.

**Parameters:**
- `ticker` (str): Stock ticker symbol (e.g., "AAPL")
- `expiration_date` (str): Expiration date in YYYY-MM-DD format
- `option_type` (str): Either "calls" or "puts"

**Example:**
```
Get Apple call options expiring on 2024-12-20
```

### 9. get_recommendations

Get analyst recommendations and upgrades/downgrades.

**Parameters:**
- `ticker` (str): Stock ticker symbol (e.g., "META")
- `recommendation_type` (str): Either "recommendations" or "upgrades_downgrades"
- `months_back` (int, optional): Number of months to look back. Default: 12

**Example:**
```
Get recent analyst upgrades for Meta
```

## Usage Examples

Once configured with Claude Desktop or another MCP client, you can ask questions like:

- "What's the current price of Apple stock?"
- "Show me Tesla's quarterly revenue for the last year"
- "Get the latest news about Microsoft"
- "What are the dividend payments for Coca-Cola?"
- "Show me the institutional holders of NVIDIA"
- "Get Amazon's balance sheet"
- "What options are available for SPY?"
- "Show me recent analyst upgrades for Google"

## Development

### Setup Development Environment

```bash
# Clone the repository
git clone https://github.com/laxmimerit/yahoo-finance-mcp-server.git
cd yahoo-finance-mcp

# Install with development dependencies
uv pip install -e ".[dev]"
```

### Running Tests

```bash
pytest
```

### Code Formatting

```bash
black src/
ruff check src/
```

## Technical Details

- **Protocol**: Model Context Protocol (MCP)
- **Transport**: stdio
- **Data Source**: Yahoo Finance via yfinance library
- **Response Format**: JSON

## Requirements

- Python 3.10 or higher
- Dependencies:
  - fastmcp >= 0.3.0
  - yfinance >= 0.2.40
  - pandas >= 2.0.0

## Limitations

- Data is provided by Yahoo Finance and subject to their terms of service
- Real-time data may have delays depending on your subscription level
- Some data may not be available for all ticker symbols
- Intraday data is limited to the last 60 days

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Disclaimer

This software is for informational purposes only. It should not be considered financial advice. Always do your own research before making investment decisions.

## Support

If you encounter any issues or have questions:
- Open an issue on GitHub
- Check existing issues for solutions
- Consult the MCP documentation at https://modelcontextprotocol.io

## Acknowledgments

- Built with [FastMCP](https://github.com/jlowin/fastmcp)
- Data provided by [yfinance](https://github.com/ranaroussi/yfinance)
- Implements the [Model Context Protocol](https://modelcontextprotocol.io)
