select
    {{
        dbt_utils.generate_surrogate_key([
            'email_address',
            'date'
        ])
    }} AS water_entry_id,
    email_address,
    timestamp,
    date,
    number_of_bottles,
    bottle_volume,
    bottle_units
from
    diaries.water_diary_raw