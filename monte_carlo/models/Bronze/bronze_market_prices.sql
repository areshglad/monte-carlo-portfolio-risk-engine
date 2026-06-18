select
    date,
    ticker,
    open,
    high,
    low,
    close,
    volume
from {{ source('monte_carlo_source', 'raw_market_prices') }}