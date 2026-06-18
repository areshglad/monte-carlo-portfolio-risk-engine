with returns as (

    select *
    from {{ ref('silver_daily_returns') }}

),

risk_metrics as (

    select

        ticker,

        avg(daily_return) * 252 as annual_return,

        stddev(daily_return) * sqrt(252) as annual_volatility,

        (
            avg(daily_return) * 252
        ) / nullif(
            stddev(daily_return) * sqrt(252), 0
        ) as sharpe_ratio,

        min(daily_return) as worst_daily_return,

        max(daily_return) as best_daily_return,

        count(*) as trading_days

    from returns

    group by ticker

)

select *
from risk_metrics