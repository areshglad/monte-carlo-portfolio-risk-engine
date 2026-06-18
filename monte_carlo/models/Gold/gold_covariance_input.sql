select

    date,
    ticker,
    daily_return

from {{ ref('silver_daily_returns') }}

where daily_return is not null