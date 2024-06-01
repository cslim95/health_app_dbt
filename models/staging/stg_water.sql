select
    {{
        dbt_utils.generate_surrogate_key([
            'user_id',
            'date'
        ])
    }} AS water_entry_id,
    user_id,
    date,
    n_bottles,
    bottle_size,
    bottle_unit 
from
    diaries.water_raw