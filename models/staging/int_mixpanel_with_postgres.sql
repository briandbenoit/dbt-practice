-- produces a row for each event in mixpanel, with details of the related postgres person attached.

with mixpanel_events as (
    select * from {{ ref('stg_mixpanel_events_with_properties') }}
),

postgres as (
    select * from {{ ref('stg_postgres') }}
)

select * from mixpanel_events
inner join postgres
on mixpanel_events.distinct_id = postgres.id
where mixpanel_events.event_name IN ('Post Created', -- userEmulated = false and region not equal to georgia
                            'Reply Created', -- userEmulated = false and region not equal to georgia
                            'Direct Message Created',
                            'Viewed Item Details', --filter out content types of Event, Profile and Room
                            'Voted on Poll', -- userEmulated = false and region not equal to georgia
                            'App Launched',
                            'Launched App'
                           )
--and postgres.personcategory NOT IN ('W50 Staff', 'Executive Assistant', 'Platform Participant', 'Alumni', 'W50 Former Employee')
