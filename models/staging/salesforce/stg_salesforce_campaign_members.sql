SELECT  Id, Status, ContactId, CampaignId
FROM  {{ source('salesforce_prod','campaignmember') }}
WHERE  
IsDeleted = false AND
Status IN ('RSVP Yes', 'Attended', 'Nominated Team Member', 'Attended + Team Member')