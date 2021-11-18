-- produces a row for each event in mixpanel, with details of the related postgres person attached.

with campaign_activity as (
    select * from {{ ref('stg_campaigns_with_attendees') }}
),

postgres as (
    select * from {{ ref('stg_postgres') }}
)

select * from campaign_activity
inner join postgres
on campaign_activity.salesforce_id = postgres.salesforceid
