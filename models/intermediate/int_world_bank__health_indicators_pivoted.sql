with base as (
    select * from {{ ref('stg_world_bank__indicators') }}
),
-- Filter to the most important indicators and pivot them
pivoted as (
    select
        country_id,
        country_name,
        year,

        max(case when indicator_id = 'SP.DYN.LE00.IN' then indicator_value end) as life_expectancy_at_birth,
        max(case when indicator_id = 'SP.DYN.IMRT.IN' then indicator_value end) as infant_mortality_rate,
        max(case when indicator_id = 'SH.DYN.MORT' then indicator_value end) as under_5_mortality_rate,
        max(case when indicator_id = 'SH.STA.MMRT' then indicator_value end) as maternal_mortality_rate,
        max(case when indicator_id = 'SP.DYN.CDRT.IN' then indicator_value end) as crude_birth_rate,
        max(case when indicator_id = 'SH.STA.DIAB.ZS' then indicator_value end) as diabetes_prevalence,
        max(case when indicator_id = 'SH.DYN.AIDS.ZS' then indicator_value end) as aids_prevalence,
        max(case when indicator_id = 'SH.TBS.INCD' then indicator_value end) as tuberculosis_incidents


    from base
    group by 1, 2, 3
)
select * from pivoted