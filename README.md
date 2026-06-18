# Monte Carlo Portfolio Risk Engine

## Executive Summary

The Monte Carlo Portfolio Risk Engine is an end-to-end quantitative finance and risk analytics platform designed to simulate portfolio behavior under thousands of possible market scenarios.

The project combines Python, Databricks, dbt, and Power BI to evaluate portfolio risk, optimize asset allocation, and generate institutional-style investment insights.

The platform applies Modern Portfolio Theory, Monte Carlo Simulation, Value-at-Risk (VaR), Conditional Value-at-Risk (CVaR), Sharpe Ratio Optimization, and Efficient Frontier Analysis to support portfolio construction and risk management decisions.

---

## Business Problem

Portfolio managers must continuously answer several critical questions:

* What is the expected return of a portfolio?
* How much risk does the portfolio carry?
* What is the potential downside during market stress?
* How should capital be allocated across securities?
* Which portfolio allocation provides the best risk-adjusted return?

Traditional spreadsheet-based analysis often struggles to scale and cannot efficiently evaluate thousands of future market scenarios.

This project demonstrates how quantitative analytics can support institutional investment decision-making.

---

## Technology Stack

### Analytics

* Python
* Pandas
* NumPy

### Data Platform

* Databricks
* Delta Lake

### Analytics Engineering

* dbt Core
* Medallion Architecture

### Business Intelligence

* Power BI

### Version Control

* Git
* GitHub

---

## Portfolio Universe

The project evaluates a portfolio consisting of:

* HDFCBANK.NS
* INFY.NS
* ITC.NS
* RELIANCE.NS

Historical market data is transformed into return series used for portfolio analytics and simulation.

---

## Risk Metrics Calculated

### Daily Returns

Measures daily percentage change in asset prices.

### Annualized Return

Measures expected yearly portfolio growth.

### Annualized Volatility

Measures portfolio risk and return variability.

### Sharpe Ratio

Evaluates risk-adjusted performance.

### Maximum Drawdown

Measures the largest peak-to-trough decline.

### Correlation Matrix

Measures relationships between securities.

### Value-at-Risk (VaR)

Estimates potential portfolio loss under normal market conditions.

### Conditional Value-at-Risk (CVaR)

Measures average loss beyond the VaR threshold.

---

## Monte Carlo Simulation

The project generates 10,000 portfolio simulations.

For each simulation:

* Random portfolio weights are generated
* Expected portfolio return is calculated
* Portfolio volatility is calculated
* Sharpe Ratio is calculated

This approach allows evaluation of thousands of potential portfolio allocations.

---

## Portfolio Optimization

### Maximum Sharpe Portfolio

Identifies the portfolio allocation with the highest risk-adjusted return.

Results:

* Return: 4.72%
* Volatility: 19.01%
* Sharpe Ratio: 0.248

Portfolio Allocation:

* HDFCBANK.NS: 4.24%
* INFY.NS: 0.52%
* ITC.NS: 7.31%
* RELIANCE.NS: 87.93%

### Minimum Variance Portfolio

Identifies the portfolio with the lowest overall volatility.

Results:

* Return: -0.02%
* Volatility: 13.48%

Portfolio Allocation:

* HDFCBANK.NS: 28.49%
* INFY.NS: 18.26%
* ITC.NS: 34.98%
* RELIANCE.NS: 18.27%

---

## Databricks Architecture

Raw market data is stored within Databricks and transformed through a Medallion Architecture framework.

### Bronze Layer

Standardized raw market data.

### Silver Layer

Business-ready calculations:

* Daily Returns
* Rolling Volatility
* Correlation Metrics

### Gold Layer

Executive-level risk analytics:

* Portfolio Metrics
* Risk Summaries
* Optimization Outputs

---

## Power BI Dashboard

### Page 1 – Executive Risk Overview

* Annual Return
* Annual Volatility
* Sharpe Ratio
* VaR
* CVaR
* Maximum Drawdown

### Page 2 – Portfolio Optimization

* Efficient Frontier
* Maximum Sharpe Portfolio
* Minimum Variance Portfolio

### Page 3 – Risk Analytics

* Rolling Volatility
* Correlation Analysis
* Return Distribution

### Page 4 – Diversification Analysis

* Portfolio Allocation
* Asset Comparison
* Portfolio Risk Summary

---

## Key Outcomes

* Built a production-style quantitative risk analytics platform
* Implemented Monte Carlo portfolio simulation
* Generated 10,000 portfolio scenarios
* Evaluated VaR and CVaR risk measures
* Optimized portfolio allocation using Sharpe Ratio
* Delivered executive dashboards for investment decision support
* Implemented Databricks and dbt Medallion Architecture

---

## Future Enhancements

Potential future improvements include:

* Alpha Analysis
* Beta Analysis
* Sortino Ratio
* Calmar Ratio
* ESG Portfolio Screening
* Real-Time Market Data Integration
* Automated Portfolio Rebalancing

---

## Author

G Aresh

MBA Candidate (2027)

Target Roles:

* Goldman Sachs New Analyst
* Asset Management Analyst
* Portfolio Analytics
* Risk Analytics
* Quantitative Analytics
