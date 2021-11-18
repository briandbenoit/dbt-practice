select 
    id,
    salesforceid,
    firstname || ' ' || lastname as name,
    employername,
    -- think about replacing the following with jinja
    count(CASE WHEN event_name = 'Viewed Item Details' AND event_properties:content_type NOT IN ('Room','Event','Profile') THEN 1 END ) as "One Degree Views",
    count(CASE WHEN event_name = 'Post Created' THEN 1 END ) as "One Degree Posts",
    max(CASE WHEN event_name = 'Post Created' THEN TO_TIMESTAMP(time) END ) as "Last Post",
    count(CASE WHEN event_name = 'Reply Created' THEN 1 END ) as "One Degree Comments",
    max(CASE WHEN event_name = 'Reply Created' THEN TO_TIMESTAMP(time) END ) as "Last Comment",
    count(CASE WHEN event_name = 'Voted on Poll' THEN 1 END ) as "Poll Votes",
    max(CASE WHEN event_name = 'Voted on Poll' THEN TO_TIMESTAMP(time) END ) as "Last Poll Vote",
    count(CASE WHEN event_name = 'Direct Message Created' AND event_properties:dmrecipientcategories NOT IN ('[\"W50 Staff\"]') THEN 1 END ) as "Messages Sent to Members",
    count(CASE WHEN event_name = 'Direct Message Created' AND event_properties:dmrecipientcategories IN ('[\"W50 Staff\"]') THEN 1 END ) as "Messages Sent to W50",
    count(CASE WHEN event_name IN ('App Launched', 'Launched App') THEN 1 END ) as "Launches",
    max(CASE WHEN event_name IN ('App Launched', 'Launched App') THEN TO_TIMESTAMP(time) END ) as "Last App Use"
from {{ ref('int_mixpanel_with_postgres') }}
group by 1,2,3,4