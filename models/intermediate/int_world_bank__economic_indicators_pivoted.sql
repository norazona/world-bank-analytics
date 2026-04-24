with base as (
    select * from {{ ref('stg_world_bank__indicators') }}
),
-- Filter to the most important indicators and pivot them
pivoted as (
    select
        country_id,
        country_name,
        year,

        max(case when indicator_id = 'NY.GDP.PCAP.KD' then indicator_value end) as gdp_per_capita_usd_constant,
        max(case when indicator_id = 'NY.GDP.PCAP.CD' then indicator_value end) as gdp_per_capita_usd_unadjusted,
        max(case when indicator_id = 'NY.GNP.PCAP.KD' then indicator_value end) as gni_per_capita_constant,
        max(case when indicator_id = 'NY.GNP.PCAP.CD' then indicator_value end) as gni_per_capita_unadjusted,
        max(case when indicator_id = 'SI.POV.GINI' then indicator_value end) as gini_index,
        max(case when indicator_id = 'SI.POV.DDAY' then indicator_value end) as poverty_headcount_ratio,
        max(case when indicator_id = 'SL.UEM.TOTL.ZS' then indicator_value end) as unemployment_rate,
        max(case when indicator_id = 'SL.TLF.CACT.ZS' then indicator_value end) as labor_participation,
        max(case when indicator_id = 'SP.POP.TOTL' then indicator_value end) as total_population,
        max(case when indicator_id = 'SI.DST.FRST.20' then indicator_value end) as income_share_lowest_20_pct,
        max(case when indicator_id = 'SL.EMP.TOTL.SP.ZS' then indicator_value end) as employment_to_population_ratio


    from base
    group by 1, 2, 3
)
select * from pivoted