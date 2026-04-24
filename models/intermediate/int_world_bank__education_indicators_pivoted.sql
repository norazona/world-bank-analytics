with base as (
    select * from {{ ref('stg_world_bank__indicators') }}
),
-- Filter to the most important indicators and pivot them
pivoted as (
    select
        country_id,
        country_name,
        year,

        max(case when indicator_id = 'SE.ADT.LITR.ZS' then indicator_value end) as adult_literacy_rate,
        max(case when indicator_id = 'SE.PRM.ENRR' then indicator_value end) as primary_school_enrollment,
        max(case when indicator_id = 'SE.SEC.ENRR' then indicator_value end) as secondary_school_enrollment,
        max(case when indicator_id = 'SE.TER.ENRR' then indicator_value end) as tertiary_school_enrollment,
        max(case when indicator_id = 'SE.PRM.CMPT.ZS' then indicator_value end) as primary_completion_rate,
        max(case when indicator_id = 'SE.SEC.CMPT.LO.ZS' then indicator_value end) as lower_secondary_completion_rate,
        max(case when indicator_id = 'SE.PRM.ENRL.TC.ZS' then indicator_value end) as primary_pupil_teacher_ratio


    from base
    group by 1, 2, 3
)
select * from pivoted