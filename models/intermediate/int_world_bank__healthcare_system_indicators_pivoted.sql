with base as (
    select * from {{ ref('stg_world_bank__indicators') }}
),
-- Filter to the most important indicators and pivot them
pivoted as (
    select
        country_id,
        country_name,
        year,

        max(case when indicator_id = 'SH.MED.PHYS.ZS' then indicator_value end) as physicians,
        max(case when indicator_id = 'SH.MED.BEDS.ZS' then indicator_value end) as hospital_beds,
        max(case when indicator_id = 'SH.XPD.CHEX.GD.ZS' then indicator_value end) as health_expenditure,
        max(case when indicator_id = 'SH.XPD.CHEX.PC.CD' then indicator_value end) as health_expenditure_per_capita,
        max(case when indicator_id = 'SH.IMM.MEAS' then indicator_value end) as immunization_measles,
        max(case when indicator_id = 'SH.IMM.IDPT' then indicator_value end) as immunization_dpt,
        max(case when indicator_id = 'SH.H2O.BASW.ZS' then indicator_value end) as people_using_basic_drinking_water_services,
        max(case when indicator_id = 'SH.STA.BASS.ZS' then indicator_value end) as people_using_basic_sanitation_services


    from base
    group by 1, 2, 3
)
select * from pivoted