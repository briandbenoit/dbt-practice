with pardot_prospects as (
    select 
        *
    from {{ source('pardot_prod','prospects')}}
),
pardot_activities as (
    select 
        *
    from {{ ref('stg_pardot_activities')}}
),
postgres as (
    select * from {{ ref('stg_postgres') }}
),
identified_prospects as (
select 
    pardot_prospects.id as prospectid,
    salesforceid,
    firstname,
    lastname,
    company,
    email
from pardot_prospects
inner join postgres
on postgres.salesforceid = pardot_prospects.crm_contact_fid
)

select 
    salesforceid,
    campaign_id,
    created_at,
    case 
        when pardot_activities.type=6 then 'sent'
        when pardot_activities.type=1 then 'clicked'
        when pardot_activities.type=11 then 'opened'
    end as activity_type,
    updated_at
from
identified_prospects
inner join pardot_activities 
on pardot_activities.prospect_id = prospectid

