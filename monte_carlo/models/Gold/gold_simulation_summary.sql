with simulations as (

    select *
    from monte_carlo.default.monte_carlo_simulation_results

),

summary as (

    select

        count(*) as total_simulations,

        avg(final_portfolio_value) as avg_final_portfolio_value,

        min(final_portfolio_value) as worst_final_portfolio_value,

        max(final_portfolio_value) as best_final_portfolio_value,

        avg(annual_return) as avg_annual_return,

        avg(annual_volatility) as avg_annual_volatility,

        max(sharpe_ratio) as best_sharpe_ratio,

        percentile_approx(final_portfolio_value, 0.05) as portfolio_var_95_value,

        avg(
            case
                when final_portfolio_value <= (
                    select percentile_approx(final_portfolio_value, 0.05)
                    from simulations
                )
                then final_portfolio_value
            end
        ) as portfolio_cvar_95_value

    from simulations

)

select *
from summary