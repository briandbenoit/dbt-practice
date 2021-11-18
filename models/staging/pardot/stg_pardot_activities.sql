select 
    *
from {{ source('pardot_prod','visitor_activities')}}
where type IN (1,6,11) -- clicked, sent, opened respectively