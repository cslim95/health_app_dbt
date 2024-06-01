select
    {{
        dbt_utils.generate_surrogate_key([
            'user_id',
            'date'
        ])
    }} as vms_entry_id,
    user_id,
    date,
    vms,
    dosage,
    unit
from
    diaries.vms_raw