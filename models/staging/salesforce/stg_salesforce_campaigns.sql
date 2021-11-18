SELECT
    id,
    Name,
    RecordTypeID, 
    Status,
    Type,
    StartDate,
    EndDate,
    Start_Date_Time__c,
    End_Date_Time__c
  FROM 
    {{ source('salesforce_prod', 'campaign')}}
  WHERE
    Status IN ('In Progress', 'Completed') AND
    (Approval_Status__c = 'Approved' OR (RecordTypeId = '0124000000014ptAAA' AND Approval_Status__c = NULL)) AND
    Format__c != 'Reservation' AND
    IsDeleted = false AND
    IsActive = true