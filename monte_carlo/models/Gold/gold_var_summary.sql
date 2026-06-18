with returns as (

    select *
    from {{ ref('silver_daily_returns') }}

),

var_base as (

    select

        ticker,

        percentile_approx(daily_return, 0.05) as var_95

    from returns
    group by ticker

),

cvar_base as (

    select

        r.ticker,

        v.var_95,

        avg(r.daily_return) as cvar_95,

        min(r.daily_return) as max_single_day_loss,

        stddev(r.daily_return) * sqrt(252) as annual_volatility

    from returns r

    join var_base v
        on r.ticker = v.ticker

    where r.daily_return <= v.var_95

    group by r.ticker, v.var_95

)

select *
from cvar_base