{%- set is_in_person_gathering = "campaign_record_type_id IN (
                '012400000001CHKAA2',
                '012400000001CPTAA2',
                '012400000009c28AAA',
                '012400000001G9mAAE',
                '012400000009c8zAAA'
            )"
%}

{% set is_engage_call = "campaign_record_type_id IN ('0124000000014ptAAA')" %}

{% set is_virtual_summit = "campaign_record_type_id IN ('0124000000014ptAAA')" %}

{% set is_past_event = "end_date < getdate()" %}

{% set was_attended = "(campaign_member_status = 'Attended' or (campaign_member_status = 'RSVP Yes' and end_date < getdate() ) )" %}

{% set will_attend = "campaign_member_status = 'RSVP Yes' and start_date > getdate()" %}

select 
    salesforce_id,
    -- think about replacing the following with jinja
    count(CASE WHEN {{ is_in_person_gathering }}
          AND {{ was_attended }}
          THEN 1 
          END ) as "In-Person Gatherings Attended",
    max(CASE WHEN {{ is_in_person_gathering }}
        AND {{ was_attended }}
        THEN TO_TIMESTAMP(end_date) 
        END ) as "Last In-Person Gathering Attended",
    count(CASE WHEN {{ is_in_person_gathering }}
          AND {{ will_attend }}
          THEN 1 
          END ) as "Upcoming In-Person Gatherings RSVP Yes",
    count(CASE WHEN {{ is_engage_call }}
        THEN 1 END ) as "Engage Calls Attended",
    max(CASE WHEN  {{ is_engage_call }}
        THEN TO_TIMESTAMP(end_date) END ) as "Last Engage Call Attended",
    count(CASE WHEN  {{ is_virtual_summit }}
        THEN 1 END ) as "Virtual Summits Attended",
    max(CASE WHEN {{ is_virtual_summit }}
        THEN TO_TIMESTAMP(end_date) END ) as "Last Virtual Summit Attended"
from {{ ref('int_campaign_activity_identified') }}
group by 1

-- in person gatherings
-- ('012400000001CHKAA2','012400000001CPTAA2','012400000009c28AAA','012400000001G9mAAE','012400000009c8zAAA')

-- engage calls
-- ('0124000000014ptAAA') 

-- virtual summit
-- ('0121W0000001IX7QAM') 