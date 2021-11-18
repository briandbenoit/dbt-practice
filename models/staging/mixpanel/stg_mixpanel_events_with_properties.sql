select 
  raw:distinct_id as distinct_id,
  raw:mp_event_name as event_name,
  raw:time as time,
  OBJECT_CONSTRUCT('content_type', raw:contenttitle,
              'content_title', raw:contenttitle,
              'content_id', raw:contentid,
              'emulated', raw:useremulated,
              'region', raw:mp_region,
              'dmrecipientcategories', raw:dmrecipientcategories
              ) as event_properties
from {{ source('prod_mixpanel', 'export') }}