with sleep as (
    select 
        email_address,
        timestamp,
        cast(date as date) as date,
        cast(bed_time as time) as bed_time,
        cast(sleep_time as time) as sleep_time,
        cast(wake_time as time) as wake_time,
        blue_light_last_hour,
        quality as sleep_quality
    from diaries.sleep_diary_raw
),

sleep_staging_1 as (
select 
    *,
    datetime(date, wake_time) as wake_timestamp,

    case
        when wake_time > sleep_time then datetime(date, sleep_time)
        else datetime(date_sub(date, interval 1 day), sleep_time)
        end as sleep_timestamp
from sleep
)

select *,

    datetime_diff(sleep_timestamp, wake_timestamp, minute) as sleep_length

from sleep_staging_1
