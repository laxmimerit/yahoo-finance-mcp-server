"""Basic tests for Yahoo Finance MCP Server."""

import json
import os
import subprocess
import sys
from pathlib import Path

import pytest
from yahoo_finance_mcp_server.server import (
    get_historical_stock_prices,
    get_stock_info,
    FinancialType,
    HolderType,
    RecommendationType,
)


class TestEnums:
    """Test enum definitions."""

    def test_financial_type_enum(self):
        """Test FinancialType enum has expected values."""
        assert FinancialType.income_stmt == "income_stmt"
        assert FinancialType.quarterly_income_stmt == "quarterly_income_stmt"
        assert FinancialType.balance_sheet == "balance_sheet"
        assert FinancialType.quarterly_balance_sheet == "quarterly_balance_sheet"
        assert FinancialType.cashflow == "cashflow"
        assert FinancialType.quarterly_cashflow == "quarterly_cashflow"

    def test_holder_type_enum(self):
        """Test HolderType enum has expected values."""
        assert HolderType.major_holders == "major_holders"
        assert HolderType.institutional_holders == "institutional_holders"
        assert HolderType.mutualfund_holders == "mutualfund_holders"
        assert HolderType.insider_transactions == "insider_transactions"
        assert HolderType.insider_purchases == "insider_purchases"
        assert HolderType.insider_roster_holders == "insider_roster_holders"

    def test_recommendation_type_enum(self):
        """Test RecommendationType enum has expected values."""
        assert RecommendationType.recommendations == "recommendations"
        assert RecommendationType.upgrades_downgrades == "upgrades_downgrades"


class TestServerFunctions:
    """Test server function signatures and basic functionality."""

    @pytest.mark.asyncio
    async def test_get_historical_stock_prices_invalid_ticker(self):
        """Test that invalid ticker returns error message."""
        result = await get_historical_stock_prices("INVALIDTICKER123456")
        assert "not found" in result.lower() or "error" in result.lower()

    @pytest.mark.asyncio
    async def test_get_stock_info_invalid_ticker(self):
        """Test that invalid ticker returns error message."""
        result = await get_stock_info("INVALIDTICKER123456")
        assert "not found" in result.lower() or "error" in result.lower()


SRC = Path(__file__).resolve().parent.parent / "src"


class TestStdioTransport:
    """stdout is the JSON-RPC channel on stdio, so nothing else may be written to it."""

    def test_stdout_carries_only_json_rpc(self):
        request = {
            "jsonrpc": "2.0",
            "id": 1,
            "method": "initialize",
            "params": {
                "protocolVersion": "2024-11-05",
                "capabilities": {},
                "clientInfo": {"name": "test", "version": "0"},
            },
        }
        proc = subprocess.run(
            [sys.executable, "-c", "from yahoo_finance_mcp_server.server import main; main()"],
            input=json.dumps(request) + "\n",
            capture_output=True,
            text=True,
            timeout=60,
            # unbuffered, so a stray print lands before the reply as it does under uvx
            env={**os.environ, "PYTHONUNBUFFERED": "1", "PYTHONPATH": str(SRC)},
        )
        lines = [line for line in proc.stdout.splitlines() if line.strip()]
        assert lines, proc.stderr
        for line in lines:
            json.loads(line)
        assert json.loads(lines[0])["id"] == 1


# Note: Integration tests with real API calls should be run separately
# and may be subject to rate limiting. These basic tests verify structure.
