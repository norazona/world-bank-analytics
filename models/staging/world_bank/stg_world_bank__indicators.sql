with source as (
    select * from {{ source('world_bank_raw', 'worldbank_indicators_raw') }}
),
renamed as (
    select
        -- composite key
        concat(country_code, replace(indicator_id, '.', ''), cast(year as string)) as world_bank_key,
        -- keys
        country_code as country_id,
        indicator_id,
        cast(year as int64) as year,
        -- dimensions
        country_name,
        indicator_name,
        --measures
        cast(value as float64) as indicator_value,
        -- metadata
        load_timestamp as etl_load_timestamp
    from source
    where value is not null -- exclude missing data points
)
select * from renamed