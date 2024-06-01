select
    {{
        dbt_utils.generate_surrogate_key([
            'user_id',
            'date'
        ])
    }} AS sleep_entry_id,
    user_id,
    CAST(date AS date) AS date,
    CAST(bedtime AS TIME) AS bed_time,
    CAST(sleeptime AS TIME) AS sleep_time,
    CAST(waketime AS TIME) AS wake_time,
    DATETIME(CAST(date AS date), CAST(waketime AS TIME)) AS wake_datetime,
    CASE 
        WHEN TIME_DIFF(CAST(sleeptime AS TIME), CAST(waketime AS TIME), MINUTE) > 0 
        THEN DATETIME(CAST(date AS date), CAST(sleeptime AS TIME)) 
        ELSE DATETIME(DATE_ADD(CAST(date AS date), INTERVAL -1 DAY), CAST(sleeptime AS TIME))
    END 
    AS sleep_datetime,
    bluelightlasthr AS blue_light_last_hour,
    quality AS sleep_quality 
from
    diaries.sleep_raw