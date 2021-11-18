select 
    salesforceid,
    -- think about replacing the following with jinja
    count(CASE WHEN activity_type = 'opened' THEN 1 END ) as "Opens",
    max(CASE WHEN activity_type = 'opened' THEN TO_TIMESTAMP(updated_at) END ) as "Last Open",
    count(CASE WHEN activity_type = 'clicked' THEN 1 END ) as "Clicks",
    max(CASE WHEN activity_type = 'clicked' THEN TO_TIMESTAMP(updated_at) END ) as "Last Click"
from {{ ref('int_pardot_activities_identified') }}
group by 1