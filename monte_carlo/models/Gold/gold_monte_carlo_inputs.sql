with returns as (

    select *
    from {{ ref('silver_daily_returns') }}

),

inputs as (

    select

        ticker,

        avg(daily_return) as mean_daily_return,

        stddev(daily_return) as daily_volatility,

        avg(daily_return) * 252 as expected_annual_return,

        stddev(daily_return) * sqrt(252) as expected_annual_volatility,

        count(*) as observation_days

    from returns

    group by ticker

)

select *
from inputs
