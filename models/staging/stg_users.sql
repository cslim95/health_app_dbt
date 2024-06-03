select 
    email_address,

    {{
        dbt_utils.generate_surrogate_key(['email_address'])
    }} 
    as user_id,

    min(timestamp) as first_interaction

from (
    -- Add new diary tables into this union
    select email_address, min(timestamp) as timestamp from diaries.water_diary_raw group by email_address

    union all

    select email_address, min(timestamp) as timestamp from diaries.sleep_diary_raw group by email_address

)

group by email_address