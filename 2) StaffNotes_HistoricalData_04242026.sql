use dsc_crts;

insert into StaffNotes(applicationId,subject,body,inuse,lastModifiedBy,lastModifiedDt,isMsgRead,isResolved)
select a.applicationId as applicationId,
snur.Subject as subject,
snur.Body as body,
1 as inuse,
'System' as lastmodifiedby,
getdate() as lastModifiedDt,
1 as isMsgRead,
0 as isResolved
from src.StaffNotesUploadReady_date snur
join tempHistData thd on snur.CR_Reference_number=thd.CRRefNum
join Application a on cast (thd.CRRefNum as nvarchar(255))=a.CRRefNum



insert into StaffNotes(applicationId,subject,body,inuse,lastModifiedBy,lastModifiedDt,isMsgRead,isResolved)
select a.applicationId as applicationId,
snur.Subject as subject,
snur.Body as body,
1 as inuse,
'System' as lastmodifiedby,
getdate() as lastModifiedDt,
1 as isMsgRead,
0 as isResolved
from src.StaffNotesUploadReady_date snur
join tempDCSHB1 thd on snur.CR_Reference_number=thd.CRRefNum
join Application a on cast (thd.CRRefNum as nvarchar(255))=a.CRRefNum


