select 
    water_entry_id,
    user_id,
    date,
    n_bottles * bottle_size * bottle.ml as water_ml

from {{ref('stg_water')}} stg_water

join {{ref('bottle_conversion')}} bottle
on stg_water.bottle_unit = bottle.unit
order by date