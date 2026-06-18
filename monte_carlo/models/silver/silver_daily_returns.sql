with prices as (
    select * from {{ ref('bronze_market_prices') }}
),
returns as (

    select

        date,ticker,close,

        lag(close) over (
            partition by ticker
            order by date
        ) as previous_close

    from prices

)

select

    date,ticker,close, previous_close,
    (close - previous_close)
    / previous_close as daily_return

from returns

where previous_close is not null