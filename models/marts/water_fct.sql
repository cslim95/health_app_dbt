select 
    water_entry_id,
    stg_users.user_id,
    date,
    
    (number_of_bottles * bottle_volume * bottle.ml) as water_ml

from {{ref('stg_water')}} stg_water

join {{ref('stg_users')}} stg_users
on stg_water.email_address = stg_users.email_address

join {{ref('bottle_conversion')}} bottle
on stg_water.bottle_units = bottle.unit
order by date