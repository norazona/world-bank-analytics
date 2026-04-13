with base as (
    select * from {{ ref('stg_world_bank__indicators') }}
),
-- Filter to the most important indicators and pivot them
pivoted as (
    select
        country_id,
        country_name,
        year,

        max(case when indicator_id = 'NY.GDP.MKTP.CD'   then indicator_value end) as gdp_current_usd,
        max(case when indicator_id = 'NY.GDP.PCAP.CD'   then indicator_value end) as gdp_per_capita_usd,
        max(case when indicator_id = 'SP.POP.TOTL'      then indicator_value end) as population_total,
        max(case when indicator_id = 'SP.DYN.LE00.IN'   then indicator_value end) as life_expectancy_years,
        max(case when indicator_id = 'SE.ADT.LITR.ZS'   then indicator_value end) as literacy_rate_pct,
        max(case when indicator_id = 'SL.UEM.TOTL.ZS'   then indicator_value end) as unemployment_rate_pct

    from base
    group by 1, 2, 3
)
select * from pivoted