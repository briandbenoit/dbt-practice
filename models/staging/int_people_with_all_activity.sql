with people_with_mixpanel as (
    select * from {{ ref('int_people_with_mixpanel_activity') }}
),
people_with_pardot as (
    select * from {{ ref('int_people_with_pardot_activity') }}
), 
people_with_campaigns as (
    select * from {{ ref('int_people_with_campaign_activity') }}
),
final as (
select 
    *
from
people_with_mixpanel
inner join people_with_pardot
on people_with_mixpanel.salesforceid = people_with_pardot.salesforceid
inner join people_with_campaigns
on people_with_mixpanel.salesforceid = people_with_campaigns.salesforce_id
)

select * from final