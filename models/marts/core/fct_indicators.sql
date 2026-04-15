with indicators as (
    select * from {{ ref('int_world_bank__economic_indicators_pivoted') }}
),

dim_countries as (
    select * from {{ ref('dim_countries') }}
)

select
    -- surrogate key for the fact row
    {{ dbt_utils.generate_surrogate_key(['i.country_id', 'i.year']) }} as indicator_sk,

    -- foreign keys
    c.country_sk,

    -- degenerate dimensions
    i.country_id,
    i.year,

    -- measures
    i.gdp_per_capita_usd_constant,
    i.gdp_per_capita_usd_unadjusted,
    i.gni_per_capita_constant,
    i.gni_per_capita_unadjusted,
    i.gini_index,
    i.poverty_headcount_ratio,
    i.unemployment_rate,
    i.labor_participation,
    i.total_population,
    i.income_share_lowest_20_pct

from indicators i
left join dim_countries c using (country_id)