import pandas as pd
import numpy as np
from databricks import sql

# =============================
# CONFIGURATION
# =============================


INITIAL_PORTFOLIO_VALUE = 1_000_000
NUM_SIMULATIONS = 500   # First test with 500. Later change to 10000.
TRADING_DAYS = 252
RISK_FREE_RATE = 0.02

QUERY = """
SELECT
    date,
    ticker,
    daily_return
FROM monte_carlo.default.gold_covariance_input
WHERE daily_return IS NOT NULL
"""


# =============================
# CONNECT TO DATABRICKS
# =============================

print("Connecting to Databricks...")

connection = sql.connect(
    server_hostname=SERVER_HOSTNAME,
    http_path=HTTP_PATH,
    access_token=ACCESS_TOKEN
)

print("Connected successfully.")


# =============================
# READ DATA
# =============================

print("Reading gold_covariance_input table...")

returns_df = pd.read_sql(QUERY, connection)

print(f"Rows loaded: {len(returns_df)}")

if returns_df.empty:
    raise ValueError("No data loaded from Databricks. Check table path.")


# =============================
# PREPARE RETURNS MATRIX
# =============================

print("Preparing return matrix...")

returns_matrix = returns_df.pivot(
    index="date",
    columns="ticker",
    values="daily_return"
).dropna()

tickers = returns_matrix.columns.tolist()

print(f"Tickers used: {tickers}")
print(f"Trading days after cleaning: {len(returns_matrix)}")

mean_returns = returns_matrix.mean().values
cov_matrix = returns_matrix.cov().values


# =============================
# MONTE CARLO SIMULATION
# =============================

print("Running Monte Carlo simulation...")

simulation_results = []

for i in range(10000):

    if i % 100 == 0:
        print(f"Completed {i} simulations...")

    weights = np.random.random(len(tickers))
    weights = weights / np.sum(weights)

    simulated_daily_returns = np.random.multivariate_normal(
        mean_returns,
        cov_matrix,
        TRADING_DAYS
    )

    portfolio_daily_returns = simulated_daily_returns @ weights

    final_value = INITIAL_PORTFOLIO_VALUE * np.prod(
        1 + portfolio_daily_returns
    )

    annual_return = np.mean(portfolio_daily_returns) * 252
    annual_volatility = np.std(portfolio_daily_returns) * np.sqrt(252)

    sharpe_ratio = (
        (annual_return - RISK_FREE_RATE) / annual_volatility
        if annual_volatility != 0
        else 0
    )

    var_95 = np.percentile(portfolio_daily_returns, 5)
    cvar_95 = portfolio_daily_returns[
        portfolio_daily_returns <= var_95
    ].mean()

    result = {
        "simulation_id": i + 1,
        "final_portfolio_value": float(final_value),
        "annual_return": float(annual_return),
        "annual_volatility": float(annual_volatility),
        "sharpe_ratio": float(sharpe_ratio),
        "var_95": float(var_95),
        "cvar_95": float(cvar_95)
    }

    for ticker, weight in zip(tickers, weights):
        clean_ticker = ticker.lower().replace(".", "_")
        result[f"weight_{clean_ticker}"] = float(weight)

    simulation_results.append(result)


# =============================
# SAVE RESULTS
# =============================

print("Saving results to CSV...")

results_df = pd.DataFrame(simulation_results)

results_df.to_csv(
    "monte_carlo_simulation_results.csv",
    index=False
)

print("Simulation completed successfully.")
print(results_df.head())

connection.close()
print("Connection closed.")