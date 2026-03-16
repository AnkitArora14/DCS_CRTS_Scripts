use DCS_CRTS;


alter table application
add GISCompleteDate datetime2;

alter table application
add CRRecordedDate datetime2;

alter table staff 
add orderId int;

  
  UPDATE staff
SET orderId = sub.rn
--select *
FROM (
    SELECT staffid, ROW_NUMBER() OVER (ORDER BY firstname ASC) AS rn
    FROM staff where inUse=1
) AS sub
WHERE staff.staffid = sub.staffid;





