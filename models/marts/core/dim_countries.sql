with countries as (
    select distinct
        country_id,
        country_name
    from {{ ref('stg_world_bank__indicators') }}
)
select
    {{ dbt_utils.generate_surrogate_key(['country_id']) }} as country_sk,
    country_id,
    country_name
from countries