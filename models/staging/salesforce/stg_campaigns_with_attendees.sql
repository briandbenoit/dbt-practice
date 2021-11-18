with campaigns as (
    select * from {{ ref('stg_salesforce_campaigns') }}
),
campaign_members as (
    select * from {{ ref('stg_salesforce_campaign_members') }}
)

select 
    campaign_members.id as campaign_member_id,
    campaign_members.status as campaign_member_status,
    contactid as salesforce_id,
    campaignid as campaign_id,
    name as campaign_name,
    campaigns.status as campaign_status,
    start_date_time__c as start_date,
    end_date_time__c as end_date,
    recordtypeid as campaign_record_type_id
from campaign_members
inner join campaigns
on campaigns.id = campaign_members.campaignid