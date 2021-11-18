select 
    id,
    nickname,
    firstname,
    lastname,
    employername,
    primarygroupid,
    salesforceid,
    personcategory
from {{ source('prod_w50postgres','person')}}