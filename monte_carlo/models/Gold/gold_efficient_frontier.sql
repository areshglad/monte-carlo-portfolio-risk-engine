with simulations as (

    select *
    from monte_carlo.default.monte_carlo_simulation_results

),

ranked as (

    select
        *,

        row_number() over (
            order by sharpe_ratio desc
        ) as sharpe_rank,

        row_number() over (
            order by annual_volatility asc
        ) as min_volatility_rank,

        row_number() over (
            order by final_portfolio_value desc
        ) as return_rank

    from simulations

)

select *
from ranked
where sharpe_rank = 1
   or min_volatility_rank = 1
   or return_rank <= 10