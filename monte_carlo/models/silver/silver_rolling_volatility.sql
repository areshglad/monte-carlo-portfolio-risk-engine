with returns as (

    select *
    from {{ ref('silver_daily_returns') }}

),

volatility as (

    select
         date,
        ticker,
        daily_return,

        stddev(daily_return) over (
            partition by ticker
            order by date
            rows between 29 preceding and current row
        ) * sqrt(252) as rolling_volatility_30d,

        stddev(daily_return) over (
            partition by ticker
            order by date
            rows between 89 preceding and current row
        ) * sqrt(252) as rolling_volatility_90d

    from returns

)

select *
from volatility
where rolling_volatility_30d is not null